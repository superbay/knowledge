### select_tag



```ruby
select_tag "people", options_from_collection_for_select(@people, "id", "name")
# <select id="people" name="people"><option value="1">David</option></select>

select_tag "people", "<option>David</option>".html_safe
# => <select id="people" name="people"><option>David</option></select>

select_tag "count", "<option>1</option><option>2</option><option>3</option><option>4</option>".html_safe
# => <select id="count" name="count"><option>1</option><option>2</option>
#    <option>3</option><option>4</option></select>

select_tag "colors", "<option>Red</option><option>Green</option><option>Blue</option>".html_safe, multiple: true
# => <select id="colors" multiple="multiple" name="colors[]"><option>Red</option>
#    <option>Green</option><option>Blue</option></select>

select_tag "locations", "<option>Home</option><option selected='selected'>Work</option><option>Out</option>".html_safe
# => <select id="locations" name="locations"><option>Home</option><option selected='selected'>Work</option>
#    <option>Out</option></select>

select_tag "access", "<option>Read</option><option>Write</option>".html_safe, multiple: true, class: 'form_input'
# => <select class="form_input" id="access" multiple="multiple" name="access[]"><option>Read</option>
#    <option>Write</option></select>

select_tag "people", options_from_collection_for_select(@people, "id", "name"), include_blank: true
# => <select id="people" name="people"><option value=""></option><option value="1">David</option></select>

select_tag "people", options_from_collection_for_select(@people, "id", "name"), prompt: "Select something"
# => <select id="people" name="people"><option value="">Select something</option><option value="1">David</option></select>

select_tag "destination", "<option>NYC</option><option>Paris</option><option>Rome</option>".html_safe, disabled: true
# => <select disabled="disabled" id="destination" name="destination"><option>NYC</option>
#    <option>Paris</option><option>Rome</option></select>

select_tag "credit_card", options_for_select([ "VISA", "MasterCard" ], "MasterCard")
# => <select id="credit_card" name="credit_card"><option>VISA</option>
#    <option selected="selected">MasterCard</option></select>

```

### select

```ruby
select("post", "person_id", Person.all.collect {|p| [ p.name, p.id ] }, {include_blank: 'None'})
could become:

<select name="post[person_id]">
  <option value="">None</option>
  <option value="1">David</option>
  <option value="2" selected="selected">Sam</option>
  <option value="3">Tobias</option>
</select>
```

```ruby
<%= f.select(:manufacturer_id, Manufacturer.find(:all).collect {|u| [u.name, u.id]}, :prompt => 'Select') %>
```

could be changed to this:

```ruby
# in app/helpers/manufacturer_helper.rb
def manufacturers_for_select
  Manufacturer.all.collect { |m| [m.name, m.id] }
end

# in the view
<%= f.select(:manufacturer_id, manufacturers_for_select, :prompt => 'Select') %>
#I would look into collection_select though:

<%= f.collection_select(:manufacturer_id, Manufacturer.all, :id, :name, :prompt => 'Select') %>

```

[select api reference](http://api.rubyonrails.org/classes/ActionView/Helpers/FormOptionsHelper.html)

```html

<input type="hidden" name="Language" value="English">

```
