#!/usr/bin/env ruby
require 'optparse'
require 'date'

opt = OptionParser.new
params = {}
opt.on('-m month', Integer) {|month| params[:month] = month}
opt.on('-y year', Integer) {|year| params[:year] = year}
opt.parse!(ARGV)

if params[:month]
  month = params[:month]
else
  month = Date.today.month
end
if params[:year]
  year = params[:year]
else
  year = Date.today.year
end

monthfirst = Date.new(year, month, 1)
monthlast = Date.new(year, month, -1)

monthyear = month.to_s + "月 " + year.to_s
weeks = "日 月 火 水 木 金 土"

puts monthyear.center(20)
puts weeks

monthfirst_blank = "   " * monthfirst.wday
print monthfirst_blank

def DateCalendar(first, last)
  today = Date.today
  (first..last).each do |x|
    if x == today
      print "\e[30m\e[47m" + x.day.to_s + "\e[0m" + " "
    else
      print x.strftime('%e') + " "
    end
    puts if x.wday == 6
  end
end

DateCalendar(monthfirst, monthlast)
