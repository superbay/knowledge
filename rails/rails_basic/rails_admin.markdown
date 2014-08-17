## rails admin add current user


```ruby


rails_admin do 
  edit do   
    field :user, :hidden do
      visible false
      default_value do
        bindings[:view]._current_user.id
      end
    end
  end 
end
```

https://github.com/sferik/rails_admin/wiki/How-to-set-current_user-to-the-field
