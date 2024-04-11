#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = shots.each_slice(2).to_a

point = 0
frames.each_with_index do |frame, idx|
  first_next_frame = frames[idx + 1]
  second_next_frame = frames[idx + 2]
  strike = frame[0] == 10
  spare = !strike && frame.sum == 10

  point +=
    if idx < 9
      if strike && (first_next_frame[0] == 10 || first_next_frame[1] == 10)
        10 + 10 + second_next_frame[0]
      elsif strike
        10 + first_next_frame[0] + first_next_frame[1]
      elsif spare
        10 + first_next_frame[0]
      else
        frame.sum
      end
    elsif strike || spare
      10 + frame[2].to_i
    else
      frame.sum
    end
end

puts point
