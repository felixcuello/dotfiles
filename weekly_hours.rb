#!/usr/bin/env ruby

require 'csv'
require 'date'

def find_monday_of_week(date)
  # Find the Monday of the week for the given date
  days_since_monday = (date.wday - 1) % 7
  date - days_since_monday
end

def minutes_to_hours_minutes(minutes)
  hours = minutes / 60
  mins = minutes % 60
  "#{hours}:#{mins.to_s.rjust(2, '0')}hs"
end

def format_week_date(monday_date)
  "#{monday_date.strftime('%B')} #{monday_date.day}#{ordinal_suffix(monday_date.day)}"
end

def ordinal_suffix(day)
  case day
  when 1, 21, 31
    'st'
  when 2, 22
    'nd'
  when 3, 23
    'rd'
  else
    'th'
  end
end

# Read CSV file
csv_file = ARGV[0] || 'up.csv'
unless File.exist?(csv_file)
  puts "Error: #{csv_file} not found!"
  exit 1
end

# Data structure to store weekly data
weekly_data = Hash.new { |h, k| h[k] = Hash.new(0) }

# Parse CSV
CSV.foreach(csv_file, headers: true) do |row|
  date_time = DateTime.parse(row['DATE & TIME'])
  task = row['TASK']
  duration = row['DURATION'].to_i

  # Find the Monday of this week
  monday = find_monday_of_week(date_time.to_date)

  # Add duration to the weekly task totals
  weekly_data[monday][task] += duration
end

# Sort weeks by date and output results
weekly_data.keys.sort.each do |monday|
  week_tasks = weekly_data[monday]
  total_minutes = week_tasks.values.sum

  # Format week header
  week_label = format_week_date(monday)
  total_hours = minutes_to_hours_minutes(total_minutes)

  # Format task breakdown
  task_breakdown = week_tasks.sort.map do |task, minutes|
    "#{task.upcase}: #{minutes_to_hours_minutes(minutes)}"
  end.join(', ')

  puts "Week - #{week_label} => #{total_hours}\n    #{task_breakdown}"
  puts ""
end
