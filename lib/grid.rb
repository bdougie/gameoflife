# frozen_string_literal: true

# Grid class for Conway's Game of Life
class Grid
  attr_reader :width, :height

  def initialize(width, height)
    @width = width
    @height = height
    @cells = Array.new(height) { Array.new(width, 0) }
  end

  def cell_at(x, y)
    @cells[y][x]
  end

  def set_cell(x, y, value)
    @cells[y][x] = value
  end

  def count_neighbors(x, y)
    count = 0
    
    # Check all 8 neighboring positions
    (-1..1).each do |dy|
      (-1..1).each do |dx|
        next if dx == 0 && dy == 0  # Skip the cell itself
        
        neighbor_x = wrap_coordinate(x + dx, @width)
        neighbor_y = wrap_coordinate(y + dy, @height)
        
        count += @cells[neighbor_y][neighbor_x]
      end
    end
    
    count
  end

  def next_generation!
    new_cells = Array.new(@height) { Array.new(@width, 0) }
    
    (0...@height).each do |y|
      (0...@width).each do |x|
        neighbors = count_neighbors(x, y)
        current_state = @cells[y][x]
        
        new_cells[y][x] = apply_conway_rules(current_state, neighbors)
      end
    end
    
    @cells = new_cells
  end

  def display
    @cells.map do |row|
      row.map { |cell| cell == 1 ? '█' : '·' }.join(' ')
    end.join("\n")
  end

  def load_pattern(pattern_data)
    pattern_data.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        set_cell(x, y, cell)
      end
    end
  end

  private

  def wrap_coordinate(coordinate, max)
    coordinate % max
  end

  def apply_conway_rules(current_state, neighbors)
    if current_state == 1  # Alive cell
      if neighbors < 2
        0  # Dies from underpopulation
      elsif neighbors == 2 || neighbors == 3
        1  # Survives
      else
        0  # Dies from overpopulation
      end
    else  # Dead cell
      if neighbors == 3
        1  # Becomes alive through reproduction
      else
        0  # Stays dead
      end
    end
  end
end