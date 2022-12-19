import gleam/io
import gleam/int
import gleam/list
import binary_search_tree as tree

pub fn main() {
  list.range(1, 100)
  |> list.shuffle()
  |> list.fold(tree.new(int.compare), tree.insert)
  |> tree.draw(int.to_string)
  |> io.println()
}
