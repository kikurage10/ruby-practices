#!/usr/bin/env ruby
require 'optparse'
require 'date'

opt = OptionParser.new
params = {}
opt.on('-m month', Integer) {|month| params[:month] = month}
opt.on('-y year', Integer) {|year| params[:year] = year}
opt.parse!(ARGV)

month = params[:month] || Date.today.month
year = params[:year] || Date.today.year

first_day = Date.new(year, month, 1)
last_day = Date.new(year, month, -1)

monthyear = "#{month.to_s}月 #{year.to_s}"
weeks = "日 月 火 水 木 金 土"

puts monthyear.center(20)
puts weeks

monthfirst_blank = "   " * first_day.wday
print monthfirst_blank

def date_calendar(first, last)
  today = Date.today
  (first..last).each do |x|
    if x == today
      print "\e[30m\e[47m" + x.day.to_s + "\e[0m" + " "
    else
      print x.strftime('%e').rjust(2) + " "
    end
    puts if x.saturday?
  end
end

date_calendar(first_day, last_day)
