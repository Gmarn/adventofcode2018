# reuslt = 104126
require 'matrix'

def parse_array(array)
  array.map do |e|
    elt = e.split(' ')
    dict = {}
    dict[:id] = elt[0].to_i
    pos = elt[2].split(',')
    dict[:pos] = { left: pos[0].to_i, top: pos[1].split(':')[0].to_i }
    dict[:size] = { width: elt[3].split('x')[0].to_i, height: elt[3].split('x')[1].to_i }
    dict
  end
end

def fill_matrix(array)
  matrix = Matrix.zero(@length)
  array.each do |claim|
    puts claim
    matrix = matrix + matrix_trans(claim)
  end
  matrix
end

def matrix_trans(claim)
  Matrix.build(@length, @length) do |row, col|
    if row >= claim[:pos][:top] && row < (claim[:pos][:top] + claim[:size][:height]) &&
        col >= claim[:pos][:left] && col < (claim[:pos][:left] + claim[:size][:width])
      1
    else
      0
    end
  end
end

file = File.read('squares.dat')
array = file.split('#').reject { |i| i.empty? }
print array

@length = 100
parsed_array = parse_array(array)
# print parsed_array

puts 'separte it'

response_matrix = fill_matrix(parsed_array)
# print(response_matrix)

File.open('matrix_response.txt', 'w') { |f| f.write(response_matrix) }

counter = 0
(0..@length - 1).each do |i|
  (0..@length - 1).each do |j|
    counter += 1 if response_matrix[i,j] > 1
  end
end

puts counter
