polymer = File.read('polymer.dat')
puts polymer.length

def reduce(polymer)
  size = 0
  reducing_polymer = polymer
  while size != polymer.length
    puts polymer.length
    size = polymer.length
    reducing_polymer = down_up(polymer)
  end
  reducing_polymer
end

def down_up(polymer_base)
  (0..25).each do |i|
    regex_ud = "#{@up[i]}#{@down[i]}"
    regex_du = "#{@down[i]}#{@up[i]}"
    polymer_base.gsub!(/#{regex_ud}/, '')
    polymer_base.gsub!(/#{regex_du}/, '')
  end
  polymer_base
end

@down = 'abcdefghijklmnopqrstuvwxyz'
@up = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

puts polymer[0..40]
reduced_ploymer = reduce(polymer)

# puts reduced_ploymer
