import gleam/list

pub type Cell {
  Alive
  Dead
}

pub type Event {
  Live
  Die
  Nothing
}

pub type AdjacentCells =
  List(Cell)

// The Game of Life rules:
// https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life#Rules

  // case cell, living {
  //   _cell, 2 -> Live
  //   _cell, 3 -> Live
  //   Alive, living if 2 > living -> Die
  //   Alive, living if living > 3 -> Die 
  //   _, _ -> Nothing
  // }
fn rules(living: Int, cell: Cell) -> Event {
  case cell, living {
    _cell, 2 -> Live
    _cell, 3 -> Live
    cell, living -> 
      case cell == Alive && 2 > living {
        True -> 
          Die

        False -> 
          case cell == Alive && living > 3 {
            True -> 
              Die 

            False -> 
              Nothing
          }
      }
  }
}

fn count(adjacent_cells: AdjacentCells) {
  adjacent_cells
  |> list.filter(_, for: fn(cell) { cell == Alive })
  |> list.fold(_, from: 0, with: fn(_x, y) { y + 1 })
}

fn transition(event: Event, cell: Cell) -> Cell {
  case event, cell {
    Live, _cell -> Alive
    Die, _cell -> Dead
    Nothing, cell -> cell
  }
}

pub fn apply(cells: AdjacentCells, cell: Cell) -> Cell {
  cells
  |> count(_)
  |> rules(_, cell)
  |> transition(_, cell)
} 