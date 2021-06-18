polymer = File.read('polymer.dat')
puts polymer.length

def reduce(polymer)
  store = []
  (0..25).each do |i|
    remove_letter = "#{@up[i]}#{@down[i]}"
    size = 0
    reducing_polymer = polymer.gsub(/[#{remove_letter}]/, '')
    while size != reducing_polymer.length
      size = reducing_polymer.length
      reducing_polymer = down_up(reducing_polymer)
    end
    store << reducing_polymer.length
    print remove_letter
    puts reducing_polymer.length
    # reducing_polymer
  end
  store
end

def down_up(polymer_base)
  poly = polymer_base
  (0..25).each do |j|
    regex_ud = "#{@up[j]}#{@down[j]}"
    regex_du = "#{@down[j]}#{@up[j]}"
    poly.gsub!(/#{regex_ud}/, '')
    poly.gsub!(/#{regex_du}/, '')
  end
  poly
end

@down = 'abcdefghijklmnopqrstuvwxyz'
@up = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

puts polymer[0..40]
possibilities = reduce(polymer)

puts possibilities.min
# puts reduced_ploymer
