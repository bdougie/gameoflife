# frozen_string_literal: true

require_relative 'grid'

# Main Game of Life class that orchestrates the simulation
class GameOfLife
  attr_reader :grid, :generation

  def initialize(width, height)
    @grid = Grid.new(width, height)
    @generation = 0
  end

  def load_pattern(pattern_data)
    @grid.load_pattern(pattern_data)
  end

  def evolve!
    @grid.next_generation!
    @generation += 1
  end

  def display
    puts "Generation #{@generation}:"
    puts @grid.display
    puts
  end

  def run(generations = 10, delay = 1)
    display
    
    generations.times do
      sleep(delay)
      evolve!
      system('clear') || system('cls')  # Clear screen
      display
    end
  end
end