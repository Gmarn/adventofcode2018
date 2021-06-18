def analyze_id(id)
  result = count_letter(id).values
  @counter[:two] += 1 if result.include?(2)
  @counter[:three] += 1 if result.include?(3)
end

def count_letter(id)
  dict = {}
  id.chars.each do |l|
    dict[l] = dict[l].to_i + 1
  end
  dict
end

file = File.read('box_ids.txt')
puts 'separe it'
array = file.split(' ')

init_lenght = array.length
puts init_lenght

(0..25).each do |e|
  file = File.read('box_ids.txt')
  trans_array = file.split(' ')
  trans_array.each { |a| a.slice!(e) }
  if trans_array.uniq.length != init_lenght
    puts e
    puts "#{array.length} - #{trans_array.uniq.length}"
    # print trans_array.uniq!
    (0..249).each do |i|
      item = trans_array.pop
      puts i if trans_array.include?(item)
      puts item if trans_array.include?(item)
    end
  end
end
