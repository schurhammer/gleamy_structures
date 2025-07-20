//// This module provides a simple implementation of a bidirectional map.
//// Each key can have a single value, and each value can have a single key.
//// The bimap is based on Gleam `dict.Dict`s, so ordering is not guaranteed.

import gleam/dict
import gleam/list

/// The `Bimap(a, b)` type represents a bi-directional map that associates
/// values of type `a` with values of type `b` and vice versa.
pub opaque type Bimap(a, b) {
  Bimap(from_key: dict.Dict(a, b), to_key: dict.Dict(b, a))
}

/// Creates a new empty bimap.
pub fn new() -> Bimap(a, b) {
  Bimap(dict.new(), dict.new())
}

/// Create a bimap from list entries.
pub fn from_list(members: List(#(a, b))) -> Bimap(a, b) {
  members
  |> list.fold(new(), fn(bimap, member) {
    let #(key, value) = member
    insert(bimap, key, value)
  })
}

/// Converts a bimap into a list of key-value pairs.
pub fn to_list(bimap: Bimap(a, b)) -> List(#(a, b)) {
  dict.to_list(bimap.from_key)
}

/// Insert a new key-value pair into the bimap. If either the key or value
/// already exists, the existing pair is removed before inserting the new one.
pub fn insert(bimap: Bimap(a, b), key: a, value: b) -> Bimap(a, b) {
  let cleaned =
    bimap
    |> delete_by_key(key)
    |> delete_by_value(value)

  Bimap(
    from_key: dict.insert(cleaned.from_key, key, value),
    to_key: dict.insert(cleaned.to_key, value, key),
  )
}

/// Get a value by its key, if present.
pub fn get_by_key(bimap: Bimap(a, b), key: a) -> Result(b, Nil) {
  dict.get(bimap.from_key, key)
}

/// Check if a key exists in the bimap.
pub fn has_key(bimap: Bimap(a, b), key: a) -> Bool {
  dict.has_key(bimap.from_key, key)
}

/// Get a key by its value, if present.
pub fn get_by_value(bimap: Bimap(a, b), value: b) -> Result(a, Nil) {
  dict.get(bimap.to_key, value)
}

/// Check if a value exists in the bimap.
pub fn has_value(bimap: Bimap(a, b), value: b) -> Bool {
  dict.has_key(bimap.to_key, value)
}

/// Delete a key-value pair from the bimap by key.
pub fn delete_by_key(bimap: Bimap(a, b), key: a) -> Bimap(a, b) {
  case dict.get(bimap.from_key, key) {
    Error(_) -> bimap
    Ok(value) -> {
      let from_key = dict.delete(bimap.from_key, key)
      let to_key = dict.delete(bimap.to_key, value)
      Bimap(from_key, to_key)
    }
  }
}

/// Delete a key-value pair from the bimap by value.
pub fn delete_by_value(bimap: Bimap(a, b), value: b) -> Bimap(a, b) {
  case dict.get(bimap.to_key, value) {
    Error(_) -> bimap
    Ok(key) -> {
      let from_key = dict.delete(bimap.from_key, key)
      let to_key = dict.delete(bimap.to_key, value)
      Bimap(from_key, to_key)
    }
  }
}

/// Get the count of key-value pairs in the bimap.
pub fn count(bimap: Bimap(a, b)) -> Int {
  dict.size(bimap.from_key)
}
