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


#### SQL injection


```ruby
class ProductsController < ApplicationController
  def search
    @products = Product.where("name LIKE '%#{params[:search_terms]}%'") end
  end

```

while input will be 

```ruby
SELECT * FROM products WHERE name LIKE'%'; DELETE FROM users; %';
@products = Product.where('name LIKE ?',"%#{params[:query]}%")
```

#### Cross-Site Scripting (XSS)

Cross-Site Scripting is the most common security vulnerability. It doesn’t make it any less severe. When successfully exploited it can give an attacker a bypass around application authorization and authentication mechanisms and leak personal information.


This attack works by injecting a client-side executable code into the application pages. An example of such a code can be a Javascript that “leaks” cookies to a remote server, which would allow the attacker to ‘clone’ any affected session. So if the attacker is able to lay his hands on the administrator session he would be able to impersonate administrator without actually passing the required authentication procedures, just by using already authenticated session.
There are several ways an attack code can “leak” the information, one of the simplest ones is inserting an image tag into the DOM with image reference to attacker’s server and image path including the leaked information. The attacher’s server access logs will then capture the information.


The good news is that latest version of Rails make it relatively easy to avoid this kind of attack. In this section we will discuss the key elements that Rails provides to defend against XSS attacks and what things you should watch out for.
The most common mistake leading to an XSS vulnerability is failing to escape user input when rendering html. There are several possible vectors of attack.


An attack code can be first saved into the database (like, for example, injecting it into a post title, or comment body, etc.), in which case such a database record becomes essentially ‘infected’. Then, anyone visiting a page in the application that renders this infected record to the page will essentially run the javascript code embedded in the record and this script can get a hold on visiting user’s session.


Another option is to pass the attack code as one of the URL parameters that are directly rendered into the page, then cause a victim to visit such an ‘infected’ URL.


In both cases the victim’s browser is exposed to the attack code which will execute in the browser’s context.
Now that you understand the problem the solution should be obvious, you need to either “escape” or “sanitize” all unsafe HTML content.


In this context “escaping” means replacing some of the string characters by an HTML escape sequences that will remove the special meaning from the text and cause it to render as a regular text. Sanitizing on the other hand means validating the HTML content to ensure only “good” HTML tags and attributes are used.
Note that sanitizing is inherently less secure then escaping, and should only be used where we must have html in the rendered content. For example if a WYSIWYG html editor must be used for an input field which is later rendered on a page.


