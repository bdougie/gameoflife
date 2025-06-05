# frozen_string_literal: true

require_relative '../test_helper'

class GameEvolutionTest < Minitest::Test
  def setup
    @grid = Grid.new(3, 3)
  end

  def test_underpopulation_alive_cell_with_zero_neighbors_dies
    @grid.set_cell(1, 1, 1)  # Alive cell with no neighbors
    
    @grid.next_generation!

    assert_equal 0, @grid.cell_at(1, 1)
  end

  def test_underpopulation_alive_cell_with_one_neighbor_dies
    @grid.set_cell(1, 1, 1)  # Alive cell
    @grid.set_cell(0, 0, 1)  # One neighbor
    
    @grid.next_generation!

    assert_equal 0, @grid.cell_at(1, 1)
  end

  def test_survival_alive_cell_with_two_neighbors_survives
    @grid.set_cell(1, 1, 1)  # Alive cell
    @grid.set_cell(0, 0, 1)  # First neighbor
    @grid.set_cell(0, 1, 1)  # Second neighbor
    
    @grid.next_generation!

    assert_equal 1, @grid.cell_at(1, 1)
  end

  def test_survival_alive_cell_with_three_neighbors_survives
    @grid.set_cell(1, 1, 1)  # Alive cell
    @grid.set_cell(0, 0, 1)  # First neighbor
    @grid.set_cell(0, 1, 1)  # Second neighbor
    @grid.set_cell(1, 0, 1)  # Third neighbor
    
    @grid.next_generation!

    assert_equal 1, @grid.cell_at(1, 1)
  end

  def test_overpopulation_alive_cell_with_four_neighbors_dies
    @grid.set_cell(1, 1, 1)  # Alive cell
    @grid.set_cell(0, 0, 1)  # Neighbors
    @grid.set_cell(0, 1, 1)
    @grid.set_cell(1, 0, 1)
    @grid.set_cell(2, 0, 1)
    
    @grid.next_generation!

    assert_equal 0, @grid.cell_at(1, 1)
  end

  def test_reproduction_dead_cell_with_three_neighbors_becomes_alive
    @grid.set_cell(1, 1, 0)  # Dead cell
    @grid.set_cell(0, 0, 1)  # Three neighbors
    @grid.set_cell(0, 1, 1)
    @grid.set_cell(1, 0, 1)
    
    @grid.next_generation!

    assert_equal 1, @grid.cell_at(1, 1)
  end

  def test_dead_cell_with_two_neighbors_stays_dead
    @grid.set_cell(1, 1, 0)  # Dead cell
    @grid.set_cell(0, 0, 1)  # Two neighbors
    @grid.set_cell(0, 1, 1)
    
    @grid.next_generation!

    assert_equal 0, @grid.cell_at(1, 1)
  end
end