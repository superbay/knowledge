### Delayed::Job

```ruby

class NewsletterJob < Struct.new(:text, :emails)
    def perform
      emails.each { |e| NewsletterMailer.deliver_text_to_email(text, e) }
    end    
  end  
  
  Delayed::Job.enqueue NewsletterJob.new('lorem ipsum...', Customers.find(:all).collect(&:email))
  ```

suggeted, since it is rails version
https://github.com/collectiveidea/delayed_job 

the original one
https://github.com/tobi/delayed_job

http://www.sitepoint.com/delayed-jobs-best-practices/


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



http://dev.mikamai.com/post/96343027199/rails-4-2-new-gems-active-job-and-global-id

https://blog.engineyard.com/2014/getting-started-with-active-job

