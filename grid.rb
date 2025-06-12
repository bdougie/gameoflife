class Grid
  attr_reader :rows, :cols, :cells

  def initialize(rows, cols)
    @rows = rows
    @cols = cols
    @cells = Array.new(rows) { Array.new(cols, 0) }
  end

  def set_cell(row, col, value)
    @cells[row][col] = value
  end

  def get_cell(row, col)
    @cells[row][col]
  end

  def count_neighbors(row, col)
    count = 0
    
    # Check all 8 directions around the cell
    (-1..1).each do |dr|
      (-1..1).each do |dc|
        next if dr == 0 && dc == 0 # Skip the cell itself
        
        # Calculate neighbor coordinates with wrapping
        neighbor_row = (row + dr) % @rows
        neighbor_col = (col + dc) % @cols
        
        count += @cells[neighbor_row][neighbor_col]
      end
    end
    
    count
  end
end