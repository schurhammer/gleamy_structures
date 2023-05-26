import gleeunit/should
import gleam/int
import gleam/order
import gleamy/structures/priority_queue as queue

pub fn from_list_test() {
  let queue = queue.from_list([3, 1, 4, 1, 5], int.compare)
  let result = queue.to_list(queue)
  result
  |> should.equal([1, 1, 3, 4, 5])
}

pub fn is_empty_test() {
  let empty_queue = queue.new(int.compare)
  let non_empty_queue = queue.from_list([1, 2, 3], int.compare)

  empty_queue
  |> queue.is_empty()
  |> should.equal(True)

  non_empty_queue
  |> queue.is_empty()
  |> should.equal(False)
}

pub fn count_test() {
  let empty_queue = queue.new(int.compare)
  let queue = queue.from_list([3, 1, 4, 1, 5], int.compare)

  empty_queue
  |> queue.count()
  |> should.equal(0)

  queue
  |> queue.count()
  |> should.equal(5)
}

pub fn pop_test() {
  let queue = queue.from_list([3, 1, 4, 1, 5], int.compare)
  let result =
    queue
    |> queue.pop()

  result
  |> should.equal(Ok(#(1, queue.from_list([3, 1, 4, 5], int.compare))))
}

pub fn peek_test() {
  let queue = queue.from_list([3, 1, 4, 1, 5], int.compare)
  let result =
    queue
    |> queue.peek()

  result
  |> should.equal(Ok(1))
}

pub fn push_test() {
  let empty_queue = queue.new(int.compare)
  let queue =
    empty_queue
    |> queue.push(3)
    |> queue.push(1)
    |> queue.push(4)
    |> queue.push(1)
    |> queue.push(5)
  let result = queue.to_list(queue)

  result
  |> should.equal([1, 1, 3, 4, 5])
}

pub fn reorder_test() {
  let queue = queue.from_list([3, 1, 4, 1, 5], int.compare)

  queue.to_list(queue)
  |> should.equal([1, 1, 3, 4, 5])

  let reverse_queue =
    queue.reorder(queue, fn(a, b) { order.reverse(int.compare(a, b)) })

  queue.to_list(reverse_queue)
  |> should.equal([5, 4, 3, 1, 1])
}

pub fn to_list_test() {
  let queue = queue.from_list([3, 1, 4, 1, 5], int.compare)
  let result = queue.to_list(queue)

  result
  |> should.equal([1, 1, 3, 4, 5])
}
