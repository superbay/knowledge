## 5 New Features in Rails 4.1 Beta

[release notes](http://weblog.rubyonrails.org/2013/12/18/Rails-4-1-beta1)

### Active Record Enums

```ruby
class Bug < ActiveRecord::Base
  # Relevant schema change looks like this:
  #
  # create_table :bugs do |t|
  #   t.column :status, :integer, default: 0 # defaults to the first value (i.e. :new)
  # end

  enum status: [ :new, :assigned, :in_progress, :resolved, :rejected, :reopened ]

  belongs_to :assignee, class_name: 'Developer'

  def assignee=(developer)
    if developer && self.new?
      self.status = :assigned
    else
      self.status = :new
    end

    super
  end
end

Bug.resolved           # => a scope to find all resolved bugs
bug.resolved?          # => check if bug has the status :resolved
bug.resolved!          # => update! the bug with status set to :resolved
bug.status             # => a symbol describing the bug's status
bug.status = :resolved # => set the bug's status to :resolved
```
