Here's a minimal viable specification for implementing Conway's Game of Life in Ruby.

**Key Requirements:**

1. **Grid Implementation**
   - Toroidal (wrapping) grid boundaries
   - Cell states: `0` (dead) or `1` (alive)
   - Simultaneous updates for each generation

2. **Neighbor Counting**
   ```ruby
   # Each cell has 8 neighbors:
   # [x-1,y-1] [x,y-1] [x+1,y-1]
   # [x-1,y]     cell    [x+1,y]
   # [x-1,y+1] [x,y+1] [x+1,y+1]
   ```

3. **Update Rules**
   | Current State | Live Neighbors | New State |
   |---------------|----------------|-----------|
   | Alive         | < 2            | Dead      |
   | Alive         | 2-3            | Alive     |
   | Alive         | > 3            | Dead      |
   | Dead          | == 3           | Alive     |

4. **Implementation Suggestions**
   - Use a `Grid` class with 2D array storage
   - Separate state calculation from rendering
   - Optimize for finite grid sizes (e.g. 20x20)

This spec focuses on the core Conway rules while allowing flexibility in implementation details like rendering and grid initialization. The test cases verify:
- Underpopulation (lonely cell dies)
- Stable structures (block remains unchanged)
- Reproduction (dead cell with exactly 3 neighbors comes alive)

Sources
[1] Conway's Game of Life - The Minimum Viable Model https://the-mvm.github.io/conways-game-of-life.html
[2] andersondias/conway-game-of-life-ruby - GitHub https://github.com/andersondias/conway-game-of-life-ruby
[3] Code Golf: Conway's Game of Life - Stack Overflow https://stackoverflow.com/questions/3499538/code-golf-conways-game-of-life
[4] GitHub - BillMux/game-of-life-ruby: Conway's Game of Life in Ruby https://github.com/BillMux/game-of-life-ruby
[5] conways game of life in ruby https://stackoverflow.com/questions/30474131/conways-game-of-life-in-ruby
[6] GitHub - kp2222/game-of-life: A simple implementation of Game of life in Ruby https://github.com/kp2222/game-of-life
[7] The Game of Life System Requirements - Can I Run It? - PCGameBenchmark https://www.pcgamebenchmark.com/the-game-of-life-system-requirements
[8] Conway's Game of Life without return values - Jake Goulding http://jakegoulding.com/blog/2012/12/13/conways-game-of-life-without-return-values
[9] Coding Conway's Game of Life in Ruby the TDD Way with RSpec http://www.rubyinside.com/screencast-coding-conways-game-of-life-in-ruby-the-tdd-way-with-rspec-5564.html
[10] Writing a Ruby Gem Specification - Piotr Murach https://piotrmurach.com/articles/writing-a-ruby-gem-specification/

