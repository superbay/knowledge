
```ruby
User.find_each(start: 2000, batch_size: 5000) do |user|
  NewsLetter.weekly_deliver(user)
end

```

### find_each

The find_each method retrieves a batch of records and then yields each record to the block individually as a model. In the following example, find_each will retrieve 1000 records (the current default for both find_each and find_in_batches) and then yield each record individually to the block as a model. This process is repeated until all of the records have been processed:


### batch_size

The :batch_size option allows you to specify the number of records to be retrieved in each batch, before being passed individually to the block. For example, to retrieve records in batches of 5000:

### start

By default, records are fetched in ascending order of the primary key, which must be an integer. The :start option allows you to configure the first ID of the sequence whenever the lowest ID is not the one you need. This would be useful, for example, if you wanted to resume an interrupted batch process, provided you saved the last processed ID as a checkpoint.



