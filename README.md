# Conway's Game of Life - Ruby Implementation

A Test-Driven Development (TDD) implementation of Conway's Game of Life in Ruby.

## Features

- **Toroidal Grid**: Grid boundaries wrap around (cells at edges see cells on opposite edges as neighbors)
- **Conway's Rules**: Classic Game of Life rules for cell evolution
- **Pattern Support**: Includes classic patterns like Block, Blinker, Glider, etc.
- **Visual Display**: Simple ASCII representation of the grid
- **Comprehensive Tests**: Full test coverage using TDD methodology

## Game Rules

| Current State | Live Neighbors | New State | Rule |
|---------------|----------------|-----------|------|
| Alive         | < 2            | Dead      | Underpopulation |
| Alive         | 2-3            | Alive     | Survival |
| Alive         | > 3            | Dead      | Overpopulation |
| Dead          | == 3           | Alive     | Reproduction |

## Usage

### Basic Usage

```ruby
require_relative 'lib/game_of_life'

# Create a 10x10 grid
game = GameOfLife.new(10, 10)

# Set some cells manually
game.grid.set_cell(1, 1, 1)
game.grid.set_cell(1, 2, 1)
game.grid.set_cell(1, 3, 1)

# Evolve one generation
game.evolve!

# Display the grid
game.display
```

### Using Patterns

```ruby
require_relative 'lib/game_of_life'
require_relative 'lib/patterns'

game = GameOfLife.new(5, 5)
game.load_pattern(Patterns::BLINKER)
game.run(10, 1)  # Run for 10 generations with 1 second delay
```

### Demo Script

```bash
ruby demo.rb blinker   # Show blinker oscillator
ruby demo.rb glider    # Show glider moving across grid
ruby demo.rb block     # Show stable block pattern
```

## Project Structure

```
├── lib/
│   ├── grid.rb           # Core grid implementation
│   ├── game_of_life.rb   # Main game orchestrator
│   └── patterns.rb       # Classic Game of Life patterns
├── test/
│   ├── grid_test.rb           # Grid functionality tests
│   ├── game_evolution_test.rb # Conway's rules tests
│   ├── patterns_test.rb       # Pattern behavior tests
│   └── game_of_life_test.rb   # Game orchestrator tests
├── demo.rb               # Interactive demo script
├── test_runner.rb        # Run all tests
└── README.md
```

## Running Tests

```bash
# Run all tests
ruby test_runner.rb

# Run specific test files
ruby test/grid_test.rb
ruby test/game_evolution_test.rb
ruby test/patterns_test.rb
ruby test/game_of_life_test.rb
```

## Key Classes

### Grid
- Manages the 2D cellular automaton grid
- Handles toroidal boundary wrapping
- Implements neighbor counting and Conway's rules
- Provides visualization methods

### GameOfLife
- Orchestrates the simulation
- Tracks generation count
- Provides convenience methods for running simulations

### Patterns
- Contains classic Game of Life patterns
- Includes still lifes, oscillators, and spaceships

## Development Approach

This implementation was built using Test-Driven Development (TDD):

1. **Red**: Write failing tests first
2. **Green**: Write minimal code to make tests pass
3. **Refactor**: Clean up code while keeping tests green

The test suite provides comprehensive coverage of:
- Grid initialization and cell manipulation
- Neighbor counting with toroidal wrapping
- Conway's rule implementation
- Pattern behavior verification
- Game simulation functionality

## Examples

### Blinker (Period 2 Oscillator)
```
Generation 0:    Generation 1:    Generation 2:
· · ·            · · ·            · · ·
· █ ·     ->     █ █ █     ->     · █ ·
· · ·            · · ·            · · ·
```

### Block (Still Life)
```
Generation 0:    Generation 1:
█ █              █ █
█ █       ->     █ █
```

### Glider (Spaceship)
```
Generation 0:    Generation 4:
· █ ·            · · · ·
· · █            · · █ ·
█ █ █     ->     · █ █ █
                 · · · ·
```

## Testing Philosophy

Following Ruby best practices:
- Each method has a single responsibility
- Tests are independent and repeatable
- Mock external dependencies (none in this case)
- Descriptive test names explain expected behavior
- Test edge cases (boundaries, empty grids, etc.)