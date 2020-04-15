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

fn rules(living: Int, cell: Cell) -> Event {
  case cell, living {
    _cell, 2 -> Live
    _cell, 3 -> Live
    cell, 0 | 1 -> Die 
    cell, 4 | 5 | 6 | 7 |8 -> Die
    _, _ -> Nothing
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