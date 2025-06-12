require_relative '../game_of_life'

RSpec.describe GameOfLife do
  describe '#initialize' do
    it 'creates a game with a grid' do
      game = GameOfLife.new(5, 5)
      expect(game.grid).to be_a(Grid)
      expect(game.grid.rows).to eq(5)
      expect(game.grid.cols).to eq(5)
    end
  end

  describe '#next_generation' do
    it 'applies Conway rules: underpopulation (lonely cell dies)' do
      game = GameOfLife.new(3, 3)
      game.grid.set_cell(1, 1, 1) # Lonely cell
      
      game.next_generation
      
      expect(game.grid.get_cell(1, 1)).to eq(0) # Should die
    end

    it 'applies Conway rules: stable structures (block remains unchanged)' do
      game = GameOfLife.new(4, 4)
      # Create a 2x2 block (stable structure)
      game.grid.set_cell(1, 1, 1)
      game.grid.set_cell(1, 2, 1)
      game.grid.set_cell(2, 1, 1)
      game.grid.set_cell(2, 2, 1)
      
      game.next_generation
      
      # Block should remain unchanged
      expect(game.grid.get_cell(1, 1)).to eq(1)
      expect(game.grid.get_cell(1, 2)).to eq(1)
      expect(game.grid.get_cell(2, 1)).to eq(1)
      expect(game.grid.get_cell(2, 2)).to eq(1)
    end

    it 'applies Conway rules: reproduction (dead cell with 3 neighbors comes alive)' do
      game = GameOfLife.new(3, 3)
      # Create pattern where center cell should come alive
      game.grid.set_cell(0, 1, 1) # top
      game.grid.set_cell(1, 0, 1) # left
      game.grid.set_cell(1, 2, 1) # right
      # Center cell (1,1) is dead but has 3 neighbors
      
      game.next_generation
      
      expect(game.grid.get_cell(1, 1)).to eq(1) # Should come alive
    end

    it 'applies Conway rules: overpopulation (cell with >3 neighbors dies)' do
      game = GameOfLife.new(3, 3)
      # Create pattern where center cell has 4+ neighbors
      game.grid.set_cell(1, 1, 1) # center cell alive
      game.grid.set_cell(0, 0, 1) # neighbor 1
      game.grid.set_cell(0, 1, 1) # neighbor 2
      game.grid.set_cell(0, 2, 1) # neighbor 3
      game.grid.set_cell(1, 0, 1) # neighbor 4
      
      game.next_generation
      
      expect(game.grid.get_cell(1, 1)).to eq(0) # Should die from overpopulation
    end

    it 'applies Conway rules: survival (cell with 2-3 neighbors survives)' do
      game = GameOfLife.new(3, 3)
      # Create pattern where center cell has exactly 2 neighbors
      game.grid.set_cell(1, 1, 1) # center cell alive
      game.grid.set_cell(0, 1, 1) # neighbor 1
      game.grid.set_cell(1, 0, 1) # neighbor 2
      
      game.next_generation
      
      expect(game.grid.get_cell(1, 1)).to eq(1) # Should survive
    end
  end
end