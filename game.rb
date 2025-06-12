require_relative 'game_of_life'

class GameRunner
  def initialize(rows = 20, cols = 20)
    @game = GameOfLife.new(rows, cols)
    @generation = 0
    setup_initial_pattern
  end

  def run(generations = 100)
    puts "Conway's Game of Life - Starting simulation"
    puts "Grid size: #{@game.grid.rows}x#{@game.grid.cols}"
    puts "Generations to run: #{generations}"
    puts ""

    display_grid
    gets if interactive_mode?

    generations.times do |i|
      @generation += 1
      @game.next_generation
      
      puts "Generation #{@generation}:"
      display_grid
      
      if interactive_mode?
        puts "Press Enter for next generation, 'q' to quit..."
        input = gets.chomp
        break if input.downcase == 'q'
      else
        sleep(0.1) # Small delay for visual effect
      end
    end

    puts "\nSimulation completed after #{@generation} generations."
  end

  private

  def setup_initial_pattern
    # Create a simple "glider" pattern as initial state
    # This is a well-known pattern that moves across the grid
    @game.grid.set_cell(1, 2, 1)
    @game.grid.set_cell(2, 3, 1)
    @game.grid.set_cell(3, 1, 1)
    @game.grid.set_cell(3, 2, 1)
    @game.grid.set_cell(3, 3, 1)
  end

  def display_grid
    puts "+" + "-" * (@game.grid.cols * 2 + 1) + "+"
    @game.grid.cells.each do |row|
      print "| "
      row.each do |cell|
        print cell == 1 ? "█ " : "  "
      end
      puts "|"
    end
    puts "+" + "-" * (@game.grid.cols * 2 + 1) + "+"
    puts ""
  end

  def interactive_mode?
    ARGV.include?('--interactive') || ARGV.include?('-i')
  end
end

# Run the game if this file is executed directly
if __FILE__ == $0
  generations = ARGV.find { |arg| arg.match(/^\d+$/) }&.to_i || 100
  runner = GameRunner.new
  runner.run(generations)
end