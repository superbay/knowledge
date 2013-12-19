## 5 New Features in Rails 4.1 Beta

[release notes](http://weblog.rubyonrails.org/2013/12/18/Rails-4-1-beta1)


### Action Pack Variants

```ruby
class ApplicationController < ActionController::Base
  before_action :detect_device_variant

  private

    def detect_device_variant
      case request.user_agent
      when /iPad/i
        request.variant = :tablet
      when /iPhone/i
        request.variant = :phone
      end
    end
end

class PostController < ApplicationController
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.json
      format.html               # /app/views/posts/show.html.erb
      format.html.phone         # /app/views/posts/show.html+phone.erb
      format.html.tablet do
        @show_edit_link = false
      end
    end
  end
end

```

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
