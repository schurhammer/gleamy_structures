import gleam/int
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

pub fn larger_test() {
  let map =
    map.new(int.compare)
    |> map.insert(1, "1")
    |> map.insert(3, "3")
    |> map.insert(5, "5")
    |> map.insert(7, "7")

  should.equal(map.larger(map, 0), Ok(#(1, "1")))
  should.equal(map.larger(map, 1), Ok(#(3, "3")))
  should.equal(map.larger(map, 2), Ok(#(3, "3")))
  should.equal(map.larger(map, 3), Ok(#(5, "5")))
  should.equal(map.larger(map, 4), Ok(#(5, "5")))
  should.equal(map.larger(map, 5), Ok(#(7, "7")))
  should.equal(map.larger(map, 6), Ok(#(7, "7")))
  should.equal(map.larger(map, 7), Error(Nil))
  should.equal(map.larger(map, 8), Error(Nil))

  let map =
    map.new(int.compare)
    |> map.insert(2, 0)
    |> map.insert(8, 0)
    |> map.insert(4, 0)
    |> map.insert(14, 0)
    |> map.insert(1, 0)
    |> map.insert(12, 0)
    |> map.insert(9, 0)
    |> map.insert(11, 0)
    |> map.insert(5, 0)
    |> map.insert(15, 0)
    |> map.insert(6, 0)
    |> map.insert(16, 0)
    |> map.insert(7, 0)
    |> map.insert(13, 0)
    |> map.insert(3, 0)
    |> map.insert(10, 0)

  should.equal(map.larger(map, 0), Ok(#(1, 0)))
  should.equal(map.larger(map, 1), Ok(#(2, 0)))
  should.equal(map.larger(map, 2), Ok(#(3, 0)))
  should.equal(map.larger(map, 3), Ok(#(4, 0)))
  should.equal(map.larger(map, 4), Ok(#(5, 0)))
  should.equal(map.larger(map, 5), Ok(#(6, 0)))
  should.equal(map.larger(map, 6), Ok(#(7, 0)))
  should.equal(map.larger(map, 7), Ok(#(8, 0)))
  should.equal(map.larger(map, 8), Ok(#(9, 0)))
  should.equal(map.larger(map, 9), Ok(#(10, 0)))
  should.equal(map.larger(map, 10), Ok(#(11, 0)))
  should.equal(map.larger(map, 11), Ok(#(12, 0)))
  should.equal(map.larger(map, 12), Ok(#(13, 0)))
  should.equal(map.larger(map, 13), Ok(#(14, 0)))
  should.equal(map.larger(map, 14), Ok(#(15, 0)))
  should.equal(map.larger(map, 15), Ok(#(16, 0)))
  should.equal(map.larger(map, 16), Error(Nil))
  should.equal(map.larger(map, 17), Error(Nil))
}

pub fn smaller_test() {
  let map =
    map.new(int.compare)
    |> map.insert(1, "1")
    |> map.insert(3, "3")
    |> map.insert(5, "5")
    |> map.insert(7, "7")

  should.equal(map.smaller(map, 0), Error(Nil))
  should.equal(map.smaller(map, 1), Error(Nil))
  should.equal(map.smaller(map, 2), Ok(#(1, "1")))
  should.equal(map.smaller(map, 3), Ok(#(1, "1")))
  should.equal(map.smaller(map, 4), Ok(#(3, "3")))
  should.equal(map.smaller(map, 5), Ok(#(3, "3")))
  should.equal(map.smaller(map, 6), Ok(#(5, "5")))
  should.equal(map.smaller(map, 7), Ok(#(5, "5")))
  should.equal(map.smaller(map, 8), Ok(#(7, "7")))

  let map =
    map.new(int.compare)
    |> map.insert(2, 0)
    |> map.insert(8, 0)
    |> map.insert(4, 0)
    |> map.insert(14, 0)
    |> map.insert(1, 0)
    |> map.insert(12, 0)
    |> map.insert(9, 0)
    |> map.insert(11, 0)
    |> map.insert(5, 0)
    |> map.insert(15, 0)
    |> map.insert(6, 0)
    |> map.insert(16, 0)
    |> map.insert(7, 0)
    |> map.insert(13, 0)
    |> map.insert(3, 0)
    |> map.insert(10, 0)

  should.equal(map.smaller(map, 0), Error(Nil))
  should.equal(map.smaller(map, 1), Error(Nil))
  should.equal(map.smaller(map, 2), Ok(#(1, 0)))
  should.equal(map.smaller(map, 3), Ok(#(2, 0)))
  should.equal(map.smaller(map, 4), Ok(#(3, 0)))
  should.equal(map.smaller(map, 5), Ok(#(4, 0)))
  should.equal(map.smaller(map, 6), Ok(#(5, 0)))
  should.equal(map.smaller(map, 7), Ok(#(6, 0)))
  should.equal(map.smaller(map, 8), Ok(#(7, 0)))
  should.equal(map.smaller(map, 9), Ok(#(8, 0)))
  should.equal(map.smaller(map, 10), Ok(#(9, 0)))
  should.equal(map.smaller(map, 11), Ok(#(10, 0)))
  should.equal(map.smaller(map, 12), Ok(#(11, 0)))
  should.equal(map.smaller(map, 13), Ok(#(12, 0)))
  should.equal(map.smaller(map, 14), Ok(#(13, 0)))
  should.equal(map.smaller(map, 15), Ok(#(14, 0)))
  should.equal(map.smaller(map, 16), Ok(#(15, 0)))
  should.equal(map.smaller(map, 17), Ok(#(16, 0)))
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
