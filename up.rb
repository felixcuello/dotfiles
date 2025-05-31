#!/usr/bin/env ruby
# frozen_string_literal: true

# SIMPLE TIMER
# This is a simple timer to track time spent on tasks for the University

require 'csv'
require 'date'
require 'time'

def log_time_spent(title, duration_minutes)
  csv_file = 'minutes.csv'

  # Create file with headers if it doesn't exist
  unless File.exist?(csv_file)
    CSV.open(csv_file, 'w') do |csv|
      csv << ['DATE & TIME', 'TASK', 'DESCRIPTION', 'DURATION']
    end
  end

  # Format current date and time
  current_datetime = Time.now.strftime('%Y-%m-%d %H:%M:%S')

  # Prompt user for description
  print "Enter the description for '#{title}'> "
  description = gets.chomp

  # Append the new entry
  CSV.open(csv_file, 'a') do |csv|
    csv << [current_datetime, title, description, duration_minutes.round(2).ceil]
  end

  puts "Session recorded: #{title} - #{duration_minutes.round(2).ceil} minutes"
end

def start_timer(minutes, title)
  start_time = Time.now
  seconds = 0
  overtime = false
  total_minutes_spent = 0

  # Handle CTRL+C to stop timer and log time
  Signal.trap('INT') do
    end_time = Time.now
    total_minutes_spent = (end_time - start_time) / 60.0
    puts "\nTimer stopped. Total time spent: #{total_minutes_spent.round(2)} minutes"
    log_time_spent(title, total_minutes_spent)
    exit
  end

  while true
    if overtime
      # Count upward after timer completes
      elapsed_seconds = (Time.now - start_time).to_i
      overtime_minutes = elapsed_seconds / 60
      overtime_seconds = elapsed_seconds % 60

      timer = format('📚 +%02d:%02d', overtime_minutes, overtime_seconds)
      `tmux rename-window -t 0 "#{title} #{timer} (OVERTIME)"`

      if overtime_minutes % 5 == 0 && overtime_seconds % 5 == 0 && overtime_minutes > 0 && overtime_seconds == 0
        `osascript -e 'display notification "📚 #{overtime_minutes}m have passed after the scheduled time" with title "⚠️ OVERTIME!! ⚠️" sound name "Hero"'`
      end

      sleep(1)
    else
      # Count downward during timer
      while minutes >= 0
        while seconds >= 0
          timer = format('📚 %02d:%02d', minutes, seconds)
          `tmux rename-window -t 0 "#{title} #{timer}"`
          sleep(1)
          seconds -= 1
        end
        seconds = 59
        minutes -= 1

        if minutes % 5 == 0 && minutes > 0
          `osascript -e 'display notification "#{minutes}m remaining!" with title "UP 📚 TIMER"'`
        end
      end

      # Timer completed, play sound and switch to overtime mode
      `afplay /System/Library/Sounds/Hero.aiff`

      # Flash notification
      3.times do
        `tmux rename-window -t 0 "📚 TIME COMPLETED 📚"`
        sleep(0.5)
        `tmux rename-window -t 0 "📚 TRACKING OVERTIME 📚"`
        sleep(0.5)
      end

      overtime = true
    end
  end
end

# Default values
timer_minutes = 25
title = 'UP'

if ARGV.count == 2 # If we run: ./up.rb <title> <minutes>
  title = ARGV[0]
  timer_minutes = ARGV[1].to_i if ARGV[1].to_i.positive?
elsif ARGV.count >= 1 # if we run with a single argument
  if ARGV[0].to_i.positive?
    timer_minutes = ARGV[0].to_i
  else
    title = ARGV[0]
  end
end

puts "Starting timer: #{title} for #{timer_minutes} minutes"
puts 'Press CTRL+C at any time to stop and record your time'

start_timer(timer_minutes, title)
