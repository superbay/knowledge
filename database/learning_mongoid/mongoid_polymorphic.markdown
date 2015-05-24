### mongoid polymorphic relation

```ruby
class Action                                                                                                                           
  include Mongoid::Document                                                                                                            
  include Mongoid::Timestamps::Created                                                                                                 

  field :action, type: Symbol

  belongs_to :subject, :polymorphic => true                                                                                            
end

class User                                                                                                                             
  include Mongoid::Document                                                                                                            
  include Mongoid::Timestamps                                                                                                          
  field :username, type: String
  has_many :actions, :as => :subject   
end

class Company                                                                                                                          
  include Mongoid::Document                                                                                                            
  include Mongoid::Timestamps                                                                                                          

  field :name, type: String                                                                                                            

  has_many :actions, :as => :subject
end
```
