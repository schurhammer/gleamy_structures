//// This module provides an implementation of an ordered set data structure
//// based on red-black trees.
//// A set is a collection of unique values, ordered by the comparison function.

import gleam/list
import gleam/order.{type Order}
import gleamy/red_black_tree_set as tree

/// The `Set(a)` type represents a set of elements of type `a`. 
pub type Set(a) =
  tree.Set(a)

/// Creates a new empty set with the provided comparison function.
pub fn new(compare: fn(a, a) -> Order) -> Set(a) {
  tree.new(compare)
}

/// Inserts a new element into the set, if it is not already present.
pub fn insert(into set: Set(a), this member: a) -> Set(a) {
  tree.insert(set, member)
}

/// Checks if the set contains a given element.
pub fn contains(in set: Set(a), this member: a) -> Bool {
  case tree.find(set, member) {
    Ok(_) -> True
    Error(_) -> False
  }
}

/// Removes an element from the set, if it exists.
pub fn delete(from set: Set(a), this member: a) -> Set(a) {
  tree.delete(set, member)
}

/// Creates a new set containing only the elements from the original set
/// that satisfy a given predicate function.
pub fn filter(in set: Set(a), for property: fn(a) -> Bool) -> Set(a) {
  tree.fold(set, set, fn(set, i) {
    case property(i) {
      True -> set
      False -> tree.delete(set, i)
    }
  })
}

/// Applies a function to every element in the set, accumulating
/// the results with the provided initial accumulator value.
pub fn fold(over set: Set(a), from initial: b, with reducer: fn(b, a) -> b) -> b {
  tree.fold(set, initial, reducer)
}

/// Creates a new set containing the intersection (common elements) of two sets.
pub fn intersection(of first: Set(a), and second: Set(a)) -> Set(a) {
  tree.fold(second, tree.clear(first), fn(a, i) {
    case tree.find(first, i) {
      Ok(_) -> tree.insert(a, i)
      Error(_) -> a
    }
  })
}

/// Creates a new set containing the union (all elements) of two sets.
pub fn union(of first: Set(a), and second: Set(a)) -> Set(a) {
  tree.fold(first, second, fn(a, i) { tree.insert(a, i) })
}

/// Creates a new set containing the elements of the first set except for elements
/// that are also in the second set.
pub fn difference(from set: Set(a), remove removal: Set(a)) -> Set(a) {
  tree.fold(removal, set, fn(set, i) { tree.delete(set, i) })
}

/// Returns the number of elements in the set.
/// Time complexity: O(n)
pub fn count(set: Set(a)) -> Int {
  tree.fold(set, 0, fn(a, _) { a + 1 })
}

/// Creates a new set from a list of elements and a comparison function.
pub fn from_list(members: List(a), compare: fn(a, a) -> Order) -> Set(a) {
  list.fold(members, tree.new(compare), tree.insert)
}

/// Converts the set to a list of its elements.
pub fn to_list(set: Set(a)) -> List(a) {
  tree.foldr(set, [], fn(a, i) { [i, ..a] })
}
