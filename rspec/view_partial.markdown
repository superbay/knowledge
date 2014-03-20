### view partial 


#### using css

verify which have css, such as span with class

```ruby
render partial: 'shared/footer'
rendered.should have_css('a span[class*="icons"]')
rendered.should have_selector('a', {href: 'http://www.icons.com', class: 'icons'})

```


### reference 
Examples:

The following selector represents an HTML object, referencing an image:

```ruby
object[type^="image/"]
```

The following selector represents an HTML anchor a with an href attribute whose value ends with ".html".

```css
a[href$=".html"]
```

The following selector represents an HTML paragraph with a title attribute whose value contains the substring "hello"

```css
p[title*="hello"]
```
[more definition](http://www.w3.org/TR/css3-selectors/#attribute-substrings)

#### general sample


```ruby
require 'spec_helper'

describe 'media/index.html.haml' do

  before :each do 
    ['shared/_seo_metadata.html.haml',
    'lead_cell.html.haml',
    'videos/_featured_list.html.haml',
    'media/_thumbnail_list.html.haml',
    'shared/_ads.html.haml',
    'categories.html.haml',
    'shared/_sponsored_video.html.haml',
    'thumbnail_list.html.haml'].each {|view| stub_template view => ''}
    @presenter = double :presenter
    [:subtitle, :seo_metadata, :lead, :most_recent_content, :most_read_content, :most_shared_content, :most_discussed_content, :image_size].each {|method| @presenter.stub method}
    @presenter.stub_chain :articles, :limit
    @presenter.stub_chain :types, :first, :to_s
  end

  it 'should render 2 ads while media' do
    @ad_page_type = 'media'
    render template: 'media/index', locals: {presenter: @presenter, tabbed_content: []}
    rendered.should have_selector('.companion_ad')
  end
  
  it 'should not render 2 ads while media' do
    @ad_page_type = 'video'
    render template: 'media/index', locals: {presenter: @presenter, tabbed_content: []}
    rendered.should_not have_selector('.companion_ad')
  end
end
```
