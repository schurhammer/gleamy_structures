//// This module provides an implementation of the pairing heap data structure,
//// a type of self-adjusting heap with efficient insert, find_min, and delete_min, and merge operations.

// Based on "Purely Functional Data Structures" by Okasaki (1998)

import gleam/order.{type Order, Gt}

type Tree(a) {
  Empty
  Tree(a, List(Tree(a)))
}

pub opaque type Heap(a) {
  Heap(root: Tree(a), compare: fn(a, a) -> Order)
}

/// Creates a new empty heap with the provided comparison function.
pub fn new(compare: fn(a, a) -> Order) -> Heap(a) {
  Heap(Empty, compare)
}

/// Inserts a new item into the heap, preserving the heap property.
/// Time complexity: O(1)
pub fn insert(heap: Heap(a), key: a) -> Heap(a) {
  Heap(merge_trees(Tree(key, []), heap.root, heap.compare), heap.compare)
}

/// Returns the minimum element in the heap, if the heap is not empty.
/// Time complexity: O(1)
pub fn find_min(heap: Heap(a)) -> Result(a, Nil) {
  case heap.root {
    Tree(x, _) -> Ok(x)
    Empty -> Error(Nil)
  }
}

/// Removes and returns the minimum element from the heap along with the
/// new heap after deletion, if the heap is not empty.
/// Time complexity: O(log n) amortized
pub fn delete_min(heap: Heap(a)) -> Result(#(a, Heap(a)), Nil) {
  case heap.root {
    Tree(x, xs) -> Ok(#(x, Heap(merge_pairs(xs, heap.compare), heap.compare)))
    Empty -> Error(Nil)
  }
}

/// Merges two heaps into a new heap containing all elements from both heaps,
/// preserving the heap property.
/// The given heaps must have the same comparison function.
/// Time complexity: O(1)
pub fn merge(heap1: Heap(a), heap2: Heap(a)) -> Heap(a) {
  let compare = heap1.compare
  Heap(merge_trees(heap1.root, heap2.root, compare), compare)
}

fn merge_trees(x: Tree(a), y: Tree(a), compare: fn(a, a) -> Order) -> Tree(a) {
  case x, y {
    x, Empty -> x
    Empty, y -> y
    Tree(xk, xs), Tree(yk, ys) ->
      case compare(xk, yk) {
        Gt -> Tree(yk, [x, ..ys])
        _ -> Tree(xk, [y, ..xs])
      }
  }
}

fn merge_pairs(l: List(Tree(a)), compare: fn(a, a) -> Order) -> Tree(a) {
  case l {
    [] -> Empty
    [h] -> h
    [h1, h2, ..hs] ->
      merge_trees(
        merge_trees(h1, h2, compare),
        merge_pairs(hs, compare),
        compare,
      )
  }
}
