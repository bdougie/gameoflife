#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/game_of_life'
require_relative 'lib/patterns'

def demo_blinker
  puts "=== BLINKER DEMO ==="
  game = GameOfLife.new(5, 5)
  
  # Center the blinker
  centered_blinker = Array.new(5) { Array.new(5, 0) }
  Patterns::BLINKER.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      centered_blinker[y + 1][x + 1] = cell
    end
  end
  
  game.load_pattern(centered_blinker)
  game.run(6, 1)
end

def demo_glider
  puts "=== GLIDER DEMO ==="
  game = GameOfLife.new(10, 10)
  
  # Place glider in top-left
  extended_pattern = Array.new(10) { Array.new(10, 0) }
  Patterns::GLIDER.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      extended_pattern[y + 1][x + 1] = cell
    end
  end
  
  game.load_pattern(extended_pattern)
  game.run(15, 0.5)
end

def demo_block
  puts "=== BLOCK (Still Life) DEMO ==="
  game = GameOfLife.new(4, 4)
  
  # Center the block
  centered_block = Array.new(4) { Array.new(4, 0) }
  Patterns::BLOCK.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      centered_block[y + 1][x + 1] = cell
    end
  end
  
  game.load_pattern(centered_block)
  game.run(5, 1)
end

def main
  if ARGV.empty?
    puts "Conway's Game of Life Demo"
    puts "Usage: ruby demo.rb [pattern]"
    puts "Available patterns: blinker, glider, block"
    puts "Example: ruby demo.rb blinker"
    return
  end

  case ARGV[0].downcase
  when 'blinker'
    demo_blinker
  when 'glider'
    demo_glider
  when 'block'
    demo_block
  else
    puts "Unknown pattern: #{ARGV[0]}"
    puts "Available patterns: blinker, glider, block"
  end
end

main if __FILE__ == $0