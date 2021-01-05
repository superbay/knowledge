```
all_1 = Dir.foreach('/Users/ce0Mv12/receipnlu/Docuts/Feeoi/2s').map(&:to_s)[2..-1]
all_1.each {|x|nn = rand(36**5).to_s(36) +".png"; File.rename(x, nn);}
```
