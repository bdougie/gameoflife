# frozen_string_literal: true

require_relative 'test_helper'

class GameOfLifeTest < Minitest::Test
  def setup
    @game = GameOfLife.new(5, 5)
  end

  def test_initialization
    assert_equal 5, @game.rows
    
    assert_equal 5, @game.cols
    
    assert_equal 5, @game.grid.size
    
    assert_equal 5, @game.grid[0].size
    
    assert_equal 0, @game.grid[0][0]
  end

  def test_set_and_get_cell
    @game.set_cell(1, 2, 1)
    
    assert_equal 1, @game.get_cell(1, 2)
    
    assert_equal 0, @game.get_cell(0, 0)
  end

  def test_set_cell_outside_grid
    # Should not raise an error and should return self
    result = @game.set_cell(10, 10, 1)
    
    assert_equal @game, result
    
    assert_equal 0, @game.get_cell(4, 4) # Last valid cell still untouched
  end

  def test_get_cell_outside_grid
    # Should return 0 for cells outside the grid
    assert_equal 0, @game.get_cell(10, 10)
  end

  def test_randomize
    # Mock rand to return predictable values
    srand(42) # Set a fixed seed for reproducible test
    
    @game.randomize(0.5)
    
    # Count live cells to verify some are populated
    live_count = @game.grid.flatten.count { |cell| cell == 1 }
    
    assert live_count > 0, "Randomize should create some live cells"
    
    assert live_count < 25, "Randomize should not make all cells alive"
  end

  def test_add_glider
    @game.add_glider(0, 0)
    
    # Check glider pattern:
    # .O.
    # ..O
    # OOO
    assert_equal 0, @game.get_cell(0, 0)
    
    assert_equal 1, @game.get_cell(0, 1)
    
    assert_equal 0, @game.get_cell(0, 2)
    
    assert_equal 0, @game.get_cell(1, 0)
    
    assert_equal 0, @game.get_cell(1, 1)
    
    assert_equal 1, @game.get_cell(1, 2)
    
    assert_equal 1, @game.get_cell(2, 0)
    
    assert_equal 1, @game.get_cell(2, 1)
    
    assert_equal 1, @game.get_cell(2, 2)
  end

  def test_add_blinker
    @game.add_blinker(1, 1)
    
    # Check vertical blinker pattern
    assert_equal 1, @game.get_cell(1, 1)
    
    assert_equal 1, @game.get_cell(2, 1)
    
    assert_equal 1, @game.get_cell(3, 1)
  end

  def test_to_s
    @game.set_cell(0, 0, 1)
    @game.set_cell(1, 1, 1)
    @game.set_cell(2, 2, 1)
    
    expected = "■    \n ■   \n  ■  \n     \n     \n"
    
    assert_equal expected, @game.to_s
  end

  def test_next_generation_empty_grid_stays_empty
    @game.next_generation
    
    assert_equal 0, @game.grid.flatten.sum, "Empty grid should stay empty"
  end

  def test_next_generation_underpopulation
    # Set up a single live cell which should die
    @game.set_cell(2, 2, 1)
    
    @game.next_generation
    
    assert_equal 0, @game.get_cell(2, 2), "Cell should die from underpopulation"
  end

  def test_next_generation_overpopulation
    # Set up a cell with 4 neighbors which should die
    @game.set_cell(1, 1, 1) # Center cell
    @game.set_cell(0, 0, 1) # Neighbors
    @game.set_cell(0, 1, 1)
    @game.set_cell(0, 2, 1)
    @game.set_cell(1, 0, 1)
    
    @game.next_generation
    
    assert_equal 0, @game.get_cell(1, 1), "Cell should die from overpopulation"
  end

  def test_next_generation_survival
    # Set up a cell with 2 neighbors which should survive
    @game.set_cell(1, 1, 1) # Center cell
    @game.set_cell(0, 0, 1) # Neighbors
    @game.set_cell(0, 1, 1)
    
    @game.next_generation
    
    assert_equal 1, @game.get_cell(1, 1), "Cell should survive with 2 neighbors"
  end

  def test_next_generation_reproduction
    # Set up a dead cell with exactly 3 neighbors which should become alive
    @game.set_cell(0, 0, 1)
    @game.set_cell(0, 1, 1)
    @game.set_cell(1, 0, 1)
    
    @game.next_generation
    
    assert_equal 1, @game.get_cell(1, 1), "Cell should become alive with 3 neighbors"
  end

  def test_blinker_oscillation
    # Create a blinker and verify it oscillates correctly
    @game = GameOfLife.new(5, 5)
    @game.add_blinker(1, 2)
    
    # Initial state - vertical blinker
    assert_equal 1, @game.get_cell(1, 2)
    
    assert_equal 1, @game.get_cell(2, 2)
    
    assert_equal 1, @game.get_cell(3, 2)
    
    # After one step - horizontal blinker
    @game.next_generation
    
    assert_equal 0, @game.get_cell(1, 2)
    
    assert_equal 1, @game.get_cell(2, 1)
    
    assert_equal 1, @game.get_cell(2, 2)
    
    assert_equal 1, @game.get_cell(2, 3)
    
    assert_equal 0, @game.get_cell(3, 2)
    
    # After another step - back to vertical
    @game.next_generation
    
    assert_equal 1, @game.get_cell(1, 2)
    
    assert_equal 1, @game.get_cell(2, 2)
    
    assert_equal 1, @game.get_cell(3, 2)
  end
end