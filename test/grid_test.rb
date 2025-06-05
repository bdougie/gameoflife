# frozen_string_literal: true

require_relative '../test_helper'

class GridTest < Minitest::Test
  def setup
    @grid = Grid.new(3, 3)
  end

  def test_grid_initialization
    assert_equal 3, @grid.width
    assert_equal 3, @grid.height
  end

  def test_cell_starts_dead
    assert_equal 0, @grid.cell_at(0, 0)
    assert_equal 0, @grid.cell_at(1, 1)
    assert_equal 0, @grid.cell_at(2, 2)
  end

  def test_set_cell_alive
    @grid.set_cell(1, 1, 1)

    assert_equal 1, @grid.cell_at(1, 1)
  end

  def test_set_cell_dead
    @grid.set_cell(1, 1, 1)
    @grid.set_cell(1, 1, 0)

    assert_equal 0, @grid.cell_at(1, 1)
  end

  def test_count_neighbors_no_neighbors
    assert_equal 0, @grid.count_neighbors(1, 1)
  end

  def test_count_neighbors_with_one_neighbor
    @grid.set_cell(0, 0, 1)

    assert_equal 1, @grid.count_neighbors(1, 1)
  end

  def test_count_neighbors_with_multiple_neighbors
    @grid.set_cell(0, 0, 1)
    @grid.set_cell(1, 0, 1)
    @grid.set_cell(2, 0, 1)

    assert_equal 3, @grid.count_neighbors(1, 1)
  end

  def test_count_neighbors_wrapping_edges
    # Test toroidal wrapping - neighbors wrap around edges
    @grid.set_cell(2, 2, 1)  # Bottom right

    assert_equal 1, @grid.count_neighbors(0, 0)  # Top left should see bottom right
  end

  def test_display_empty_grid
    expected = "· · ·\n· · ·\n· · ·"

    assert_equal expected, @grid.display
  end

  def test_display_with_live_cells
    @grid.set_cell(0, 0, 1)
    @grid.set_cell(2, 2, 1)
    expected = "█ · ·\n· · ·\n· · █"

    assert_equal expected, @grid.display
  end

  def test_load_pattern
    pattern = [
      [1, 0, 1],
      [0, 1, 0],
      [1, 0, 1]
    ]
    @grid.load_pattern(pattern)

    assert_equal 1, @grid.cell_at(0, 0)
    assert_equal 0, @grid.cell_at(1, 0)
    assert_equal 1, @grid.cell_at(2, 0)
    assert_equal 0, @grid.cell_at(0, 1)
    assert_equal 1, @grid.cell_at(1, 1)
    assert_equal 0, @grid.cell_at(2, 1)
    assert_equal 1, @grid.cell_at(0, 2)
    assert_equal 0, @grid.cell_at(1, 2)
    assert_equal 1, @grid.cell_at(2, 2)
  end
end