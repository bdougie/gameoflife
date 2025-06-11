require_relative '../game'

RSpec.describe Grid do
  describe '#initialize' do
    it 'creates a grid with specified dimensions' do
      grid = Grid.new(5, 5)
      expect(grid.width).to eq(5)
      expect(grid.height).to eq(5)
    end

    it 'initializes all cells as dead (0)' do
      grid = Grid.new(3, 3)
      (0..2).each do |x|
        (0..2).each do |y|
          expect(grid.get_cell(x, y)).to eq(0)
        end
      end
    end
  end

  describe '#set_cell and #get_cell' do
    let(:grid) { Grid.new(3, 3) }

    it 'sets and gets cell values' do
      grid.set_cell(1, 1, 1)
      expect(grid.get_cell(1, 1)).to eq(1)
    end

    it 'wraps coordinates for toroidal boundaries' do
      grid.set_cell(-1, -1, 1)  # Should wrap to (2, 2)
      expect(grid.get_cell(2, 2)).to eq(1)
      
      grid.set_cell(3, 3, 1)    # Should wrap to (0, 0)
      expect(grid.get_cell(0, 0)).to eq(1)
    end
  end

  describe '#count_neighbors' do
    let(:grid) { Grid.new(5, 5) }

    it 'counts living neighbors correctly' do
      # Create a 3x3 block of living cells
      grid.set_cell(1, 1, 1)
      grid.set_cell(1, 2, 1)
      grid.set_cell(2, 1, 1)
      
      expect(grid.count_neighbors(1, 1)).to eq(2)
      expect(grid.count_neighbors(2, 2)).to eq(3)
      expect(grid.count_neighbors(0, 0)).to eq(1)
    end

    it 'handles toroidal neighbor counting' do
      grid.set_cell(0, 0, 1)
      grid.set_cell(4, 4, 1)  # Corner neighbors due to wrapping
      
      expect(grid.count_neighbors(0, 0)).to eq(1)
      expect(grid.count_neighbors(4, 4)).to eq(1)
    end
  end

  describe '#next_generation' do
    let(:grid) { Grid.new(5, 5) }

    it 'applies underpopulation rule - lonely cell dies' do
      grid.set_cell(2, 2, 1)  # Single living cell
      new_grid = grid.next_generation
      
      expect(new_grid.get_cell(2, 2)).to eq(0)
    end

    it 'applies survival rule - cell with 2-3 neighbors survives' do
      # Create stable block pattern
      grid.set_cell(1, 1, 1)
      grid.set_cell(1, 2, 1)
      grid.set_cell(2, 1, 1)
      grid.set_cell(2, 2, 1)
      
      new_grid = grid.next_generation
      
      expect(new_grid.get_cell(1, 1)).to eq(1)
      expect(new_grid.get_cell(1, 2)).to eq(1)
      expect(new_grid.get_cell(2, 1)).to eq(1)
      expect(new_grid.get_cell(2, 2)).to eq(1)
    end

    it 'applies overpopulation rule - cell with >3 neighbors dies' do
      # Create pattern where center cell has 4+ neighbors
      grid.set_cell(1, 1, 1)
      grid.set_cell(1, 2, 1)
      grid.set_cell(1, 3, 1)
      grid.set_cell(2, 1, 1)
      grid.set_cell(2, 2, 1)  # This cell will have 4 neighbors
      grid.set_cell(2, 3, 1)
      
      new_grid = grid.next_generation
      
      expect(new_grid.get_cell(2, 2)).to eq(0)
    end

    it 'applies reproduction rule - dead cell with exactly 3 neighbors comes alive' do
      # Create L-shape pattern
      grid.set_cell(1, 1, 1)
      grid.set_cell(1, 2, 1)
      grid.set_cell(2, 1, 1)
      # Cell at (2, 2) should come alive with 3 neighbors
      
      new_grid = grid.next_generation
      
      expect(new_grid.get_cell(2, 2)).to eq(1)
    end
  end
end

RSpec.describe GameOfLife do
  describe '#initialize' do
    it 'creates a game with specified grid size' do
      game = GameOfLife.new(10, 10)
      expect(game.generation).to eq(0)
    end
  end

  describe '#step' do
    it 'advances to next generation' do
      game = GameOfLife.new(5, 5)
      game.step
      expect(game.generation).to eq(1)
    end
  end
end