//// This module provides an implementation of a priority queue data structure
//// based on the pairing heap. It allows efficient insertion, removal, and access
//// to the minimum element in the queue.

import gleam/list
import gleam/order.{type Order}
import gleamy/pairing_heap as heap

/// The `Queue(a)` type represents a priority queue of elements of type `a`.
pub type Queue(a) =
  heap.Heap(a)

/// Creates a new empty priority queue with the provided comparison function.
pub fn new(compare: fn(a, a) -> Order) -> Queue(a) {
  heap.new(compare)
}

/// Removes and returns the minimum element from the priority queue,
/// along with the new queue.
pub fn pop(from queue: Queue(a)) -> Result(#(a, Queue(a)), Nil) {
  heap.delete_min(queue)
}

/// Returns the minimum element in the priority queue without removing it.
pub fn peek(from queue: Queue(a)) -> Result(a, Nil) {
  heap.find_min(queue)
}

/// Inserts a new element into the priority queue.
pub fn push(onto queue: Queue(a), this item: a) -> Queue(a) {
  heap.insert(queue, item)
}

/// Checks whether the priority queue is empty or not.
pub fn is_empty(queue: Queue(a)) -> Bool {
  case heap.find_min(queue) {
    Ok(_) -> False
    Error(_) -> True
  }
}

// TODO implement count in pairing heap for better run time
/// Returns the number of elements in the priority queue.
pub fn count(queue: Queue(a)) -> Int {
  case heap.delete_min(queue) {
    Ok(#(_, q)) -> count(q) + 1
    Error(_) -> 0
  }
}

/// Rebuilds the priority queue with a new comparison function.
pub fn reorder(queue: Queue(a), compare: fn(a, a) -> Order) -> Queue(a) {
  case heap.delete_min(queue) {
    Ok(#(x, q)) -> heap.insert(reorder(q, compare), x)
    Error(_) -> heap.new(compare)
  }
}

/// Creates a new priority queue from a list of elements and a comparison function.
pub fn from_list(list: List(a), compare: fn(a, a) -> Order) -> Queue(a) {
  list.fold(list, new(compare), heap.insert)
}

/// Converts the priority queue to a list, preserving the order of elements.
pub fn to_list(queue: Queue(a)) -> List(a) {
  case heap.delete_min(queue) {
    Ok(#(x, q)) -> [x, ..to_list(q)]
    Error(_) -> []
  }
}
