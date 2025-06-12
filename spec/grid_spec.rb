require_relative '../grid'

RSpec.describe Grid do
  describe '#initialize' do
    it 'creates a grid with specified dimensions' do
      grid = Grid.new(5, 5)
      expect(grid.rows).to eq(5)
      expect(grid.cols).to eq(5)
      expect(grid.cells.size).to eq(5)
      expect(grid.cells[0].size).to eq(5)
    end

    it 'initializes all cells as dead (0)' do
      grid = Grid.new(3, 3)
      grid.cells.each do |row|
        row.each do |cell|
          expect(cell).to eq(0)
        end
      end
    end
  end

  describe '#set_cell' do
    it 'sets a cell to alive (1)' do
      grid = Grid.new(3, 3)
      grid.set_cell(1, 1, 1)
      expect(grid.cells[1][1]).to eq(1)
    end

    it 'sets a cell to dead (0)' do
      grid = Grid.new(3, 3)
      grid.set_cell(1, 1, 1)
      grid.set_cell(1, 1, 0)
      expect(grid.cells[1][1]).to eq(0)
    end
  end

  describe '#get_cell' do
    it 'returns the state of a cell' do
      grid = Grid.new(3, 3)
      grid.set_cell(1, 1, 1)
      expect(grid.get_cell(1, 1)).to eq(1)
      expect(grid.get_cell(0, 0)).to eq(0)
    end
  end

  describe '#count_neighbors' do
    it 'counts live neighbors around a cell' do
      grid = Grid.new(3, 3)
      # Set up a pattern: center cell with 3 neighbors
      grid.set_cell(0, 1, 1) # top
      grid.set_cell(1, 0, 1) # left
      grid.set_cell(1, 2, 1) # right
      
      expect(grid.count_neighbors(1, 1)).to eq(3)
    end

    it 'wraps around grid boundaries (toroidal)' do
      grid = Grid.new(3, 3)
      # Set corner and edge cells to test wrapping
      grid.set_cell(0, 0, 1) # top-left corner
      grid.set_cell(2, 2, 1) # bottom-right corner
      
      # Top-left cell should see bottom-right as neighbor
      expect(grid.count_neighbors(0, 0)).to eq(1)
    end

    it 'handles edge wrapping correctly' do
      grid = Grid.new(3, 3)
      # Set cells to test all edges
      grid.set_cell(0, 1, 1) # top edge
      grid.set_cell(2, 1, 1) # bottom edge
      
      # Top edge cell should see bottom edge as neighbor
      expect(grid.count_neighbors(0, 1)).to eq(1)
    end
  end
end