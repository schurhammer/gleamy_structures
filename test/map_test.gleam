import gleam/list
import gleam/string
import gleamy/map
import gleeunit/should

pub fn insert_and_find_test() {
  let map = map.new(string.compare)
  let updated_map =
    map
    |> map.insert("key1", "value1")
    |> map.insert("key2", "value2")

  updated_map
  |> map.get("key1")
  |> should.equal(Ok("value1"))

  updated_map
  |> map.get("key2")
  |> should.equal(Ok("value2"))
}

pub fn has_key_test() {
  let map =
    map.new(string.compare)
    |> map.insert("key1", "value1")
    |> map.insert("key2", "value2")

  map
  |> map.has_key("key1")
  |> should.equal(True)

  map
  |> map.has_key("key3")
  |> should.equal(False)
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
  |> map.has_key("key1")
  |> should.equal(False)

  updated_map
  |> map.has_key("key2")
  |> should.equal(True)
}

pub fn count_test() {
  let map =
    map.new(string.compare)
    |> map.insert("key1", "value1")
    |> map.insert("key2", "value2")
    |> map.insert("key3", "value3")

  map
  |> map.count
  |> should.equal(3)
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

pub fn filter_test() {
  let map =
    map.new(string.compare)
    |> map.insert("key1", 1)
    |> map.insert("key2", 2)
    |> map.insert("key3", 3)

  let filtered_map =
    map
    |> map.filter(fn(_, v) { v > 1 })

  filtered_map
  |> map.count
  |> should.equal(2)
}

pub fn merge_test() {
  let map1 =
    map.new(string.compare)
    |> map.insert("key1", "value1")
    |> map.insert("key2", "value2-map1")

  let map2 =
    map.new(string.compare)
    |> map.insert("key2", "value2-map2")
    |> map.insert("key3", "value3")
    |> map.insert("key4", "value4")

  let merged_map = map.merge(map1, map2)

  merged_map
  |> map.count
  |> should.equal(4)

  merged_map
  |> map.get("key2")
  |> should.equal(Ok("value2-map2"))
}

pub fn take_test() {
  let map =
    map.new(string.compare)
    |> map.insert("key1", "value1")
    |> map.insert("key2", "value2")
    |> map.insert("key3", "value3")

  let desired = ["key1", "key3"]

  let taken_map =
    map
    |> map.take(desired)

  taken_map
  |> map.count
  |> should.equal(2)

  taken_map
  |> map.has_key("key1")
  |> should.equal(True)

  taken_map
  |> map.has_key("key2")
  |> should.equal(False)

  taken_map
  |> map.has_key("key3")
  |> should.equal(True)
}

pub fn missing_keys_test() {
  let map =
    map.new(string.compare)
    |> map.insert("key1", "value1")
    |> map.insert("key2", "value2")

  map
  |> map.get("key3")
  |> should.equal(Error(Nil))

  let updated_map =
    map
    |> map.delete("key3")

  updated_map
  |> map.has_key("key3")
  |> should.equal(False)
}

pub fn from_list_test() {
  let members = [#("key1", "value1"), #("key2", "value2"), #("key3", "value3")]

  let map = map.from_list(members, string.compare)

  map
  |> map.count
  |> should.equal(3)

  map
  |> map.get("key1")
  |> should.equal(Ok("value1"))

  map
  |> map.get("key2")
  |> should.equal(Ok("value2"))

  map
  |> map.get("key3")
  |> should.equal(Ok("value3"))
}

pub fn to_list_test() {
  let map =
    map.new(string.compare)
    |> map.insert("key1", "value1")
    |> map.insert("key2", "value2")
    |> map.insert("key3", "value3")

  let result =
    map
    |> map.to_list

  result
  |> list.length
  |> should.equal(3)

  result
  |> list.find(fn(i) { i.0 == "key1" && i.1 == "value1" })
  |> should.equal(Ok(#("key1", "value1")))

  result
  |> list.find(fn(i) { i.0 == "key2" && i.1 == "value2" })
  |> should.equal(Ok(#("key2", "value2")))

  result
  |> list.find(fn(i) { i.0 == "key3" && i.1 == "value3" })
  |> should.equal(Ok(#("key3", "value3")))
}
