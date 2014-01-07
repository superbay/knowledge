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

1.9.2p320 :011 > ''.nil?
 => false

1.9.2p320 :012 > ''.empty?
 => true
 
```

empty? only check the [] array. 

blank? and present? can check [] array, nil, and ''


Ruby 2.0.0 have the same behavior only empty can not handle nil

```ruby
2.0.0p353 :001 > ''.blank?                                                                                                                                          
 => true                                                                                                                                                            
2.0.0p353 :002 > ''.present?                                                                                                                                        
 => false                                                                                                                                                           
2.0.0p353 :003 > ''.empty?                                                                                                                                          
 => true                                                                                                                                                            
2.0.0p353 :004 > ''.nil?                                                                                                                                            
 => false                                                                                                                                                           
2.0.0p353 :005 > [].blank?                                                                                                                                          
 => true                                                                                                                                                            
2.0.0p353 :006 > [].present?                                                                                                                                        
 => false                                                                                                                                                           
2.0.0p353 :007 > [].empty?                                                                                                                                          
 => true                                                                                                                                                            
2.0.0p353 :008 > [].nil?                                                                                                                                            
 => false                                                                                                                                                           
2.0.0p353 :009 > nil.blank?                                                                                                                                         
 => true                                                                                                                                                            
2.0.0p353 :010 > nil.present?                                                                                                                                       
 => false                                                                                                                                                           
2.0.0p353 :011 > nil.nil?                                                                                                                                           
 => true                                                                                                                                                            
2.0.0p353 :012 > nil.empty?                                                                                                                                         
NoMethodError: undefined method 'empty?' for nil:NilClass 
```
