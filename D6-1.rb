file = File.read('coordinates.dat')

coords = file.split("\n").map { |n| n.split(', ').map { |c| c.to_i } }
y_max = coords.sort_by { |c| c[0] }[-1][0]
x_max = coords.sort_by { |c| c[1] }[-1][1]
puts y_max
puts x_max

square_size = 360
