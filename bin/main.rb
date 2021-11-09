require_relative '../lib/counter'

puts '------------- please enter the path to your log file ----------------'
file = gets.chomp
puts `clear`
f = File.open(file, 'r')
start = Counter.new(f)
start.run
puts start.show_total_views
puts '----------------'
puts start.show_unique_views
f.close
