require 'rails'

def record_to_hash(array)
  new_array = []
  array.each do |record|
    dict = {}
    dict[:time] = record.split('] ')[0].split('[')[1].to_time
    dict[:action] = record.split('] ')[1]
    new_array << dict
  end
  new_array
end

def record_by_guard
  dict = {}
  start = 0
  while start != 'end'
    id = @sort_array[start][:action].gsub(/\D/, '')
    a_shift = select_guard_shift(start + 1)
    start = a_shift[0]
    test = shift_to_string(a_shift[1])
    dict[id] = dict[id].to_s + test
    puts test
    puts test[58]
    puts test[59]
  end
  # dict[l] = dict[l].to_i + 1
  dict
end

def select_guard_shift(start)
  a = []
  @sort_array[start..-1].each_with_index do |elt, index|
    return [start + index, a] if elt[:action].match(/Guard/).present?
    a << elt
  end
  ['end', a]
end

def shift_to_string(shift)
  string = ''
  start_min = 0
  puts 'WARNING!!!!!!!!!!!' if shift.length % 2 == 1
  shift.each do |s|
    status = s[:action].match(/falls/).present? ? '.' : '#'
    minutes = s[:time].min - start_min
    string << status * minutes
    start_min = s[:time].min
  end
  puts shift
  string << '.' * (60 - start_min)
  string
end

def find_sleepest(guard_timelines)
  max = 0
  id = 0
  guard_timelines.each do |k, v|
    minutes = v.gsub(/\./, '').length
    if minutes > max
      max = minutes
      id = k
    end
  end
  id
end

file = File.read('guard_sleeping.dat')
puts 'separe it'

array = file.split("\n")

array_h = record_to_hash(array)
@sort_array = array_h.sort_by { |h| h[:time] }
# @sort_array = array_h.sort_by { |h| h[:time] }[0..10]

time_lines = record_by_guard
guard_id = find_sleepest(time_lines)

puts guard_id
puts 'tadam'
puts time_lines[guard_id]
repetition = time_lines[guard_id].length / 60

max = 0
minute_phare = -1
(0..59).each do |i|
  string = ''
  (0..repetition - 1).each do |j|
    # puts (60 * j) + i
    string << time_lines[guard_id][(60 * j) + i]
  end
  string.gsub!(/\./, '').length
  if string.length > max
    max = string.length
    minute_phare = i
  end
  print string
  puts i
end
puts minute_phare
