#!/usr/bin/env ruby
# frozen_string_literal: true

# SIMPLE TIMER
# This is a simple timer to track time spent on tasks for the University

require 'csv'
require 'date'
require 'time'
require 'io/console'

def get_terminal_size
  rows, cols = $stdout.winsize
  [rows, cols]
rescue StandardError
  [24, 80] # fallback
end

def clear_screen
  print "\033[2J\033[H"
end

def move_cursor(row, col)
  print "\033[#{row};#{col}H"
end

def center_text(text, width, emoji: false)
  padding = (width - text.length) / 2 + (emoji ? -8 : 0)
  ' ' * padding + text
end

def university_art
  [
    '⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛',
    '⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛',
    '⬛⬛⬜⬜⬛⬛⬛⬜⬜⬛⬜⬜⬜⬜⬜⬛⬛⬛',
    '⬛⬛⬜⬜⬛⬛⬛⬜⬜⬛⬜⬜⬜⬜⬜⬜⬛⬛',
    '⬛⬛⬜⬜⬛⬛⬛⬜⬜⬛⬜⬜⬛⬛⬜⬜⬛⬛',
    '⬛⬛⬜⬜⬛⬛⬛⬜⬜⬛⬜⬜⬛⬛⬜⬜⬛⬛',
    '⬛⬛⬜⬜⬛⬛⬛⬜⬜⬛⬜⬜⬜⬜⬜⬜⬛⬛',
    '⬛⬛⬜⬜⬛⬛⬛⬜⬜⬛⬜⬜⬜⬜⬜⬛⬛⬛',
    '⬛⬛⬜⬜⬛⬛⬛⬜⬜⬛⬜⬜⬛⬛⬛⬛⬛⬛',
    '⬛⬛⬜⬜⬛⬛⬛⬜⬜⬛⬜⬜⬛⬛⬛⬛⬛⬛',
    '⬛⬛⬛⬜⬜⬜⬜⬜⬛⬛⬜⬜⬛⬛⬛⬛⬛⬛',
    '⬛⬛⬛⬛⬜⬜⬜⬛⬛⬛⬜⬜⬛⬛⬛⬛⬛⬛',
    '⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛',
    '⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛'
  ]
end

def big_numbers
  {
    '0' => [
      ' ███████ ',
      '██     ██',
      '██     ██',
      '██     ██',
      ' ███████ '
    ],
    '1' => [
      '    ██   ',
      '  ████   ',
      '    ██   ',
      '    ██   ',
      '  ██████ '
    ],
    '2' => [
      ' ███████ ',
      '       ██',
      ' ███████ ',
      '██       ',
      ' ███████ '
    ],
    '3' => [
      ' ███████ ',
      '       ██',
      ' ███████ ',
      '       ██',
      ' ███████ '
    ],
    '4' => [
      '██     ██',
      '██     ██',
      ' ███████ ',
      '       ██',
      '       ██'
    ],
    '5' => [
      ' ███████ ',
      '██       ',
      ' ███████ ',
      '       ██',
      ' ███████ '
    ],
    '6' => [
      ' ███████ ',
      '██       ',
      ' ███████ ',
      '██     ██',
      ' ███████ '
    ],
    '7' => [
      ' ███████ ',
      '       ██',
      '      ██ ',
      '     ██  ',
      '    ██   '
    ],
    '8' => [
      ' ███████ ',
      '██     ██',
      ' ███████ ',
      '██     ██',
      ' ███████ '
    ],
    '9' => [
      ' ███████ ',
      '██     ██',
      ' ███████ ',
      '       ██',
      ' ███████ '
    ],
    ':' => [
      '         ',
      '   ███   ',
      '         ',
      '   ███   ',
      '         '
    ],
    '+' => [
      '         ',
      '    ██   ',
      '  ██████ ',
      '    ██   ',
      '         '
    ]
  }
end

def render_big_text(text)
  chars = text.chars
  lines = Array.new(5) { '' }

  chars.each do |char|
    next unless big_numbers[char]

    big_numbers[char].each_with_index do |line, i|
      lines[i] += line + '  '
    end
  end

  lines
end

