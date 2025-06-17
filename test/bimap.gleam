import gleam/list
import gleam/result
import gleamy/bimap
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

// Test creating a new empty bimap
pub fn new_bimap_test() {
  let bm = bimap.new()

  // Should not find any keys or values in empty bimap
  let assert Error(Nil) = bimap.get_by_key(bm, "key")
  let assert Error(Nil) = bimap.get_by_value(bm, "value")
}

// Test basic insertion and retrieval
pub fn insert_and_get_test() {
  let bm =
    bimap.new()
    |> bimap.insert("hello", "world")
    |> bimap.insert("foo", "bar")

  // Test getting by key
  let assert Ok("world") = bimap.get_by_key(bm, "hello")
  let assert Ok("bar") = bimap.get_by_key(bm, "foo")

  // Test getting by value
  let assert Ok("hello") = bimap.get_by_value(bm, "world")
  let assert Ok("foo") = bimap.get_by_value(bm, "bar")
}

// Test getting non-existent keys and values
pub fn get_non_existent_test() {
  let bm =
    bimap.new()
    |> bimap.insert("key", "value")

  let assert Error(Nil) = bimap.get_by_key(bm, "nonexistent")
  let assert Error(Nil) = bimap.get_by_value(bm, "nonexistent")
}

// Test inserting when key already exists
pub fn insert_existing_key_test() {
  let bm =
    bimap.new()
    |> bimap.insert("key", "value1")
    |> bimap.insert("key", "value2")

  // Key should now map to new value
  let assert Ok("value2") = bimap.get_by_key(bm, "key")
  let assert Ok("key") = bimap.get_by_value(bm, "value2")

  // Old value should no longer exist
  let assert Error(Nil) = bimap.get_by_value(bm, "value1")
}

// Test inserting when value already exists
pub fn insert_existing_value_test() {
  let bm =
    bimap.new()
    |> bimap.insert("key1", "value")
    |> bimap.insert("key2", "value")

  // Value should now map to new key
  let assert Ok("key2") = bimap.get_by_value(bm, "value")
  let assert Ok("value") = bimap.get_by_key(bm, "key2")

  // Old key should no longer exist
  let assert Error(Nil) = bimap.get_by_key(bm, "key1")
}

// Test inserting when both key and value already exist
pub fn insert_existing_key_and_value_test() {
  let bm =
    bimap.new()
    |> bimap.insert("key1", "value1")
    |> bimap.insert("key2", "value2")
    |> bimap.insert("key1", "value2")
  // Both key1 and value2 exist

  // Should have key1 -> value2 mapping
  let assert Ok("value2") = bimap.get_by_key(bm, "key1")
  let assert Ok("key1") = bimap.get_by_value(bm, "value2")

  // Old mappings should be gone
  let assert Error(Nil) = bimap.get_by_value(bm, "value1")
  let assert Error(Nil) = bimap.get_by_key(bm, "key2")
}

// Test deleting by key
pub fn delete_by_key_test() {
  let bm =
    bimap.new()
    |> bimap.insert("key1", "value1")
    |> bimap.insert("key2", "value2")
    |> bimap.delete_by_key("key1")

  // Deleted key should not exist
  let assert Error(Nil) = bimap.get_by_key(bm, "key1")
  let assert Error(Nil) = bimap.get_by_value(bm, "value1")

  // Other mapping should still exist
  let assert Ok("value2") = bimap.get_by_key(bm, "key2")
  let assert Ok("key2") = bimap.get_by_value(bm, "value2")
}

// Test deleting by value
pub fn delete_by_value_test() {
  let bm =
    bimap.new()
    |> bimap.insert("key1", "value1")
    |> bimap.insert("key2", "value2")
    |> bimap.delete_by_value("value1")

  // Deleted value should not exist
  let assert Error(Nil) = bimap.get_by_key(bm, "key1")
  let assert Error(Nil) = bimap.get_by_value(bm, "value1")

  // Other mapping should still exist
  let assert Ok("value2") = bimap.get_by_key(bm, "key2")
  let assert Ok("key2") = bimap.get_by_value(bm, "value2")
}

// Test deleting non-existent key
pub fn delete_non_existent_key_test() {
  let bm =
    bimap.new()
    |> bimap.insert("key", "value")

  let bm_after = bimap.delete_by_key(bm, "nonexistent")

  // Should have no effect
  let assert Ok("value") = bimap.get_by_key(bm_after, "key")
  let assert Ok("key") = bimap.get_by_value(bm_after, "value")
}

// Test deleting non-existent value
pub fn delete_non_existent_value_test() {
  let bm =
    bimap.new()
    |> bimap.insert("key", "value")

  let bm_after = bimap.delete_by_value(bm, "nonexistent")

  // Should have no effect
  let assert Ok("value") = bimap.get_by_key(bm_after, "key")
  let assert Ok("key") = bimap.get_by_value(bm_after, "value")
}

// Test complex sequence of operations
pub fn complex_operations_test() {
  let bm =
    bimap.new()
    |> bimap.insert("a", "1")
    |> bimap.insert("b", "2")
    |> bimap.insert("c", "3")
    |> bimap.delete_by_key("b")
    |> bimap.insert("d", "2")
    // Reuse value "2"
    |> bimap.insert("a", "4")
  // Change value for key "a"

  // Final state should be: a->4, c->3, d->2
  let assert Ok("4") = bimap.get_by_key(bm, "a")
  let assert Ok("3") = bimap.get_by_key(bm, "c")
  let assert Ok("2") = bimap.get_by_key(bm, "d")
  let assert Error(Nil) = bimap.get_by_key(bm, "b")

  let assert Ok("a") = bimap.get_by_value(bm, "4")
  let assert Ok("c") = bimap.get_by_value(bm, "3")
  let assert Ok("d") = bimap.get_by_value(bm, "2")
  let assert Error(Nil) = bimap.get_by_value(bm, "1")
}

// Test with different types (Int keys, String values)
pub fn different_types_test() {
  let bm =
    bimap.new()
    |> bimap.insert(1, "one")
    |> bimap.insert(2, "two")
    |> bimap.insert(3, "three")

  let assert Ok("one") = bimap.get_by_key(bm, 1)
  let assert Ok("two") = bimap.get_by_key(bm, 2)
  let assert Ok("three") = bimap.get_by_key(bm, 3)

  let assert Ok(1) = bimap.get_by_value(bm, "one")
  let assert Ok(2) = bimap.get_by_value(bm, "two")
  let assert Ok(3) = bimap.get_by_value(bm, "three")
}

// Test bimap symmetry property
pub fn symmetry_test() {
  let bm =
    bimap.new()
    |> bimap.insert("key", "value")

  // If key->value exists, then value->key should also exist
  let assert Ok("key") =
    bimap.get_by_key(bm, "key")
    |> result.try(bimap.get_by_value(bm, _))

  let assert Ok("value") =
    bimap.get_by_value(bm, "value")
    |> result.try(bimap.get_by_key(bm, _))
}

pub fn from_list_test() {
  let kv_list = [#("key1", 1), #("key2", 2), #("key3", 3)]

  let bm = bimap.from_list(kv_list)

  list.each(kv_list, fn(pair) {
    let #(key, value) = pair

    bimap.get_by_key(bm, key)
    |> should.equal(Ok(value))

    bimap.get_by_value(bm, value)
    |> should.equal(Ok(key))
  })
}
