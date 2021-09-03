require 'rspec'
require_relative './iteration-3'

describe Game do 
    describe '#create_grid' do 
        it 'Create a grid for a game with rows and columns dimensions' do 
            rows = 3
            cols = 3
            game = Game.new(rows,cols)
            totals_cells_expected = rows * cols
            expect(game.grid.cells_amount).to eq totals_cells_expected
        end
    end
    describe '#print_grid_cells' do 
        it 'Create a grid with random life values and get a cells list' do 
            rows = 3
            cols = 3
            game = Game.new(rows,cols)
            totals_cells_expected = rows * cols
            grid = game.grid
            cells = grid.cells
            expect(cells).to be_a_kind_of(Array)
        end
    end
    describe '#print_grid_cells' do 
        it 'Create a grid with random life values and get a cells list with Cell type' do 
            rows = 3
            cols = 3
            game = Game.new(rows,cols)
            totals_cells_expected = rows * cols
            grid = game.grid
            cells = grid.cells
            expect(cells).to all( be_an_instance_of(Cell) )
        end
    end
    describe '#print_grid_cells_first_and_next_generation' do 
        it 'Create a grid with random life values and get a cells list with Cell type' do 
            rows = 3
            cols = 3
            game = Game.new(rows,cols)
            totals_cells_expected = rows * cols
            grid = game.grid
            cells = grid.cells
            g = Generation.new(cells)
            first_g = g.first_generation
            grid.print_generation(first_g)
            puts "----"
            next_g = g.next_generation
            grid.print_generation(next_g)

            expect(first_g).to eq next_g
        end
    end
end

