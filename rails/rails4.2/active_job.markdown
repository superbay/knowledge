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


### Active::Job

```ruby
class MyJob < ActiveJob::Base
  queue_as :my_jobs

  def perform(record)
    record.do_work
  end
end
```
Enqueue a job like so:

```ruby
MyJob.perform_later record  # Enqueue a job to be performed as soon the queueing system is free.
MyJob.set(wait_until: Date.tomorrow.noon).perform_later(record)  # Enqueue a job to be performed tomorrow at noon.
MyJob.set(wait: 1.week).perform_later(record) # Enqueue a job to be performed 1 week from now.

```
https://github.com/rails/rails/tree/master/activejob


