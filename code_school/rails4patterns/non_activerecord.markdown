When do you think you need a non active record model


### UserRegistration





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


will refactor to 


```ruby
class UsersController < ApplicationController
  def create

    registration = UserRegistration.new(user_params)
    @user = registration.user

    if registration.create
      redirect_to @user
    else
      render :new
    end
  end
end

```
which will be much clean

```ruby
class UserRegistration
  attr_reader :user

  def initialize(params)
    @user = User.new(params)
  end
  
  def create
    @user.is_approved = true if self.valid_background_check?
    @user.save
  end

  private

  def valid_background_check?
    !!(@user.valid_ssn? || @user.valid_address?)
  end
end


```
