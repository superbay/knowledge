### association dependent 

In Rails 4.x, it is not possible to have destroy dependency on both sides of a bi-directional association between the two models as it would result in an infinite callback loop causing SystemStackError: stack level too deep.

```ruby
class User < ActiveRecord::Base
  has_one :profile, dependent: :destroy
end


class Profile < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
end

```

Calling User#destroy or Profile#destroy would lead to an infinite callback loop.

```
>> user = User.first
=> <User id: 4, name: "George">

>> user.profile
=> <Profile id: 4>

>> user.destroy
=> DELETE FROM `profiles` WHERE `profiles`.`id` = 4
   ROLLBACK
```
`SystemStackError: stack level too deep`

Rails 5 supports bi-directional destroy dependency without triggering infinite callback loop.


```ruby
>> user = User.first
=> <User id: 4, name: "George">

>> user.profile
=> <Profile id: 4, about: 'Rails developer', works_at: 'ABC'>

>> user.destroy
=> DELETE FROM "profiles" WHERE "posts"."id" = ?  [["id", 4]]
   DELETE FROM "users" WHERE "users"."id" = ?  [["id", 4]]
=> <User id: 4, name: "George">
```

There are many instances like above where we need to destroy an association when it is destroying itself, otherwise it may lead to orphan records.

This feature adds responsibility on developers to ensure adding destroy dependency only when it is required as it can have unintended consequences as shown below.

```
class User < ApplicationRecord
  has_many :posts, dependent: :destroy
end

class Post < ApplicationRecord
  belongs_to :user, dependent: :destroy
end

>> user = User.first
=> <User id: 4, name: "George">

>> user.posts
=> <ActiveRecord::Associations::CollectionProxy [<Post id: 11, title: 'Ruby', user_id: 4>, #<Post id: 12, title: 'Rails', user_id: 4>]>
```


As we can see “user” has two posts. Now we will destroy first post.

```ruby
>> user.posts.first.destroy
=> DELETE FROM "posts" WHERE "posts"."id" = ?  [["id", 11]]
   SELECT "posts".* FROM "posts" WHERE "posts"."user_id" = ?  [["user_id", 4]]
   DELETE FROM "posts" WHERE "posts"."id" = ?  [["id", 12]]
   DELETE FROM "users" WHERE "users"."id" = ?  [["id", 4]]
```

As we can see, we wanted to remove post with id “11”. However post with id “12” also got deleted. Not only that but user record got deleted too.

In Rails 4.x this would have resulted in SystemStackError: stack level too deep .

So we should use this option very carefully.



belongs_to association dependent options
If you set the :dependent option to:

    :destroy, when the object is destroyed, destroy will be called on its associated objects.
    :delete, when the object is destroyed, all its associated objects will be deleted directly from the database without calling their destroy method.



has_on or has_many association dependent options

Controls what happens to the associated objects when their owner is destroyed:

    :destroy causes all the associated objects to also be destroyed
    :delete_all causes all the associated objects to be deleted directly from the database (so callbacks will not execute)
    :nullify causes the foreign keys to be set to NULL. Callbacks are not executed.
    :restrict_with_exception causes an exception to be raised if there are any associated records
    :restrict_with_error causes an error to be added to the owner if there are any associated objects






