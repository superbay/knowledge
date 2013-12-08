## security


#### Model mass-assignment attributes protection

```ruby
def create_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
end
def update_params
  params.require(:user).permit(name: true, email: true, tags: [])
end

```
