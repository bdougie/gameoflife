# Conway's Game of Life in Ruby

A simple implementation of Conway's Game of Life following TDD principles and the specifications in `spec.md`.

## Features

- **Toroidal Grid**: Edges wrap around (cells at boundaries consider cells on opposite edges as neighbors)
- **Conway's Rules**:
  - Live cells with < 2 neighbors die (underpopulation)
  - Live cells with 2-3 neighbors survive
  - Live cells with > 3 neighbors die (overpopulation)
  - Dead cells with exactly 3 neighbors become alive (reproduction)
- **Visual Display**: ASCII art representation with `█` for live cells

## Installation

```bash
bundle install
```

## Usage

### Run the simulation
```bash
# Run for 100 generations (default)
ruby game.rb

# Run for specific number of generations
ruby game.rb 50

# Run in interactive mode (press Enter for each generation)
ruby game.rb --interactive
ruby game.rb 25 -i
```

### Run tests
```bash
# Run all tests
bundle exec rspec

# Run with detailed output
bundle exec rspec --format documentation

# Run with coverage
bundle exec rake coverage
```

## Implementation

The implementation consists of three main classes:

- **Grid**: Manages the 2D grid, cell states, and neighbor counting with toroidal wrapping
- **GameOfLife**: Applies Conway's rules and manages game state transitions
- **GameRunner**: Handles display, simulation control, and user interaction

## Initial Pattern

The simulation starts with a "glider" pattern - a well-known Conway pattern that moves diagonally across the grid every 4 generations.

## Testing

The implementation follows TDD (Test-Driven Development) principles with comprehensive RSpec tests covering:
- Grid initialization and cell management
- Neighbor counting with toroidal boundaries
- All Conway's Game of Life rules
- Edge cases and boundary conditions

All tests verify the core requirements specified in `spec.md`.
