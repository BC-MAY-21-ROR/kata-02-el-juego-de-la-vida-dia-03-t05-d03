class Game
    attr_accessor :rows, :cols, :grid
    def initialize(rows, cols)
        @rows = rows
        @cols = cols
    end
    def grid 
        @grid = Grid.new(@rows,@cols)
    end
   
end



class Grid 
    attr_accessor :rows, :cols, :cells_amount, :cells, :print_generation
    def initialize(rows, cols)
        @rows, @cols = rows,cols
        @cells = []
        self.fill_grid
    end

    def cells
        @cells
    end
    def cells_amount
        rows*cols
    end
    def print_generation(cells)
        print "\n"
        cells.each do |cell|
            pos_x = cell.pos_x
            pos_y = cell.pos_y
            char = cell.char
            print char +  "\t"
            if pos_y == cols - 1
                print "\n"
            end
        end
    end
    def fill_grid
        (0..rows-1).each do |row|
            (0..cols-1).each do |col|
                cell = Cell.new(row, col)
                cells << cell
            end
        end
    end
end

class Generation 
    
    def initialize(cells)
        @cells = cells
        @transform_cells = @cells
    end
    def first_generation
        @cells
    end

    def next_generation
            @transform_cells.each do | cell |
               alives =  self.live_neighbours_around_cell(cell).count
               cell.alives_n = alives
               if cell.alive?
                    #condition 1 : 
                    if  alives < 2
                        cell.die!
                    #condition 2 : 
                    elsif [2, 3].include?(alives)
                        cell.revive!
                    #condition 3 : 
                    elsif alives > 3
                        cell.die!
                    else
                        cell.die!
                    end
                elsif cell.dead? && alives == 3
                    cell.revive!
                end
            end
            @transform_cells
    end
    def live_cells
        @cells.select { |cell| cell.alive? }
    end
    def dead_cells
        @cells.select { |cell| cell.alive == false }
    end
    def live_neighbours_around_cell(cell)
        live_neighbours = []
        live_cells.each do |live_cell|
          # Neighbour to the North
          if live_cell.pos_x == cell.pos_x - 1 && live_cell.pos_y == cell.pos_y
             live_neighbours << live_cell
          end
          # Neighbour to the North-East
          if live_cell.pos_x == cell.pos_x - 1 && live_cell.pos_y == cell.pos_y + 1
             live_neighbours << live_cell
          end
          # Neighbour to the East
           if live_cell.pos_x == cell.pos_x && live_cell.pos_y == cell.pos_y + 1
            live_neighbours << live_cell
           end
          # Neighbour to the South-East
          if live_cell.pos_x == cell.pos_x + 1 && live_cell.pos_y == cell.pos_y + 1
            live_neighbours << live_cell
          end          
          # Neighbour to the South
          if live_cell.pos_x == cell.pos_x + 1 && live_cell.pos_y == cell.pos_y
            live_neighbours << live_cell
          end
          # Neighbour to the South-West
          if live_cell.pos_x == cell.pos_x + 1 && live_cell.pos_y == cell.pos_y - 1
            live_neighbours << live_cell
          end          
          # Neighbour to the West
         if live_cell.pos_x == cell.pos_x && live_cell.pos_y == cell.pos_y - 1
            live_neighbours << live_cell
          end
          # Neighbour to the North-West
          if live_cell.pos_x == cell.pos_x - 1 && live_cell.pos_y == cell.pos_y - 1
            live_neighbours << live_cell
          end
        end
          return live_neighbours
      end
end

class Cell 
    attr_accessor :pos_x, :pos_y, :alive, :die, :revive, :dead, :alives_n
    def initialize(pos_x , pos_y, alive: false)
        @pos_x = pos_x
        @pos_y = pos_y
        @alive = self.random_life
        @alives_n = 0
    end
    def alives_n
        @alives_n
    end
    def random_life
        [true, false].sample
    end
    def alive?
        alive
    end
    def char
        self.alive? ? '*' : '.'
    end
    def dead?
        !alive
    end
    def die!
        @alive = false
    end
    def revive!
        @alive = true
    end
   
end