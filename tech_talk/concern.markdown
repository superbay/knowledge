## About ActiveSupport::Concern

### Task Refactor

```ruby
class Bbcom < ActiveRecord::Base
  scope :golden, ->(flag) { where(golden: flag)}
  has_many :page_contents
  
  def contents
  end
  
  def self.draft_version
  end
  
end
```

#### Solution 1: 

```ruby
module Editorial
  module Page1
    def contents
    end
  end
  
  module Page2
    def draft_version
    end
  end
end

class Bbcom < ActiveRecord::Base
  include Editorial::Page1
  extend Editorial::Page2
  scope :golden, ->(flag) { where(golden: flag)}
end

```

#### question1: 
```ruby
module Editorial
  module Page1
    def draft_version
      'page1'
    end
  end
  
  module Page2
    def draft_version
      'page2'
    end
  end
end

class Bbcom < ActiveRecord::Base
  extend Editorial::Page1
  extend Editorial::Page2
  scope :golden, ->(flag) { where(golden: flag)}
end

Bbcom.draft_version
#=> Page1 or Page2 
# reason && How can that happen


Bbcom.singleton_class.ancestors
#=>[Editorial::Page2, Editorial::Page1, Class, Module, Object, Kernel, BasicObject]

Bbcom.draft_version
#=> page2
```

![rubyobjectgraph2](https://f.cloud.github.com/assets/83296/1060191/525175a0-11aa-11e3-9bc8-20bf90f00c40.png)

#### question2: withou extend how can you use include add class methods

```ruby
class Bbcom < ActiveRecord::Base
  extend Editorial::Page1
end

class Bw < ActiveRecord::Base
  self.class.class_eval do
  # what if singleton_class.class_eval
    include Editorial::Page1
  end
end

Bw.singleton_class.ancestors
#=> [Class, Editorial::Page1, Module, Object, Kernel, BasicObject]

Bbcom.singleton_class.ancestors
#=> [Editorial::Page1, Class, Module, Object, Kernel, BasicObject]
```



#### Solution2: mixed in instance method and class method

```ruby

module Editorial
  module Page
    def self.included(base)
      base.extend ClassMethods
      base.class_eval do
        scope :golden, ->(flag) { where(golden: flag) }
      end
    end
    
    def contents
    end

    module ClassMethods
      def draft_version
      end
    end
  end
end

class Bbcom < ActiveRecord::Base
  include Editorial::Page
end

Bbcom.singleton_class.instance_methods.grep /draf/
#=> [:draft_version]

Bbcom.singleton_class.ancestors
#=> [Editorial::Page::ClassMethods, Class, Module, Object, Kernel, BasicObject]

```

### Solution3: ActiveSupport::Concern

```ruby
require 'active_support/concern'

module Editorial
  module Page
    extend ActiveSupport::Concern

    included do
      scope :golden, ->(flag) { where(golden: flag) }
    end
    
    def contents
    end

    module ClassMethods
      def draft_version
      end
    end
  end
end

class Bbcom < ActiveRecord::Base
  include Editorial::Page
end
```

### Task2: draft_version in module's module


### Solution1:

```ruby
module Editorial
  module Page1
    def self.included(base)
      base.class_eval do
        scope :golden, ->(flag) { where(golden: flag) }
      end
    end
    
    module ClassMethods
      def draft_version
      end
    end
  end

  module Page2
    include Page1
    def self.included(base)
      scope :golden, ->(flag) { where(golden: flag) }
    end
  end
end

class Bbcom < ActiveRecord::Base 
  include Editorial::Page1 
  include Editorial::Page2
end

```

### Solution2:

```ruby

require 'active_support/concern'

module Editorial
  module Page1
  extend ActiveSupport::Concern
    included do
      scope :golden, ->(flag) { where(golden: flag) }
    end 
    
    module ClassMethods
      def draft_version
      end
    end
  end

  module Page2
  extend ActiveSupport::Concern
  include Page1
    included do 
      scope :golden, ->(flag) { where(golden: flag) }
    end
  end
end

class Bbcom < ActiveRecord::Base 
  include Editorial::Page2
end

```

### source code

https://github.com/rails/rails/blob/master/activesupport/lib/active_support/concern.rb
http://api.rubyonrails.org/classes/ActiveSupport/Concern.html






