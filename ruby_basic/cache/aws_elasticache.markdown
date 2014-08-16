

### How to make elasticache work with EC2 or VPC


need a gem 


[dalli-elasticache](https://github.com/ktheory/dalli-elasticache)



2. need more configuration at AWS console


for VPC you need subnet

for EC2 you just need secrety group

add elasticache cluster

make sure same cecurite group

[referece for VPC and Elasticache](http://docs.aws.amazon.com/AmazonElastiCache/latest/UserGuide/ManagingVPC.html)


more resource:


http://docs.aws.amazon.com/AmazonElastiCache/latest/UserGuide/ManagingVPC.Connecting.html

http://docs.aws.amazon.com/AmazonElastiCache/latest/UserGuide/ManagingVPC.CreatingCacheCluster.html

http://docs.aws.amazon.com/AmazonElastiCache/latest/UserGuide/ManagingVPC.CreatingSubnetGroup.html

http://docs.aws.amazon.com/AmazonElastiCache/latest/UserGuide/ManagingVPC.CreatingVPC.html

http://docs.aws.amazon.com/AmazonElastiCache/latest/UserGuide/ManagingVPC.html
