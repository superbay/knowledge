


### discussion and question list

Chapter 5

* need to understand SCI single Collection Inherentence and practice

* need to understand and practice Basic Poliymorphic

* need to undersand and practice Embeded Document Poliymorphic

### discussion list of MongoDB in action

* page 88 about $elemMatch and search in array attribute

* javascript function query

* projections

```javascript
db.reviews.find({$where: "function() { return this.helpful_votes > 3; }"})
```
* group function mongodb 3?
* how to use push while updating 
* 




![screen shot 2015-05-25 at 11 20 35 pm](https://cloud.githubusercontent.com/assets/83296/7804736/ba69441a-0334-11e5-99d6-50bd69397af7.png)





```


db.people.find({addresses: {$elemMatch: {state: "DC", zip: "20002"}}})

```

Questions about mongodb replication

* how commit and rollback with 
* arbitor work
* explain heartbeat and oplog 

Master Slave Replication


Questions about mongoDB sharding

* what is problem of 'Lack of locality'
* 

mongoDB Webconsole how to use?



 There are a couple reasons for this. First, failover is completely manual.
If the master node fails, then an administrator must shut down a slave and restart it as
a master node.

