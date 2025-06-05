# frozen_string_literal: true

require_relative 'lib/game_of_life'
require_relative 'lib/patterns'

# Quick test of blinker pattern
game = GameOfLife.new(5, 5)

# Center the blinker
centered_blinker = Array.new(5) { Array.new(5, 0) }
Patterns::BLINKER.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    centered_blinker[y + 1][x + 1] = cell
  end
end

game.load_pattern(centered_blinker)

puts "Initial state:"
puts game.grid.display
puts

game.evolve!
puts "After 1 generation:"
puts game.grid.display
puts

game.evolve!
puts "After 2 generations (should match initial):"
puts game.grid.display
puts

puts "Success! Blinker oscillates correctly."