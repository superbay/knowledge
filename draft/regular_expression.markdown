### regular expression

group

```ruby
>> s = 'Where [0] is [1] pancakes [2] house?'
=> "Where [0] is [1] pancakes [2] house?"
>> a = %w{a b c}
=> ["a", "b", "c"]

>> s.gsub(/\[(\d+)\]/) { a[$1.to_i] }
=> "Where a is b pancakes c house?"

>> s.gsub(/\[(\d+)\]/) { |m| a[m[1].to_i] }
=> "Where a is b pancakes c house?"

>> s.gsub(/\[(?<num>\d+)\]/) { |m| a[m['num'].to_i] }
=> "Where a is a pancakes a house?"
```
verify url
```ruby
require 'uri'
  def tracking_url(summary, date)
    summary.gsub("\'", "\"").gsub URI.regexp do |url|
      connection_mark = url.slice(/\/.*$/).include?('?') ? '&' : '?'
      "#{url}#{connection_mark}#{campaign_id(date)}"
    end
  end
````
### nokogiri

```ruby
  def tracking_url(summary, date)
    doc = Nokogiri::HTML "<div id='track'> #{summary} </div>"

    doc.css("a").each do |link|
      url = link.attributes["href"].value 
      connection_mark = url.slice(/\/.*$/).include?('?') ? '&' : '?'
      link.attributes["href"].value = "#{url}#{connection_mark}#{campaign_id(date)}"
    end
    doc.css('#track').inner_html.to_s
  end
```
