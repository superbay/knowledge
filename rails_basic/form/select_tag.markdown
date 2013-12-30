### select_tag



```ruby
select_tag "people", options_from_collection_for_select(@people, "id", "name")
# <select id="people" name="people"><option value="1">David</option></select>

select_tag "people", "<option>David</option>".html_safe

```


```html

<input type="hidden" name="Language" value="English">

```
