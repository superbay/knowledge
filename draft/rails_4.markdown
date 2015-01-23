### strong parameters & patch methods 

```ruby

class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # Some methods omitted.

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:name, :content, :published_at)
    end
end
```

### Gemfile git && github

```ruby
source 'https://rubygems.org'

gem 'rails',     github: 'rails/rails'
gem 'arel',      git: 'git@github.com:rails/arel.git'

```

### lambda scope

```ruby
class Article < ActiveRecord::Base
  scope :sorted, -> { order(:name) }
end

# and also

class Article < ActiveRecord::Base
  scope :sorted, ->(order_type) { order_type == 'up' ? order(name: :up) : order(name: :down) }
end


class User < ActiveRecord::Base
  # Added scopes and associations for fetching account information using status
  has_many :accounts_with, class_name: 'Account' do 
    def status(flag)
      proxy_association.owner.accounts_with.where(["status= ?", flag])
    end
  end
  has_many :active_accounts, class_name: 'Account', conditions: {status: 'active'}
  scope :accounts_with_status , ->(flag){ joins(:accounts).where(["accounts.stauts= :status", status: flag])}#["accounts.status= ?", flag]) }

  #has_many :recent_accounts, class_name: 'Account', conditions: ->{["created_at < :time", time: 10.days.ago]}.call
  
  # Validations for User
  validates_with UserValidator#, on: :create && :update
end
```

some more scope

```ruby
class Client
  scope :by_category, (lambda do |category_id|
    where(category_id: category_id) unless category_id.nil?
  end)
  scope :by_district, (lambda do |district_id|
    where(district_id: district_id) unless district_id.nil?
  end)
end

#if district 是nil就会返回全部
Client.by_category(category).by_district(district)

```

and

```ruby
class User
  scope :by_age, lambda do |age|
    joins(:profile).where('profile.age = ?', age) unless age.nil?
  end
  scope :by_name, lambda{ |name| where(name: name) unless name.nil? }
  scope :by_email, lambda do |email|
    joins(:profile).where('profile.email = ?', email) unless email.nil?
  end
end
```

```ruby
wheres = [:id, :email].map{|key| params.has_key?(key) ? {key => params[key]} : {} }\
                      .inject({}){|hash, injected| hash.merge!(injected)}

@users = User.where(wheres).limit(10)

#user.rb
scope :by_status, lambda { |status| where(:status => status) unless status.blank? }

# If you need to execute a block of code you can use the following syntax
scope :by_status, (lambda do |status|
where(:active => status) unless status.blank?
end)


#Active users
pry(main)> User.by_status(1)
SELECT `users`.* FROM `users` WHERE `users`.`active` = 1

#Inactive users
pry(main)> User.by_status(0)
SELECT `users`.* FROM `users` WHERE `users`.`active` = 0

#All users
pry(main)> User.by_status(nil)
SELECT `users`.* FROM `users`


```

### html.ruby

```ruby

content_tag(:h1, "Edit") + render("form")

```

### routes && concern

```ruby
#config/routes.rb
concern :commentable do
  resources :comments    
end
resources :articles, concerns: :commentable
resources :photos, concerns: :commentable
```

```ruby
get 'foo', to: 'articles#index', constraints: {protocol: "https", subdomain: "test"}

 app.foo_url
#=> "https://test.example.com/foo"
```
