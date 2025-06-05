# frozen_string_literal: true

require_relative '../test_helper'

class PatternsTest < Minitest::Test
  def test_block_pattern_is_stable
    # Block pattern (2x2 square) should remain unchanged
    grid = Grid.new(4, 4)
    grid.set_cell(1, 1, 1)
    grid.set_cell(1, 2, 1)
    grid.set_cell(2, 1, 1)
    grid.set_cell(2, 2, 1)

    grid.next_generation!

    # Block should remain unchanged
    assert_equal 1, grid.cell_at(1, 1)
    assert_equal 1, grid.cell_at(1, 2)
    assert_equal 1, grid.cell_at(2, 1)
    assert_equal 1, grid.cell_at(2, 2)
  end

  def test_blinker_oscillates_correctly
    # Blinker pattern (3 cells in a row) oscillates between horizontal and vertical
    grid = Grid.new(5, 5)
    # Initial horizontal blinker
    grid.set_cell(1, 2, 1)
    grid.set_cell(2, 2, 1)
    grid.set_cell(3, 2, 1)

    grid.next_generation!

    # Should become vertical
    assert_equal 0, grid.cell_at(1, 2)
    assert_equal 1, grid.cell_at(2, 1)
    assert_equal 1, grid.cell_at(2, 2)
    assert_equal 1, grid.cell_at(2, 3)
    assert_equal 0, grid.cell_at(3, 2)
  end

  def test_empty_grid_stays_empty
    grid = Grid.new(3, 3)

    grid.next_generation!

    (0...3).each do |y|
      (0...3).each do |x|
        assert_equal 0, grid.cell_at(x, y)
      end
    end
  end
end