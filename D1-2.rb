def run_frequency(init, array, list)
  stock = nil
  array.each do |f|
    freq = f.to_i
    stock = init + freq
    if list.include?(stock)
      puts stock
    end
    list << stock
    init = stock
  end
  { init: init, list: list }
end

file = File.read('frequency2.txt')
puts file
array = file.split(' ')

list = [474]
init = 0
(0..143).each do |i|
  result = run_frequency(init, array, list)
  init = result[:init]
  list = result[:list]
  puts "loop #{i} result: #{result[:init]}"
end

