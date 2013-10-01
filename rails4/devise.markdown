#### Unpermitted Parameters


    Unpermitted Parameters adding new fields to Devise in rails 4.0
    
    Unpermitted parameters: name, uid
    WARNING: Can't mass-assign protected attributes for User: password_confirmation
    app/models/user.rb:31:in `new_with_session'

```ruby

before_filter :update_sanitized_params, if: :devise_controller?

def update_sanitized_params
  devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:bio, :name)}
end

```


