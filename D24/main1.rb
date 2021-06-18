require './group'
require './army'

def parse_army(file_army, type)
  file_army.each_with_object([]) do |group, acc|
    numbers = group.gsub(/[^0-9 ]/, '').split(' ')
    specs = group.scan(/\(.*\)/)[0]

    hgroup = {
      units: numbers[0].to_i,
      hp: numbers[0].to_i,
      damage: numbers[0].to_i,
      damage_type: group.split(' damage')[0].split(' ')[-1],
      initiative: numbers[3].to_i,
      type: type
    }
    unless specs.nil?
      specs.split(';').each do |spec|
        hgroup[:weak] = spec.split('to ')[-1].gsub(')', '').split(', ') if spec.include?('weak')
        hgroup[:immunity] = spec.split('to ')[-1].gsub(')', '').split(', ') if spec.include?('immune')
      end
    end
    acc << Group.new(hgroup)
  end
end

def targetting(ally, enemy)
  enemy_groups = enemy.dup
  ally.each_with_object([]) do |a_group, acc|
    acc if enemy_groups.empty?
    e_group = a_group.target_enemy(enemy_groups)
    enemy_groups.delete(e_group[:group])
    acc << { attack: a_group, defense: e_group }
  end
end

def phase(immune, infection)
  target_immune = targetting(immune, infection)
  target_infection = targetting(infection, immune)

  all_group = (target_immune + target_infection).sort_by { |g| g[:initiative] }
  puts all_group
end

file_imune = File.read('army_imune.dat')
file_infection = File.read('army_infection.dat')

army_imnue = parse_army(file_imune.split("\n"), 'immune')
army_infection = parse_army(file_infection.split("\n"), 'infection')

imune_system = Army.new(army_imnue).sort_groups
infection = Army.new(army_infection).sort_groups
# imune_system.each { |l| puts "#{l.effective_power}  #{l.initiative}" }

phase(imune_system, infection)
