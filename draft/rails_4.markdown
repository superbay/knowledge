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
