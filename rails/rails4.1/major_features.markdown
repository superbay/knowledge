## New Major Features in Rails 4.1 Beta

[release notes](http://weblog.rubyonrails.org/2013/12/18/Rails-4-1-beta1)

### CSRF protection from remote tags


Cross-site request forgery (CSRF) protection now covers GET requests with JavaScript responses, too. That prevents a third-party site from referencing your JavaScript URL and attempting to run it to extract sensitive data.

This means any of your tests that hit .js URLs will now fail CSRF protection unless they use xhr. Upgrade your tests to be explicit about expecting XmlHttpRequests. Instead of post :create, format: :js, switch to the explicit xhr :post, :create, format: :js.

### Spring application preloader

Spring is a Rails application preloader. It speeds up development by keeping your application running in the background so you don't need to boot it every time you run a test, rake task or migration.

New Rails 4.1 applications will ship with "springified" binstubs. This means that bin/rails and bin/rake will automatically take advantage of preloaded spring environments.


```ruby
bin/rake routes
bin/rake test
bin/rake test test/models
bin/rake test test/models/user_test.rb
bin/rails console
```

### config/secrets.yml


Rails 4.1 will generate a new secrets.yml file in the config folder for new applications. By default, this file contains the application's secret_key_base, but it could also be used to store other secrets such as access keys for external APIs.


### Action Pack Variants

[official guide](http://edgeapi.rubyonrails.org/classes/ActionController/MimeResponds.html#method-i-respond_to)

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


```ruby
Conversation.where("status <> ?", Conversation.statuses[:archived])
```


### Application Message Verifier


Create a message verifier that can be used to generate and verify signed messages in the application.


```ruby

message = Rails.application.message_verifier('salt').generate('my sensible data')

Rails.application.message_verifier('salt').verify(message)
# => 'my sensible data'
```

```ruby
class User < ActiveRecord::Base
  class << self
    def verifier_for(purpose)
      @verifiers ||= {}
      @verifiers.fetch(purpose) do |p|
        @verifiers[p] = Rails.application.message_verifier("#{self.name}-#{p.to_s}")
      end
    end

    def find_by_password_reset_token!(token)
      # This raises an exception if the message is modified
      user_id, timestamp = self.class.verifier_for('password-reset').verify(token)

      if timestamp < 1.day.ago
        # Token expired, raise an exception
        ...
      end

      User.find(user_id)
    end
  end

  def password_reset_token
    verifier = self.class.verifier_for('password-reset') # Unique for each type of messages
    verifier.generate([id, Time.now])
  end
end

class PasswordResetsController < ApplicationController
  def create
    user = User.find_by_email!(params[:email])
    Notifier.reset_password(user).deliver
    redirect_to root_url, notice: "Check your email for password reset instructions!"
  end

  def show
    @user = User.find_by_password_reset_token!(params[:token])
  end

  def update
    User.find_by_password_reset_token!(params[:token]).update!(
      password: params[:new_password],
      password_confirmation: params[:new_password_confirmation]
    )

    redirect_to root_url, notice: "Your password has been reset!"
  end
end

class Notifier < ActionMailer::Base
  def reset_password(user)
    @user = user
    @reset_password_url = password_reset_url(token: @user.password_reset_token)
    mail(to: user.email, subject: "Resetting your password")
  end
end
```

### Module#concerning


A natural, low-ceremony way to separate responsibilities within a class:

```ruby
class Todo < ActiveRecord::Base
  concerning :EventTracking do
    included do
      has_many :events
    end
 
    def latest_event
      ...
    end
 
    private
      def some_internal_method
        ...
      end
  end
end
```

This example is equivalent to defining a EventTracking module inline, extending it with ActiveSupport::Concern, then mixing it in to the Todo class.


### removals

Removed deprecated threadsafe! from Rails Config.

Removed deprecated ActiveRecord::Generators::ActiveModel#update_attributes in favor of ActiveRecord::Generators::ActiveModel#update.

Removed deprecated config.whiny_nils option.
