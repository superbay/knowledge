### Delayed::Job

```ruby

class NewsletterJob < Struct.new(:text, :emails)
    def perform
      emails.each { |e| NewsletterMailer.deliver_text_to_email(text, e) }
    end    
  end  
  
  Delayed::Job.enqueue NewsletterJob.new('lorem ipsum...', Customers.find(:all).collect(&:email))
  
  Delayed::Job.enqueue Note.new(parameter_hash), :priority => 10
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


### How to start the delayed job

```ruby
RAILS_ENV=production script/delayed_job stop
RAILS_ENV=production script/delayed_job start

# execute job synch during tests and dev
# or pass arg for async in those environments
delayed_execution = if ENV['DELAY_JOBS']
  true
else
  !(Rails.env.test? or Rails.env.development?)
end

Delayed::Worker.delay_jobs = delayed_execution
```

http://stackoverflow.com/questions/19958133/delayed-job-rails-4

### How to start worker 

normally
`rake jobs:work`


Start a standard rails console

```ruby

ruby script/console
```


And start a worker inside here, this will see and trigger the debugger statement.
```ruby
worker = Delayed::Worker.new
worker.start

```

## Usage

Set the queue adapter for Active Job:

``` ruby
ActiveJob::Base.queue_adapter = :inline # default queue adapter
```
Note: To learn how to use your preferred queueing backend see its adapter
documentation at
[ActiveJob::QueueAdapters](http://api.rubyonrails.org/classes/ActiveJob/QueueAdapters.html).

Declare a job like so:

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
```

```ruby
MyJob.set(wait_until: Date.tomorrow.noon).perform_later(record)  # Enqueue a job to be performed tomorrow at noon.
```

```ruby
MyJob.set(wait: 1.week).perform_later(record) # Enqueue a job to be performed 1 week from now.
```

That's it!


## GlobalID support

Active Job supports [GlobalID serialization](https://github.com/rails/globalid/) for parameters. This makes it possible
to pass live Active Record objects to your job instead of class/id pairs, which
you then have to manually deserialize. Before, jobs would look like this:

```ruby
class TrashableCleanupJob
  def perform(trashable_class, trashable_id, depth)
    trashable = trashable_class.constantize.find(trashable_id)
    trashable.cleanup(depth)
  end
end
```

Now you can simply do:

```ruby
class TrashableCleanupJob
  def perform(trashable, depth)
    trashable.cleanup(depth)
  end
end
```

This works with any class that mixes in GlobalID::Identification, which
by default has been mixed into Active Record classes.


## Supported queueing systems

Active Job has built-in adapters for multiple queueing backends (Sidekiq,
Resque, Delayed Job and others). To get an up-to-date list of the adapters
see the API Documentation for [ActiveJob::QueueAdapters](http://api.rubyonrails.org/classes/ActiveJob/QueueAdapters.html).

## Auxiliary gems

* [activejob-stats](https://github.com/seuros/activejob-stats)

## Download and installation

The latest version of Active Job can be installed with RubyGems:

```
  % [sudo] gem install activejob
```

Source code can be downloaded as part of the Rails project on GitHub

* https://github.com/rails/rails/tree/master/activejob





