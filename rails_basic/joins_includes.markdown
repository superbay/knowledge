#### kinds of same


#### eager loading vs lazy loading


```ruby

Product.joins(:category).where('category = :name', name: name)

```




.joins will just joins the tables and brings selected fields in return. if you call associations on joins query result, it will fire database queries again.   inner join 

:include will eager load the included associations and add them in memory. :include loads all the included tables attributes. If you call associations on include query result, it will not fire any queries. left outer join





rails 4
### includes with select


```ruby

Batting.includes(:player).select(:name_first).references(:player)


SELECT 
  name_first, 
  `battings`.`id` AS t0_r0, 
  `battings`.`player_id` AS t0_r1, 
  `battings`.`year_id` AS t0_r2, 
  `battings`.`league` AS t0_r3, 
  `battings`.`team_id` AS t0_r4, 
  `battings`.`games_played` AS t0_r5, 
  `battings`.`at_bats` AS t0_r6, 
  `battings`.`runs` AS t0_r7, 
  `battings`.`hits` AS t0_r8, 
  `battings`.`doubles` AS t0_r9, 
  `battings`.`triples` AS t0_r10, 
  `battings`.`home_runs` AS t0_r11, 
  `battings`.`runs_batted_in` AS t0_r12, 
  `battings`.`stolen_bases` AS t0_r13, 
  `battings`.`caught_stealing` AS t0_r14, 
  `battings`.`created_at` AS t0_r15, 
  `battings`.`updated_at` AS t0_r16, 
  `battings`.`bat_ave` AS t0_r17, 
  `players`.`id` AS t1_r0, 
  `players`.`player_id` AS t1_r1, 
  `players`.`birth_year` AS t1_r2, 
  `players`.`name_first` AS t1_r3, 
  `players`.`name_last` AS t1_r4, 
  `players`.`created_at` AS t1_r5, 
  `players`.`updated_at` AS t1_r6, 
  `players`.`most_improved` AS t1_r7 FROM `battings`
  LEFT OUTER JOIN `players` 
  ON `players`.`player_id` = `battings`.`player_id` 
  WHERE (hits is not null and runs is not null and doubles is not null and triples is not null and home_runs is not null and at_bats is not null)
```
