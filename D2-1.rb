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
# print array

@counter = { two: 0, three: 0 }

array.each do |a|
  analyze_id(a)
end
puts @counter
puts @counter[:two] * @counter[:three]


