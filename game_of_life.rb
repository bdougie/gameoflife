require_relative 'grid'

class GameOfLife
  attr_reader :grid

  def initialize(rows, cols)
    @grid = Grid.new(rows, cols)
  end

  def next_generation
    new_cells = Array.new(@grid.rows) { Array.new(@grid.cols, 0) }

    (0...@grid.rows).each do |row|
      (0...@grid.cols).each do |col|
        neighbors = @grid.count_neighbors(row, col)
        current_state = @grid.get_cell(row, col)

        new_cells[row][col] = apply_conway_rules(current_state, neighbors)
      end
    end

    # Update the grid with new generation
    (0...@grid.rows).each do |row|
      (0...@grid.cols).each do |col|
        @grid.set_cell(row, col, new_cells[row][col])
      end
    end
  end

  private

  def apply_conway_rules(current_state, neighbors)
    if current_state == 1 # Cell is alive
      if neighbors < 2
        0 # Dies from underpopulation
      elsif neighbors == 2 || neighbors == 3
        1 # Survives
      else
        0 # Dies from overpopulation
      end
    else # Cell is dead
      if neighbors == 3
        1 # Comes alive through reproduction
      else
        0 # Stays dead
      end
    end
  end
end