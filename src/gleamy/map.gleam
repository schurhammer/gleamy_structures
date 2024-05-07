//// This module provides an implementation of an ordered map data structure based on
//// red-black trees. It associates keys of type `k` with values of type `v`.
//// Keys are ordered by the comparison function.

import gleam/list
import gleam/order.{type Order}
import gleamy/red_black_tree_map as tree

/// The `Map(k, v)` type represents a map that associates keys of type `k`
/// with values of type `v`.
pub type Map(k, v) =
  tree.Map(k, v)

/// Creates a new empty map with the provided comparison function for keys.
pub fn new(compare: fn(k, k) -> Order) -> Map(k, v) {
  tree.new(compare)
}

/// Inserts a new key-value pair into the map, overwriting the value if the key
/// already exists.
pub fn insert(into map: Map(k, v), key key: k, value value: v) -> Map(k, v) {
  tree.insert(map, key, value)
}

/// Get the value associated with a given key in the map, if present.
pub fn get(in map: Map(k, v), key key: k) -> Result(v, Nil) {
  tree.find(map, key)
}

/// Checks if the map contains a given key.
pub fn has_key(in map: Map(k, v), key key: k) -> Bool {
  case tree.find(map, key) {
    Ok(_) -> True
    Error(_) -> False
  }
}

/// Removes a key-value pair from the map, if the key exists.
pub fn delete(from map: Map(k, v), this key: k) -> Map(k, v) {
  tree.delete(map, key)
}

/// Returns the number of key-value pairs in the map.
/// Time complexity: O(n)
pub fn count(map: Map(k, v)) -> Int {
  tree.fold(map, 0, fn(a, _, _) { a + 1 })
}

/// Applies a function to every key-value pair in the map, accumulating
/// the results with the provided initial accumulator value.
pub fn fold(
  over map: Map(k, v),
  from initial: a,
  with reducer: fn(a, k, v) -> a,
) -> a {
  tree.fold(map, initial, reducer)
}

/// Creates a new map containing only the key-value pairs from the original map
/// that satisfy a given predicate function.
pub fn filter(in map: Map(k, v), for property: fn(k, v) -> Bool) -> Map(k, v) {
  tree.fold(map, map, fn(map, k, v) {
    case property(k, v) {
      True -> map
      False -> tree.delete(map, k)
    }
  })
}

/// Merges two maps into a new map, keeping values from the second map
/// if keys collide.
pub fn merge(intro dict: Map(k, v), from new_entries: Map(k, v)) -> Map(k, v) {
  tree.fold(new_entries, dict, fn(a, k, v) { tree.insert(a, k, v) })
}

/// Creates a new map containing only the key-value pairs from the original map
/// where the keys are present in the given list of desired keys.
pub fn take(from map: Map(k, v), keeping desired: List(k)) -> Map(k, v) {
  case desired {
    [x, ..xs] ->
      case tree.find(map, x) {
        Ok(v) -> tree.insert(take(map, xs), x, v)
        Error(_) -> take(map, xs)
      }
    [] -> tree.clear(map)
  }
}

/// Creates a new map from a list of key-value pairs and a comparison function
/// for keys.
pub fn from_list(
  members: List(#(k, v)),
  compare: fn(k, k) -> Order,
) -> Map(k, v) {
  list.fold(members, tree.new(compare), fn(tree, i) {
    tree.insert(tree, i.0, i.1)
  })
}

/// Converts the map to a list of key-value pairs.
pub fn to_list(map: Map(k, v)) -> List(#(k, v)) {
  tree.foldr(map, [], fn(a, k, v) { [#(k, v), ..a] })
}
