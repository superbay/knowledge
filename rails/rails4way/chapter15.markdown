## security

#### XSRF (Cross-Site Request Forgery)

client side

```ruby
= csrf_meta_tags
```

server side

```ruby
class ApplicationController
# Prevent CSRF attacks by raising an exception.
# For APIs, you may want to use :null_session instead. 
  protect_from_forgery with: :exception
end
```


Cross-Site Request Forgery (usually abbreviated as CSRF or XSRF) is a type of web application vulnerability that allows an attacker to modify application state on behalf of a user that is logged into the application by luring the user to click on a carefully crafted link, visit a page, or even just open an email with embedded images.
Lets say that an intern at a banking institution implemented account fund transfer functionality as an HTTP GET method, like so:


` GET/transfers?from_account_id=123&to_account_id=456&amount=1000`


Of course everyone, even interns, know you should authenticate your banking transfers.
Lets say the intern did learn a little bit of Rails security and properly authenticated and authorized the request.
Now lets say a user logged into his account on the site, and then went to read his email. An attacker then could send him an HTML email with the following image:


`<imgsrc="http://banking-domain/transfers?from_account_id=users_account_id&to_account_id=a\ 2 ttacker_account_id&amount=1000">`


This image would be opened by victim’s browser, which is authenticated and authorized to make the transfer because the session cookie from the bank is still valid.


Fortunately for the bank, this code went through a code review, and the reviewer pointed out this problem to the intern.
Attempting to fix the problem the code was modified to use POST instead. Are we safe yet? Well, actually, not quite. An attacker still can “lure” the victim to his innocently looking site, on which he has a javascript that will post to the fund transfer URL from within victim’s browser.




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
    @products = Product.where("name LIKE '%#{params[:search_terms]}%'") 
    
  end
end

```

while input will be 

```ruby
SELECT * FROM products WHERE name LIKE'%'; DELETE FROM users; %';
@products = Product.where('name LIKE ?',"%#{params[:query]}%")
```

#### solution

```ruby
class ProductsController < ApplicationController
  def search
    @products = Product.where("name LIKE '%?%'", name: params[:search_terms]) 
    
  end
end

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


