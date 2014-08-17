When do you think you need a non active record model


### UserRegistration


```ruby
class UserRegistration
  attr_reader :user
  def initialize(user_params)
    @user = User.new(user_params)
  end
  private
  def valid_background_check?
    !!(@user.valid_ssn? || @user.valid_address?)
  end
  # private methods go here
end

```



```ruby

sers_controller.rb
class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if valid_background_check?
      @user.is_approved = true
    end

    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  private

  def valid_background_check?
    !!(@user.valid_ssn? || @user.valid_address?)
  end

  def user_params
    params.require(:user).permit(:name, :email, :ssn, :address)
  end
end
```
