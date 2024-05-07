import gleam/string
import gleamy/red_black_tree_map as map
import gleeunit/should

pub fn insert_and_find_test() {
  let map = map.new(string.compare)
  let updated_map =
    map
    |> map.insert("key1", "value1")
    |> map.insert("key2", "value2")

  updated_map
  |> map.find("key1")
  |> should.equal(Ok("value1"))

  updated_map
  |> map.find("key2")
  |> should.equal(Ok("value2"))
}

pub fn delete_test() {
  let map =
    map.new(string.compare)
    |> map.insert("key1", "value1")
    |> map.insert("key2", "value2")

  let updated_map =
    map
    |> map.delete("key1")

  updated_map
  |> map.find("key1")
  |> should.equal(Error(Nil))

  updated_map
  |> map.find("key2")
  |> should.equal(Ok("value2"))
}

pub fn fold_test() {
  let map =
    map.new(string.compare)
    |> map.insert("key1", "value1")
    |> map.insert("key2", "value2")
    |> map.insert("key3", "value3")

  let result =
    map
    |> map.fold(0, fn(a, _, _) { a + 1 })

  result
  |> should.equal(3)
}

pub fn missing_keys_test() {
  let map =
    map.new(string.compare)
    |> map.insert("key1", "value1")
    |> map.insert("key2", "value2")

  map
  |> map.find("key3")
  |> should.equal(Error(Nil))

  let updated_map =
    map
    |> map.delete("key3")

  updated_map
  |> map.find("key3")
  |> should.equal(Error(Nil))
}
