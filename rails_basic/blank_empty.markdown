### blank? vs empty? vs present?



```ruby
1.9.2p320 :001 > dd = nil
 => nil
1.9.2p320 :002 > dd.empty?
NoMethodError: undefined method 'empty?' for nil:NilClass

1.9.2p320 :003 > dd.blank?
 => true
1.9.2p320 :004 > dd = []
 => []
1.9.2p320 :005 > dd.blank?
 => true
```
