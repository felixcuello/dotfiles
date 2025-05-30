#!/usr/bin/env ruby
# frozen_string_literal: true

# https://en.wikipedia.org/wiki/Pomodoro_Technique

def start_timer(minutes, is_break: false, title: 'pomodoro')
  seconds = 0
  while minutes >= 0
    while seconds >= 0
      timer = sprintf("🍅 %02d:%02d", minutes, seconds)
      `tmux rename-window -t 0 "#{is_break ? 'break! =)' : title} #{timer}"`
      sleep(1)
      seconds -= 1
    end
    seconds = 59
    minutes -= 1
  end
end

is_break = false
timer_minutes = 25
title = 'pomodoro'

if ARGV.count == 2 # If we run: ./pomodoro.rb <title> <minutes>
  title = ARGV[0]
  timer_minutes = ARGV[1].to_i if ARGV[1].to_i.positive?
  is_break = false
elsif ARGV[0] == 'break' # if we take a break: ./pomodoro.rb break
  is_break = true
else # if we run either with a number or a title: ./pomodoro.rb <title|minutes>
  if ARGV[0].to_i.positive?
    timer_minutes = ARGV[0].to_i
  else
    title = ARGV[0]
  end
  
  is_break = false
end

start_timer(timer_minutes, is_break: is_break, title: title)

3.times do
  `osascript -e 'display notification "#{timer_minutes}m have passed!" with title "🍅 POMODORO 🍅" sound name "Hero"'`
  sleep 5
end

while true
# smile emoji => 
#
  `tmux rename-window -t 0 "⚠️🍅 FINISHED 🍅⚠️"`
  `osascript -e 'display notification "#{timer_minutes}m have passed!" with title "🍅 #{title} - Has Finished 🍅"'`
  sleep 300
end
