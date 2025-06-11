class Grid
  attr_reader :width, :height

  def initialize(width, height)
    @width = width
    @height = height
    @cells = Array.new(height) { Array.new(width, 0) }
  end

  def get_cell(x, y)
    wrapped_x = x % @width
    wrapped_y = y % @height
    @cells[wrapped_y][wrapped_x]
  end

  def set_cell(x, y, value)
    wrapped_x = x % @width
    wrapped_y = y % @height
    @cells[wrapped_y][wrapped_x] = value
  end

  def count_neighbors(x, y)
    count = 0
    (-1..1).each do |dx|
      (-1..1).each do |dy|
        next if dx == 0 && dy == 0  # Skip the cell itself
        neighbor_x = x + dx
        neighbor_y = y + dy
        count += get_cell(neighbor_x, neighbor_y)
      end
    end
    count
  end

  def next_generation
    new_grid = Grid.new(@width, @height)
    
    (0...@height).each do |y|
      (0...@width).each do |x|
        current_state = get_cell(x, y)
        neighbor_count = count_neighbors(x, y)
        
        new_state = if current_state == 1
                      # Living cell rules
                      if neighbor_count < 2
                        0  # Underpopulation
                      elsif neighbor_count == 2 || neighbor_count == 3
                        1  # Survival
                      else
                        0  # Overpopulation
                      end
                    else
                      # Dead cell rules
                      neighbor_count == 3 ? 1 : 0  # Reproduction
                    end
        
        new_grid.set_cell(x, y, new_state)
      end
    end
    
    new_grid
  end

  def display
    @cells.each do |row|
      puts row.map { |cell| cell == 1 ? '█' : ' ' }.join
    end
  end

  def copy_from(other_grid)
    (0...@height).each do |y|
      (0...@width).each do |x|
        set_cell(x, y, other_grid.get_cell(x, y))
      end
    end
  end
end

class GameOfLife
  attr_reader :grid, :generation

  def initialize(width, height)
    @grid = Grid.new(width, height)
    @generation = 0
    seed_random_pattern
  end

  def step
    @grid = @grid.next_generation
    @generation += 1
  end

  def run(generations = 100)
    generations.times do
      system('clear') || system('cls')  # Clear screen
      puts "Generation: #{@generation}"
      @grid.display
      step
      sleep(0.1)  # Pause for visual effect
    end
  end

  private

  def seed_random_pattern
    # Create some interesting initial patterns
    create_glider(5, 5)
    create_block(15, 15)
    create_blinker(10, 10)
    add_random_noise
  end

  def create_glider(x, y)
    pattern = [
      [0, 1, 0],
      [0, 0, 1],
      [1, 1, 1]
    ]
    
    pattern.each_with_index do |row, dy|
      row.each_with_index do |cell, dx|
        @grid.set_cell(x + dx, y + dy, cell)
      end
    end
  end

  def create_block(x, y)
    @grid.set_cell(x, y, 1)
    @grid.set_cell(x + 1, y, 1)
    @grid.set_cell(x, y + 1, 1)
    @grid.set_cell(x + 1, y + 1, 1)
  end

  def create_blinker(x, y)
    @grid.set_cell(x, y, 1)
    @grid.set_cell(x + 1, y, 1)
    @grid.set_cell(x + 2, y, 1)
  end

  def add_random_noise
    # Add some random living cells for interesting evolution
    20.times do
      x = rand(@grid.width)
      y = rand(@grid.height)
      @grid.set_cell(x, y, 1)
    end
  end
end

# Run the game if this file is executed directly
if __FILE__ == $0
  puts "Conway's Game of Life"
  puts "Starting 100 generations..."
  sleep(2)
  
  game = GameOfLife.new(30, 20)
  game.run(100)
  
  puts "\nGame completed after 100 generations!"
end