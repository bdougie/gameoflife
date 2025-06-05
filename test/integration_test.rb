# frozen_string_literal: true

require_relative '../test_helper'

class IntegrationTest < Minitest::Test
  def test_complete_blinker_cycle
    game = GameOfLife.new(5, 5)
    
    # Load blinker pattern
    centered_blinker = Array.new(5) { Array.new(5, 0) }
    Patterns::BLINKER.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        centered_blinker[y + 1][x + 1] = cell
      end
    end
    
    game.load_pattern(centered_blinker)
    
    # Store initial state
    initial_state = game.grid.display

    # Should oscillate with period 2
    game.evolve!
    first_evolution = game.grid.display
    
    game.evolve!
    second_evolution = game.grid.display

    # After 2 generations, should return to initial state
    assert_equal initial_state, second_evolution
    refute_equal initial_state, first_evolution
    assert_equal 2, game.generation
  end

  def test_glider_movement_with_wrapping
    # Small grid to test wrapping
    game = GameOfLife.new(6, 6)
    
    # Place glider pattern
    glider_pattern = Array.new(6) { Array.new(6, 0) }
    Patterns::GLIDER.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        glider_pattern[y][x] = cell
      end
    end
    
    game.load_pattern(glider_pattern)
    
    # Evolve multiple generations
    4.times { game.evolve! }
    
    # Glider should have moved diagonally
    # Due to toroidal wrapping, it should still be alive somewhere
    alive_cells = 0
    (0...6).each do |y|
      (0...6).each do |x|
        alive_cells += game.grid.cell_at(x, y)
      end
    end

    # Glider maintains 5 alive cells
    assert_equal 5, alive_cells
    assert_equal 4, game.generation
  end

  def test_block_stability
    game = GameOfLife.new(4, 4)
    
    # Load block pattern in center
    block_pattern = Array.new(4) { Array.new(4, 0) }
    Patterns::BLOCK.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        block_pattern[y + 1][x + 1] = cell
      end
    end
    
    game.load_pattern(block_pattern)
    
    initial_state = game.grid.display
    
    # Evolve multiple generations
    10.times { game.evolve! }

    # Block should remain unchanged
    assert_equal initial_state, game.grid.display
    assert_equal 10, game.generation
  end

  def test_empty_grid_evolution
    game = GameOfLife.new(3, 3)
    
    initial_state = game.grid.display
    
    # Empty grid should remain empty
    5.times { game.evolve! }

    assert_equal initial_state, game.grid.display
    assert_equal 5, game.generation
  end
end