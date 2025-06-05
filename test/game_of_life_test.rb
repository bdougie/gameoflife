# frozen_string_literal: true

require_relative '../test_helper'

class GameOfLifeTest < Minitest::Test
  def setup
    @game = GameOfLife.new(5, 5)
  end

  def test_initialization
    assert_equal 5, @game.grid.width
    assert_equal 5, @game.grid.height
    assert_equal 0, @game.generation
  end

  def test_evolve_increments_generation
    @game.evolve!

    assert_equal 1, @game.generation
  end

  def test_multiple_evolve_calls
    3.times { @game.evolve! }

    assert_equal 3, @game.generation
  end

  def test_load_pattern
    pattern = [
      [1, 0, 1],
      [0, 1, 0],
      [1, 0, 1]
    ]
    @game.load_pattern(pattern)

    assert_equal 1, @game.grid.cell_at(0, 0)
    assert_equal 0, @game.grid.cell_at(1, 0)
    assert_equal 1, @game.grid.cell_at(1, 1)
  end

  def test_display_includes_generation
    output = capture_output { @game.display }

    assert_includes output, "Generation 0:"
  end

  private

  def capture_output
    old_stdout = $stdout
    $stdout = StringIO.new
    yield
    $stdout.string
  ensure
    $stdout = old_stdout
  end
end