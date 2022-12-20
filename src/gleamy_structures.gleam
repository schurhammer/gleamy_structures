import gleam/io
import gleam/int
import gleam/list
import red_black_tree as tree

pub fn main() {
  let add_items =
    list.range(1, 1_000_000)
    |> list.shuffle()
  let remove_items =
    list.range(1, 1_000_000)
    |> list.shuffle()

  let before = timestamp(1000)

  tree.new(int.compare)
  |> list.fold(add_items, _, tree.insert)
  |> list.fold(remove_items, _, tree.delete)

  let after = timestamp(1000)

  io.debug(after - before)
}

external fn timestamp(unit: Int) -> Int =
  "erlang" "monotonic_time"
