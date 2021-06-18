file = File.read('frequecies.txt')
puts file
array = file.split(' ')

init = 0
stock = nil
array.each do |f|
  freq = f.to_i
  stock = init + freq
  init = stock
end
puts init
puts stock
