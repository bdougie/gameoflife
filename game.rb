# frozen_string_literal: true

class GameOfLife
  attr_reader :grid, :rows, :cols

  def initialize(rows, cols)
    @rows = rows
    @cols = cols
    @grid = Array.new(rows) { Array.new(cols, 0) }
  end

  # Randomly populate the grid with live cells
  def randomize(density = 0.3)
    @grid = Array.new(rows) do
      Array.new(cols) do
        rand < density ? 1 : 0
      end
    end
    self
  end

  # Set a specific cell as alive (1) or dead (0)
  def set_cell(row, col, state)
    return self unless valid_position?(row, col)
    
    @grid[row][col] = state
    self
  end

  # Get the state of a specific cell
  def get_cell(row, col)
    return 0 unless valid_position?(row, col)
    
    @grid[row][col]
  end

  # Add a glider pattern at the specified position
  def add_glider(row, col)
    return self unless valid_position?(row + 2, col + 2)
    
    # Glider pattern:
    # .O.
    # ..O
    # OOO
    set_cell(row, col + 1, 1)
    set_cell(row + 1, col + 2, 1)
    set_cell(row + 2, col, 1)
    set_cell(row + 2, col + 1, 1)
    set_cell(row + 2, col + 2, 1)
    self
  end

  # Add a blinker pattern (vertical line of 3 cells)
  def add_blinker(row, col)
    return self unless valid_position?(row + 2, col)
    
    set_cell(row, col, 1)
    set_cell(row + 1, col, 1)
    set_cell(row + 2, col, 1)
    self
  end

  # Calculate the next generation based on Conway's Game of Life rules
  def next_generation
    new_grid = Array.new(rows) { Array.new(cols, 0) }
    
    (0...rows).each do |row|
      (0...cols).each do |col|
        live_neighbors = count_live_neighbors(row, col)
        current_state = get_cell(row, col)
        
        new_grid[row][col] = determine_cell_state(current_state, live_neighbors)
      end
    end
    
    @grid = new_grid
    self
  end

  # Display the current state of the grid in the console
  def display
    system('clear') || system('cls')
    
    puts '+' + '-' * cols + '+'
    @grid.each do |row|
      print '|'
      row.each do |cell|
        print cell == 1 ? '■' : ' '
      end
      puts '|'
    end
    puts '+' + '-' * cols + '+'
    self
  end

  # Get a string representation of the grid
  def to_s
    result = ""
    @grid.each do |row|
      row.each do |cell|
        result += cell == 1 ? '■' : ' '
      end
      result += "\n"
    end
    result
  end

  private

  def valid_position?(row, col)
    row >= 0 && row < rows && col >= 0 && col < cols
  end

  def count_live_neighbors(row, col)
    count = 0
    
    (-1..1).each do |dr|
      (-1..1).each do |dc|
        next if dr == 0 && dc == 0 # Skip the cell itself
        
        r, c = row + dr, col + dc
        count += 1 if valid_position?(r, c) && @grid[r][c] == 1
      end
    end
    
    count
  end

  def determine_cell_state(current_state, live_neighbors)
    if current_state == 1 && (live_neighbors < 2 || live_neighbors > 3)
      # Rule 1 & 3: Any live cell with fewer than 2 or more than 3 live neighbors dies
      0
    elsif current_state == 1 && (live_neighbors == 2 || live_neighbors == 3)
      # Rule 2: Any live cell with 2 or 3 live neighbors lives on
      1
    elsif current_state == 0 && live_neighbors == 3
      # Rule 4: Any dead cell with exactly 3 live neighbors becomes alive
      1
    else
      # Otherwise, the cell state remains the same
      current_state
    end
  end
end

# Example usage (only runs when script is executed directly)
if __FILE__ == $PROGRAM_NAME
  # Create a 20x40 grid
  game = GameOfLife.new(20, 40)
  
  # Add some patterns
  game.add_glider(1, 1)
  game.add_blinker(5, 20)
  game.add_blinker(10, 30)
  
  # Run the simulation for 100 generations
  100.times do
    game.display
    game.next_generation
    sleep 0.1 # Adjust speed as needed
  end
end