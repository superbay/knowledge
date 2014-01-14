Here is example to hack or meta program of active record

### scope generator


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
