#!/usr/bin/env ruby
score = ARGV[0]
scores = score.split(',')

shots = []
scores.each do |score|
  if score == 'X'
    shots << 10
    shots << 0
  else
    shots << score.to_i
  end
end

frames = []
shots.each_slice(2) do |shot|
  frames << shot
end

point = 0
frames.each_with_index do |frame, idx|

  first_next_frame = frames[idx + 1]
  second_next_frame = frames[idx + 2]
  strike = frame[0] == 10
  spare = frame.sum == 10

  if idx < 9
    if strike
      if first_next_frame[0] == 10 || first_next_frame[1] == 10
        point += 10 + 10 + second_next_frame[0]
      else  
        point += 10 + first_next_frame[0] + first_next_frame[1]
      end
    elsif spare

      point += 10 + first_next_frame[0]
    else
      point += frame.sum
    end
  else
    if strike || spare
      point += 10 + frame[2].to_i
    else
      point += frame.sum
    end
  end
end

puts point
