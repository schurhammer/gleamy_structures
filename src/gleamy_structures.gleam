import gleam/io
import gleam/int
import gleam/list
import impl/red_black_tree
import impl/binary_search_tree
import impl/pairing_heap
import impl/leftist_heap

type Dataset(a) {
  Dataset(label: String, data: a)
}

type Function(a) {
  Function(label: String, fun: fn(a) -> Nil)
}

type Result {
  Result(dataset: String, function: String, runtime: Int)
}

fn format_result(result: Result) {
  result.dataset <> " " <> result.function <> " " <> int.to_string(
    result.runtime,
  )
}

fn repeat(n, data, fun) {
  case n {
    0 -> Nil
    n -> {
      fun(data)
      repeat(n - 1, data, fun)
    }
  }
}

fn bench(n: Int, datasets: List(Dataset(a)), functions: List(Function(a))) {
  list.map(
    datasets,
    fn(dataset) {
      list.map(
        functions,
        fn(function) {
          // one warmup
          repeat(1, dataset.data, function.fun)
          let before = timestamp(1_000_000)
          repeat(n, dataset.data, function.fun)
          let after = timestamp(1_000_000)
          let d = after - before
          Result(dataset.label, function.label, d / n)
        },
      )
    },
  )
}

pub fn main() {
  let datasets = [
    Dataset("100 sorted", list.range(1, 100)),
    Dataset("100 reversed", list.reverse(list.range(1, 100))),
    Dataset("100 shuffled", list.shuffle(list.range(1, 100))),
    Dataset("10_000 sorted", list.range(1, 10_000)),
    Dataset("10_000 reversed", list.reverse(list.range(1, 10_000))),
    Dataset("10_000 shuffled", list.shuffle(list.range(1, 10_000))),
  ]

  let functions = [
    Function(
      "pairing_heap",
      fn(data) {
        let del_all = fn(heap, _) {
          assert Ok(#(_, h)) = pairing_heap.delete_min(heap)
          h
        }
        pairing_heap.new(int.compare)
        |> list.fold(data, _, pairing_heap.insert)
        |> list.fold(data, _, del_all)
        Nil
      },
    ),
    Function(
      "leftist_heap",
      fn(data) {
        let del_all = fn(heap, _) {
          assert Ok(#(_, h)) = leftist_heap.delete_min(heap)
          h
        }
        leftist_heap.new(int.compare)
        |> list.fold(data, _, leftist_heap.insert)
        |> list.fold(data, _, del_all)
        Nil
      },
    ),
  ]

  io.println("\nHeap Insert and Delete All\n===")
  bench(10, datasets, functions)
  |> list.map(list.map(_, format_result))
  |> list.map(list.map(_, io.println))

  let functions = [
    Function(
      "binary_search_tree",
      fn(data) {
        binary_search_tree.new(int.compare)
        |> list.fold(data, _, binary_search_tree.insert)
        |> list.fold(data, _, binary_search_tree.delete)
        Nil
      },
    ),
    Function(
      "red_black_tree",
      fn(data) {
        red_black_tree.new(int.compare)
        |> list.fold(data, _, red_black_tree.insert)
        |> list.fold(data, _, red_black_tree.delete)
        Nil
      },
    ),
  ]

  io.println("\nTree Insert and Delete All\n===")
  bench(1, datasets, functions)
  |> list.map(list.map(_, format_result))
  |> list.map(list.map(_, io.println))
}

if erlang {
  external fn timestamp(unit: Int) -> Int =
    "erlang" "monotonic_time"
}

if javascript {
  external fn timestamp(unit: Int) -> Int =
    "" "(x => globalThis.performance.now() * (x / 1000))"
}
