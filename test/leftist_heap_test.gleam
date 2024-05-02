import gleam/int
import gleamy/pairing_heap as heap
import gleeunit/should

pub fn find_test() {
  let heap = heap.new(int.compare)

  heap.find_min(heap)
  |> should.equal(Error(Nil))

  let heap = heap.insert(heap, 3)

  heap.find_min(heap)
  |> should.equal(Ok(3))

  let heap = heap.insert(heap, 1)

  heap.find_min(heap)
  |> should.equal(Ok(1))

  let heap = heap.insert(heap, 4)

  heap.find_min(heap)
  |> should.equal(Ok(1))
}

pub fn delete_test() {
  let heap =
    heap.new(int.compare)
    |> heap.insert(3)
    |> heap.insert(1)
    |> heap.insert(4)
    |> heap.insert(1)
    |> heap.insert(5)

  let assert Ok(#(x, heap)) = heap.delete_min(heap)
  should.equal(x, 1)

  let assert Ok(#(x, heap)) = heap.delete_min(heap)
  should.equal(x, 1)

  let assert Ok(#(x, heap)) = heap.delete_min(heap)
  should.equal(x, 3)

  let assert Ok(#(x, heap)) = heap.delete_min(heap)
  should.equal(x, 4)

  let assert Ok(#(x, heap)) = heap.delete_min(heap)
  should.equal(x, 5)

  heap.delete_min(heap)
  |> should.equal(Error(Nil))
}
