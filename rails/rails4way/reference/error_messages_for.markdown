```ruby
class Post
end

Object.const_get("Post")


Use Module.const_get

string = "Fixnum"
clazz = Object.const_get(string)
clazz.name # => "Fixnum"
#If you are in a rails context, you can also use the `#constantize method on string

clazz = string.constantize # => Fixnum


def foo
  a = 1
  b = binding
  b.local_variable_set(:a, 2) # set existing local variable `a'
  b.local_variable_set(:b, 3) # create new local variable `b'
                              # `b' exists only in binding.
  b.local_variable_get(:a) #=> 2
  b.local_variable_get(:b) #=> 3
  p a #=> 2
  p b #=> NameError
end
#As stated in the doc, it is a similar behavior to

binding.eval("#{symbol} = #{obj}")
binding.eval("#{symbol}")

```


```ruby

objs = {
  'foo' => ...,
  'key' => Item.new( :name => "Key", :description => "a key" )
}
objs['jim'] = ...
case some_str
  when /^read (.+)$/
    puts "Reading #{$1}:"
    puts objs[$1].description.downcase
end

```

```ruby

def error_messages_for(*params)
  options = params.extract_options!.symbolize_keys
  
  objects = Array.wrap(options.delete(:object) || params).map do |object| 
    object = instance_variable_get("@#{object}") unless object.respond_to?(:to_model)
    object = convert_to_model(object)
    
    if object.class.respond_to?(:model_name)
      options[:object_name] ||= object.class.model_name.human.downcase
    end
    object
  end
  
  objects.compact!
  count = objects.inject(0) {|sum, object| sum + object.errors.count }

  unless count.zero?
    html = {}
    [:id, :class].each do |key|
      if options.include?(key)
        value = options[key]
        html[key] = value unless value.blank?
      else
        html[key] = 'error_explanation' 
      end
    end
    options[:object_name] ||= params.first
    
    I18n.with_options :locale => options[:locale], :scope => [:activerecord, :errors, :template] do |locale| 
      header_message = if options.include?(:header_message)
        options[:header_message] 
      else
        locale.t :header, :count => count, :model => options[:object_name].to_s.gsub('_', ' ')
      end
      
      message = options.include?(:message) ? options[:message] : locale.t(:body)
      error_messages = objects.sum do |object| 
        object.errors.full_messages.map do |msg|
          content_tag(:li, msg) ]
        end
      end.join.html_safe
      
      contents = ''
      contents << content_tag(options[:header_tag] || :h2, header_message) unless header_message.blank? 
      contents << content_tag(:p, message) unless message.blank? 
      contents << content_tag(:ul, error_messages)
      content_tag(:div, contents.html_safe, html) 
    end
  else
    ''
  end 
end
```
