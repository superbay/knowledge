### blank? vs empty? vs present?



```ruby
1.9.2p320 :001 > dd = nil
 => nil
1.9.2p320 :002 > dd.empty?
NoMethodError: undefined method 'empty?' for nil:NilClass

1.9.2p320 :003 > dd.blank?
 => true
 
1.9.2p320 :006 > dd.present?
 => false

1.9.2p320 :004 > dd = []
 => []

1.9.2p320 :005 > dd.blank?
 => true

1.9.2p320 :008 > dd.present?
 => false
 
 
1.9.2p320 :009 > ''.present?
 => false
1.9.2p320 :010 > ''.blank?
 => true
```

empty? only check the [] array. 

blank? and present? can check [] array, nil, and ''