def display_timer(minutes, seconds, rows, cols, overtime: false, title: 'UP')
  clear_screen

  # Calculate center positions
  university_lines = university_art
  university_start_row = (rows - university_lines.length - 10) / 2

  # Display university art
  university_lines.each_with_index do |line, i|
    move_cursor(university_start_row + i, 1)
    puts center_text(line, cols, emoji: true)
  end

  # Display title
  title_row = university_start_row + university_lines.length + 1
  move_cursor(title_row, 1)
  display_title = if overtime
                    "📚 #{title.upcase} - OVERTIME! 📚"
                  else
                    "📚 #{title.upcase} 📚"
                  end
  puts center_text(display_title, cols)

  # Display timer
  timer_text = if overtime
                 format('+%02d:%02d', minutes, seconds)
               else
                 format('%02d:%02d', minutes, seconds)
               end

  timer_lines = render_big_text(timer_text)
  timer_start_row = title_row + 2

  timer_lines.each_with_index do |line, i|
    move_cursor(timer_start_row + i, 1)
    puts center_text(line, cols)
  end

  # Display instructions
  move_cursor(timer_start_row + 6, 1)
  puts center_text('Press CTRL+C to stop and record your time', cols)

  $stdout.flush
end

def log_time_spent(title, duration_minutes)
  csv_file = 'up.csv'

  # Create file with headers if it doesn't exist
  unless File.exist?(csv_file)
    CSV.open(csv_file, 'w') do |csv|
      csv << ['DATE & TIME', 'TASK', 'DESCRIPTION', 'DURATION']
    end
  end

  # Format current date and time
  current_datetime = Time.now.strftime('%Y-%m-%d %H:%M:%S')

  # Clear screen and ask for description
  clear_screen
  print "Enter the description for '#{title}': "
  description = STDIN.gets.chomp

  # Append the new entry
  CSV.open(csv_file, 'a') do |csv|
    csv << [current_datetime, title.downcase, description, duration_minutes.round(2).ceil]
  end

  clear_screen
  puts "Session recorded: #{title} - #{duration_minutes.round(2).ceil} minutes"
  puts "Description: #{description}"
  puts "\nThank you for using UP Timer! 📚"
end

def start_timer(minutes, title)
  # Hide cursor
  print "\033[?25l"

  start_time = Time.now
  seconds = 0
  overtime = false
  total_minutes_spent = 0
  rows, cols = get_terminal_size

  # Handle CTRL+C to stop timer and log time
  Signal.trap('INT') do
    print "\033[?25h" # Restore cursor
    end_time = Time.now
    total_minutes_spent = (end_time - start_time) / 60.0
    clear_screen
    puts "\nTimer stopped. Total time spent: #{total_minutes_spent.round(2)} minutes"
    log_time_spent(title, total_minutes_spent)
    exit
  end

  # Countdown phase
  while minutes >= 0 && !overtime
    while seconds >= 0
      display_timer(minutes, seconds, rows, cols, overtime: false, title: title)

      timer = format('📚 %02d:%02d', minutes, seconds)
      system("tmux rename-window -t 0 '#{title} #{timer}' 2>/dev/null")

      sleep(1)
      seconds -= 1
    end
    seconds = 59
    minutes -= 1

    if minutes % 15 == 0 && minutes > 0
      system("osascript -e 'display notification \"#{minutes}m remaining!\" with title \"UP 📚 TIMER\"' 2>/dev/null")
    end
  end

  # Timer completed, play sound and switch to overtime mode
  system('afplay /System/Library/Sounds/Hero.aiff 2>/dev/null')

  # Flash notification
  3.times do
    system("tmux rename-window -t 0 '📚 TIME COMPLETED 📚' 2>/dev/null")
    sleep(0.5)
    system("tmux rename-window -t 0 '📚 TRACKING OVERTIME 📚' 2>/dev/null")
    sleep(0.5)
  end

  overtime = true

  # Overtime phase - count upward
  while overtime
    elapsed_seconds = (Time.now - start_time).to_i
    overtime_minutes = elapsed_seconds / 60
    overtime_seconds = elapsed_seconds % 60

    display_timer(overtime_minutes, overtime_seconds, rows, cols, overtime: true, title: title)

    timer = format('📚 +%02d:%02d', overtime_minutes, overtime_seconds)
    system("tmux rename-window -t 0 '#{title} #{timer} (OVERTIME)' 2>/dev/null")

    if overtime_minutes % 10 == 0 && overtime_seconds % 5 == 0 && overtime_minutes > 0 && overtime_seconds == 0
      system("osascript -e 'display notification \"📚 #{overtime_minutes}m have passed after the scheduled time\" with title \"⚠️ OVERTIME!! ⚠️\" sound name \"Hero\"' 2>/dev/null")
    end

    sleep(1)
  end
end

# Trap to restore cursor on exit
at_exit { print "\033[?25h" }

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
sleep(2) # Give user time to read the message

start_timer(timer_minutes, title)
