### like query 


arel_table solution

```ruby

User.where(User.arel_table[:name].matches("%#{user_name}%"))

```


normal active record solution

```ruby
Speaker.where("name like ?", "%yson%")

q = "%#{params[:query]}%"
User.where("name like ? or description like ?", q, q).to_sql
```

Here is example to hack or meta program of active record

### Scope Generator


```ruby
#/config/initializers/scope_generator.rb
module ScopeGenerator
  def generate_scopes
    columns.each do |column|
      predicates_for(column).each do |predicate|
        scope "#{column.name}_#{predicate}", ->(value) do
          where(arel_table[column.name].send(predicate, value))
        end
      end
    end
  end

  def predicates_for(column)
    base = [:eq, :not_eq, :in, :not_in]
    case column.type
    when :integer, :float, :decimal, :date, :datetime, :timestamp, :time
      base + [:lt, :lteq, :gt, :gteq]
    when :string, :text
      base + [:matches, :does_not_match]
    else
      base
    end
  end
end

ActiveSupport.on_load :active_record do
  extend ScopeGenerator
end
```

You can call it as below

```ruby
scope :released, -> { released_at_lt(Time.zone.now) }
```


### Scope Operator

```ruby
#/config/initializers/scope_operators.rb
module ScopeOperators
  def or(other)
    left = arel.constraints.reduce(:and)
    right = other.arel.constraints.reduce(:and)
    scope = merge(other)
    scope.where_values = [left.or(right)]
    scope
  end
  alias_method :|, :or

  def not(other)
    left = arel.constraints.reduce(:and)
    right = other.arel.constraints.reduce(:and)
    scope = merge(other)
    scope.where_values = [left, right.not]
    scope
  end
  alias_method :-, :not

  def and(*args)
    merge(*args)
  end
  alias_method :&, :and
end

ActiveSupport.on_load :active_record do
  ActiveRecord::Relation.send(:include, ScopeOperators)
end
```

call it as below:


```ruby
Product.where(id: 1..5) - Product.where(id: 2)
```

### Match Scope

```ruby
/config/initializers/match_scope.rb
module MatchScope
  def match(matches)
    clause = matches.map do |attribute, conditions|
      Array.wrap(conditions).map do |predicates|
        predicates = predicates.kind_of?(Hash) ? predicates : {eq: predicates}
        predicates.map do |predicate, value|
          arel_table[attribute].send(predicate, value)
        end.reduce(:and)
      end.reduce(:or)
    end.reduce(:and)
    where(clause)
  end
end

ActiveSupport.on_load :active_record do
  extend MatchScope
end
```

call it as below:


```ruby
Product.match(stock: [nil, {lt: 3}])
# => Product Load (0.3ms)  SELECT "products".* FROM "products" WHERE (("products"."stock" IS NULL OR "products"."stock" < 3))
```
