import gleam/int
import gleamy/red_black_tree_set as set
import gleeunit/should

pub fn find_test() {
  let set = set.new(int.compare)
  let updated_set =
    set
    |> set.insert(1)
    |> set.insert(2)

  updated_set
  |> set.find(1)
  |> should.equal(Ok(1))

  updated_set
  |> set.find(3)
  |> should.equal(Error(Nil))
}

pub fn delete_test() {
  let set = set.new(int.compare)
  let updated_set =
    set
    |> set.insert(1)
    |> set.insert(2)

  let result_set =
    updated_set
    |> set.delete(1)

  result_set
  |> set.find(1)
  |> should.equal(Error(Nil))
}

pub fn fold_test() {
  let set = set.new(int.compare)
  let updated_set =
    set
    |> set.insert(1)
    |> set.insert(2)
    |> set.insert(3)

  let sum =
    updated_set
    |> set.fold(0, fn(acc, x) { acc + x })

  sum
  |> should.equal(6)
}

pub fn insert_test() {
  let set = set.new(int.compare)
  let updated_set =
    set
    |> set.insert(1)

  updated_set
  |> set.find(1)
  |> should.equal(Ok(1))
}

pub fn new_test() {
  let set = set.new(int.compare)

  set
  |> set.find(1)
  |> should.equal(Error(Nil))
}

fn to_list(set) -> List(a) {
  set.foldr(set, [], fn(a, i) { [i, ..a] })
}

pub fn insert_and_remove_test() {
  let set = set.new(int.compare)

  // Insert initial elements
  let updated_set =
    set
    |> set.insert(1)
    |> set.insert(2)
    |> set.insert(3)
    |> set.insert(4)
    |> set.insert(5)

  updated_set
  |> to_list()
  |> should.equal([1, 2, 3, 4, 5])

  // Remove an element
  let removed_set =
    updated_set
    |> set.delete(2)

  removed_set
  |> to_list()
  |> should.equal([1, 3, 4, 5])

  // Insert additional elements
  let final_set =
    removed_set
    |> set.insert(6)
    |> set.insert(7)
    |> set.insert(8)
    |> set.insert(9)
    |> set.insert(10)

  final_set
  |> to_list()
  |> should.equal([1, 3, 4, 5, 6, 7, 8, 9, 10])

  // Remove multiple elements
  let updated_set2 =
    final_set
    |> set.delete(3)
    |> set.delete(6)
    |> set.delete(9)

  updated_set2
  |> to_list()
  |> should.equal([1, 4, 5, 7, 8, 10])

  // Insert and remove elements
  let final_set2 =
    updated_set2
    |> set.insert(11)
    |> set.insert(12)
    |> set.delete(4)
    |> set.insert(13)
    |> set.delete(10)

  final_set2
  |> to_list()
  |> should.equal([1, 5, 7, 8, 11, 12, 13])
}
