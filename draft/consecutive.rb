def find_consecutive_runs(list =  [1, 2, 3, 5, 10, 9, 8, 9, 10, 11, 7] )
  rs = []
  list.each_with_index do |x, i|
    rs << i if list[i + 2] && is_con?(x, list[i+1], list[i + 2])
  end
  rs
end

def is_con?(x, y, z)
  ((x == (y + 1) && y = (z + 1) ) || ( x == (y - 1 ) && y == (z - 1) ) ) ? true : false
end



def find_consecutive_runs2(list =  [1, 2, 3, 5, 10, 9, 8, 9, 10, 11, 7] )
  rs = []
  status = []
  list.each_with_index do |x, i|
    if i == 0
      next
    elsif x == list[i - 1 ] + 1
      status[i] = 'asc'
      rs << (i - 2) if status[i - 1] == 'asc'
    elsif x == list[i - 1] - 1
      status[i] = 'desc'
      rs << (i - 2) if status[i - 1] == 'desc'
    end
  end
  rs
end


def find_consecutive_runs3(list =  [1, 2, 3, 5, 10, 9, 8, 9, 10, 11, 7] )
  rs = []
  counter = 0
  0.upto(list.length).each do |i|
    next if i == 0 || rs.include?(i)
    i.upto(list.length).each do |j|
      if counter >= 0 && list[j] == list[j - 1] + 1  
        counter += 1 
        rs << j - 2 if counter >= 2
      elsif counter <= 0 && list[j]== list[j - 1] - 1  
        counter -= 1
        rs << j - 2 if counter <= -2
      else
        counter = 0
        break
      end
    end
  end
  rs
end

