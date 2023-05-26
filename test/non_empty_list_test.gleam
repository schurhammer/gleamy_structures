import gleeunit/should
import gleamy_structures/non_empty_list

pub fn fold_test() {
  let list = non_empty_list.End(1)
  let result = non_empty_list.fold(list, 0, fn(acc, item) { acc + item })
  result
  |> should.equal(1)
}

pub fn count_test() {
  let list = non_empty_list.Next(1, non_empty_list.End(2))
  let result = non_empty_list.count(list)
  result
  |> should.equal(2)
}

pub fn map_test() {
  let list = non_empty_list.Next(1, non_empty_list.End(2))
  let result = non_empty_list.map(list, fn(x) { x * 2 })
  result
  |> should.equal(non_empty_list.Next(2, non_empty_list.End(4)))
}

pub fn filter_test() {
  let list = non_empty_list.Next(1, non_empty_list.End(2))
  let result = non_empty_list.filter(list, fn(x) { x % 2 == 0 })
  result
  |> should.equal([2])
}

pub fn to_list_test() {
  let list = non_empty_list.Next(1, non_empty_list.End(2))
  let result = non_empty_list.to_list(list)
  result
  |> should.equal([1, 2])
}

pub fn reverse_test() {
  let list = non_empty_list.Next(1, non_empty_list.End(2))
  let result = non_empty_list.reverse(list)
  result
  |> should.equal(non_empty_list.Next(2, non_empty_list.End(1)))
}
