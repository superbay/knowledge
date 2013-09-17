def find_consecutive_runs(list =  [1, 2, 3, 5, 10, 9, 8, 9, 10, 11, 7], n = 3 )
  rs = []
  list.each_with_index do |x, i|
    rs << i if list[i + n] && is_con?(list, i, n)
  end
  rs
end

def is_con?(list, start_index, n)
  asc = start_index.upto(n).each do |i|
    return false unless list[i] + 1 == list[i + 1]
  end

  desc = start_index.upto(n).each do |i|
    return false unless list[i] - 1 == list[i + 1]
  end

  #((x == (y + 1) && y = (z + 1) ) || ( x == (y - 1 ) && y == (z - 1) ) ) ? true : false
  asc || desc

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

def find_consecutive_runs3(list =  [1, 2, 3, 4, 10, 9, 8, 9, 10, 11, 7] )
  rs = []
  pre_status = 'false'
  current_status = 'false'
  list.each_with_index do |item, i|
    next if i == 0
    current_status = if (list[i - 1] + 1) == list[i]
      'asc' 
    elsif (list[i - 1] - 1) == list[i]
      'desc' 
    else
      'false'
    end
    rs << (i - 2) if pre_status != 'false' && pre_status == current_status
    pre_status = current_status
  end
  rs
end
