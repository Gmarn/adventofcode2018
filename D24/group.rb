class Group
  def initialize(data)
    @data = data
  end

  def effective_power
    units * damage
  end

  def units
    @data[:units]
  end

  def hp
    @data[:hp]
  end

  def damage
    @data[:damage]
  end

  def damage_type
    @data[:damage_type]
  end

  def initiative
    @data[:initiative]
  end

  def immunity
    @data[:immunity]
  end

  def weak
    @data[:weak]
  end

  def target_enemy(enemy_groups)
    results = enemy_groups.map do |enemy|
      { group: enemy, total_damage: calc_damage(enemy), ef: enemy.effective_power, init: enemy.initiative }
    end
    results = by_damage(results) if results.length >= 1
    results = by_efective_power(results) if results.length >= 1
    results = by_initiative(results) if results.length >= 1
    results[0]
  end

  private

  def by_damage(targeted_groups)
    max = targeted_groups.max { |a, b| a[:total_damage] <=> b[:total_damage] }[:total_damage]
    targeted_groups.select { |e| e[:total_damage] == max }
  end

  def by_efective_power(targeted_groups)
    max = targeted_groups.max { |a, b| a[:ef] <=> b[:ef] }[:ef]
    targeted_groups.select { |e| e[:ef] == max }
  end

  def by_initiative(targeted_groups)
    max = targeted_groups.max { |a, b| a[:init] <=> b[:init] }[:init]
    targeted_groups.select { |e| e[:init] == max }
  end

  def calc_damage(enemy)
    unless enemy.immunity.nil?
      return effective_power * 0 if enemy.immunity.include?(damage_type)
    end

    unless enemy.weak.nil?
      return effective_power * 2 if enemy.weak.include?(damage_type)
    end

    effective_power
  end
end
