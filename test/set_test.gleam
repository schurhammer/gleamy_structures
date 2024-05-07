import gleam/int
import gleamy/set
import gleeunit/should

pub fn contains_test() {
  let set = set.new(int.compare)
  let updated_set =
    set
    |> set.insert(1)
    |> set.insert(2)

  updated_set
  |> set.contains(1)
  |> should.equal(True)

  updated_set
  |> set.contains(3)
  |> should.equal(False)
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
  |> set.contains(1)
  |> should.equal(False)
}

pub fn filter_test() {
  let set = set.new(int.compare)
  let updated_set =
    set
    |> set.insert(1)
    |> set.insert(2)
    |> set.insert(3)
    |> set.insert(4)

  let filtered_set =
    updated_set
    |> set.filter(fn(x) { x % 2 == 0 })

  filtered_set
  |> set.contains(1)
  |> should.equal(False)

  filtered_set
  |> set.contains(2)
  |> should.equal(True)

  filtered_set
  |> set.contains(3)
  |> should.equal(False)

  filtered_set
  |> set.contains(4)
  |> should.equal(True)
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

pub fn from_list_test() {
  let members = [1, 2, 3]
  let set = set.from_list(members, int.compare)

  set
  |> set.contains(1)
  |> should.equal(True)

  set
  |> set.contains(4)
  |> should.equal(False)
}

pub fn insert_test() {
  let set = set.new(int.compare)
  let updated_set =
    set
    |> set.insert(1)

  updated_set
  |> set.contains(1)
  |> should.equal(True)
}

pub fn intersection_test() {
  let set1 = set.new(int.compare)
  let set2 = set.new(int.compare)
  let updated_set1 =
    set1
    |> set.insert(1)
    |> set.insert(2)
    |> set.insert(3)
  let updated_set2 =
    set2
    |> set.insert(2)
    |> set.insert(3)
    |> set.insert(4)

  let result_set = set.intersection(updated_set1, updated_set2)

  result_set
  |> set.contains(1)
  |> should.equal(False)

  result_set
  |> set.contains(2)
  |> should.equal(True)

  result_set
  |> set.contains(3)
  |> should.equal(True)

  result_set
  |> set.contains(4)
  |> should.equal(False)
}

pub fn new_test() {
  let set = set.new(int.compare)

  set
  |> set.contains(1)
  |> should.equal(False)
}

pub fn count_test() {
  let set = set.new(int.compare)
  let updated_set =
    set
    |> set.insert(1)
    |> set.insert(2)
    |> set.insert(3)

  let count = set.count(updated_set)

  count
  |> should.equal(3)
}

pub fn to_list_test() {
  let set = set.new(int.compare)
  let updated_set =
    set
    |> set.insert(1)
    |> set.insert(2)
    |> set.insert(3)

  let result_list = set.to_list(updated_set)

  result_list
  |> should.equal([1, 2, 3])
}

pub fn union_test() {
  let set1 = set.new(int.compare)
  let set2 = set.new(int.compare)
  let updated_set1 =
    set1
    |> set.insert(1)
    |> set.insert(2)
  let updated_set2 =
    set2
    |> set.insert(2)
    |> set.insert(3)

  let result_set = set.union(updated_set1, updated_set2)

  result_set
  |> set.contains(1)
  |> should.equal(True)

  result_set
  |> set.contains(2)
  |> should.equal(True)

  result_set
  |> set.contains(3)
  |> should.equal(True)
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
  |> set.to_list()
  |> should.equal([1, 2, 3, 4, 5])

  // Remove an element
  let removed_set =
    updated_set
    |> set.delete(2)

  removed_set
  |> set.to_list()
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
  |> set.to_list()
  |> should.equal([1, 3, 4, 5, 6, 7, 8, 9, 10])

  // Remove multiple elements
  let updated_set2 =
    final_set
    |> set.delete(3)
    |> set.delete(6)
    |> set.delete(9)

  updated_set2
  |> set.to_list()
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
  |> set.to_list()
  |> should.equal([1, 5, 7, 8, 11, 12, 13])
}
