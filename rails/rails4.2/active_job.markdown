### Delayed::Job

```ruby

class NewsletterJob < Struct.new(:text, :emails)
    def perform
      emails.each { |e| NewsletterMailer.deliver_text_to_email(text, e) }
    end    
  end  
  
  Delayed::Job.enqueue NewsletterJob.new('lorem ipsum...', Customers.find(:all).collect(&:email))
  ```



https://github.com/tobi/delayed_job

