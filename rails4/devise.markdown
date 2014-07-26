> We loved with a love that was more than love
> Unpermitted parameters: name, uid

#### Unpermitted Parameters


    Unpermitted Parameters adding new fields to Devise in rails 4.0
    
    Unpermitted parameters: name, uid
    WARNING: Can't mass-assign protected attributes for User: password_confirmation
    app/models/user.rb:31:in `new_with_session'
    
Normal solution is add strong parameter permit, to application_controller or the exact controller    

```ruby

before_filter :update_sanitized_params, if: :devise_controller?

def update_sanitized_params
  devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:bio, :name)}
end

```

reference: https://github.com/plataformatec/devise#strong-parameters



```ruby

# controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
 
  before_filter :configure_permitted_parameters
 
  protected
 
  # my custom fields are :name, :heard_how
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :heard_how,
        :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:name,
        :email, :password, :password_confirmation, :current_password)
    end
  end
 
end

```

