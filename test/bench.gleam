import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleamy/bench
import gleamy/map

pub fn main() {
  bench.run(
    [
      bench.Input("n=3", int.range(from: 3, to: 0, with: [], run: list.prepend)),
      bench.Input(
        "n=1000",
        int.range(from: 1000, to: 0, with: [], run: list.prepend),
      ),
    ],
    [
      bench.Function("map", fn(data) {
        list.fold(data, map.new(int.compare), fn(m, i) { map.insert(m, i, i) })
        Nil
      }),
      bench.Function("dict", fn(data) {
        list.fold(data, dict.new(), fn(m, i) { dict.insert(m, i, i) })
        Nil
      }),
    ],
    [bench.Duration(3000)],
  )
  |> bench.table([bench.IPS, bench.Min, bench.P(50), bench.Max])
  |> io.println
}
