class Army
  def initialize(groups)
    @groups = groups
  end

  def sort_groups
    first_sort = @groups.sort_by { |group| group.effective_power }
    transition_array = []
    while first_sort.length > 0 do
      same_ef_group = first_sort.select { |g| g.effective_power == first_sort[-1].effective_power }
      if same_ef_group.length == 1
        transition_array.push(first_sort.pop)
      else
        first_sort.pop(same_ef_group.length)
        transition_array += same_ef_group.sort_by { |group| -1 * group.initiative }
      end
    end
    transition_array
  end

  def remove_group(group)
    @groups.delete(group)
  end
end
