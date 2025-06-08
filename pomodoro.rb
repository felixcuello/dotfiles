#!/usr/bin/env ruby
# frozen_string_literal: true

require 'io/console'

# This is an implementation of the Pomodoro Technique,
# https://en.wikipedia.org/wiki/Pomodoro_Technique

DEFAULT_TIMER_MINUTES = 25
DEFAULT_TIMER_BREAK = 5
DEFAULT_TIMER_TITLE = 'pomodoro'

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
  padding = (width - text.length) / 2 + (emoji ? -5 : 0)
  ' ' * padding + text
end

def tomato_art
  [
    '         🟩🟩🟩🟩',
    '      🟥🟩🟥🟩🟥🟩🟥',
    '    🟥🟩🟥🟥🟩🟥🟥🟩🟥',
    '  🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥',
    ' 🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥',
    ' 🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥',
    '  🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥',
    '    🟥🟥🟥🟥🟥🟥🟥🟥🟥',
    '      🟥🟥🟥🟥🟥🟥🟥',
    '          🟥🟥🟥'
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

def display_timer(minutes, seconds, rows, cols, is_break: false, title: 'pomodoro')
  clear_screen

  # Calculate center positions
  tomato_lines = tomato_art
  tomato_start_row = (rows - tomato_lines.length - 8) / 2

  # Display tomato
  tomato_lines.each_with_index do |line, i|
    move_cursor(tomato_start_row + i, 1)
    puts center_text(line, cols, emoji: true)
  end

  # Display title
  title_row = tomato_start_row + tomato_lines.length + 1
  move_cursor(title_row, 1)
  display_title = is_break ? '🍅 BREAK TIME! 🍅' : "🍅 #{title.upcase} 🍅"
  puts center_text(display_title, cols)

  # Display timer
  timer_text = format('%02d:%02d', minutes, seconds)
  timer_lines = render_big_text(timer_text)
  timer_start_row = title_row + 2

  timer_lines.each_with_index do |line, i|
    move_cursor(timer_start_row + i, 1)
    puts center_text(line, cols)
  end

  $stdout.flush
end

def display_finished(timer_minutes, title, rows, cols)
  clear_screen

  # Calculate center positions
  tomato_lines = tomato_art
  tomato_start_row = (rows - tomato_lines.length - 12) / 2

  # Display tomato
  tomato_lines.each_with_index do |line, i|
    move_cursor(tomato_start_row + i, 1)
    puts center_text(line, cols, emoji: true)
  end

  # Display finished message
  title_row = tomato_start_row + tomato_lines.length + 1
  move_cursor(title_row, 1)
  puts center_text("🍅 #{title.upcase} FINISHED! 🍅", cols)

  # Display "TIME'S UP!" in big letters
  finished_lines = render_big_text("TIME'S UP!")
  finished_start_row = title_row + 2

  finished_lines.each_with_index do |line, i|
    move_cursor(finished_start_row + i, 1)
    puts center_text(line, cols)
  end

  # Display completion time
  move_cursor(finished_start_row + 6, 1)
  puts center_text("#{timer_minutes} minutes completed!", cols)

  $stdout.flush
end

def start_timer(minutes, is_break: false, title: 'pomodoro')
  rows, cols = get_terminal_size
  seconds = 0

  while minutes >= 0
    while seconds >= 0
      # Display visual timer
      display_timer(minutes, seconds, rows, cols, is_break: is_break, title: title)

      # Also update tmux window title for compatibility
      timer = format('🍅 %02d:%02d', minutes, seconds)
      system("tmux rename-window -t 0 '#{is_break ? 'break! =)' : title} #{timer}' 2>/dev/null")

      sleep(1)
      seconds -= 1
    end
    seconds = 59
    minutes -= 1
  end

  [rows, cols]
end

# Hide cursor
print "\033[?25l"

# Trap interrupt to restore cursor
trap('INT') do
  print "\033[?25h"
  clear_screen
  exit
end

is_break = false
timer_minutes = is_break ? DEFAULT_TIMER_BREAK : DEFAULT_TIMER_MINUTES
title = DEFAULT_TIMER_TITLE

if ARGV.count == 2 # If we run: ./pomodoro.rb <title> <minutes>
  title = ARGV[0]
  timer_minutes = ARGV[1].to_i if ARGV[1].to_i.positive?
  is_break = false
elsif ARGV[0] == 'break' # if we take a break: ./pomodoro.rb break
  is_break = true
  timer_minutes = 5 # Default break time
elsif ARGV[0] # if we run either with a number or a title: ./pomodoro.rb <title|minutes>
  if ARGV[0].to_i.positive?
    timer_minutes = ARGV[0].to_i
  else
    title = ARGV[0]
  end

  is_break = false
end

rows, cols = start_timer(timer_minutes, is_break: is_break, title: title)

# Show completion screen and notifications
3.times do
  display_finished(timer_minutes, title, rows, cols)
  system("osascript -e 'display notification \"#{timer_minutes}m have passed!\" with title \"🍅 POMODORO 🍅\" sound name \"Hero\"' 2>/dev/null")
  sleep 5
end

# Keep showing finished screen
while true
  display_finished(timer_minutes, title, rows, cols)
  system("tmux rename-window -t 0 '⚠️🍅 FINISHED 🍅⚠️' 2>/dev/null")
  system("osascript -e 'display notification \"#{timer_minutes}m have passed!\" with title \"🍅 #{title} - Has Finished 🍅\"' 2>/dev/null")
  sleep 300
end

# Restore cursor on exit
at_exit { print "\033[?25h" }
