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

puts "#{month.to_s}月 #{year.to_s}".center(20)
puts "日 月 火 水 木 金 土"

monthfirst_blank = "   " * first_day.wday
print monthfirst_blank

def date_calendar(month_start, month_end)
  today = Date.today
  (month_start..month_end).each do |date|
    day_string = "#{date.day.to_s.rjust(2)}"
    day_string = "\e[7m#{day_string}\e[0m" if date == today
    print "#{day_string} "
    puts if date.saturday? 
  end
  puts
end

date_calendar(first_day, last_day)
