import gleam/option.{Option}
import gleam/order
import gleam/list
import structures/red_black_tree as tree

type Map(a, b) =
  tree.Tree(#(a, b))

// TODO need a new tree structure designed to compare only keys
// old structure just compares the whole value

pub fn delete(from map: Map(a, b), delete key: a) -> Map(a, b) {
  todo
}

pub fn drop(from map: Map(a, b), drop disallowed_keys: List(a)) -> Map(a, b) {
  todo
}

pub fn filter(in map: Map(a, b), for property: fn(a, b) -> Bool) -> Map(a, b) {
  todo
}

pub fn fold(
  over map: Map(a, b),
  from initial: c,
  with fun: fn(c, a, b) -> c,
) -> c {
  todo
}

pub fn from_list(list: List(#(a, b))) -> Map(a, b) {
  todo
}

pub fn get(from: Map(a, b), get: a) -> Result(b, Nil) {
  todo
}

pub fn has_key(map: Map(a, b), key: a) -> Bool {
  todo
}

pub fn insert(into map: Map(a, b), for key: a, insert value: b) -> Map(a, b) {
  todo
}

pub fn keys(map: Map(a, b)) -> List(a) {
  todo
}

pub fn map_values(in map: Map(a, b), with fun: fn(a, b) -> c) -> Map(a, c) {
  todo
}

pub fn merge(into map: Map(a, b), from new_entries: Map(a, b)) -> Map(a, b) {
  todo
}

pub fn new() -> Map(a, b) {
  todo
}

pub fn count(map: Map(a, b)) -> Int {
  todo
}

pub fn take(from map: Map(a, b), keeping desired_keys: List(a)) -> Map(a, b) {
  todo
}

pub fn to_list(map: Map(a, b)) -> List(#(a, b)) {
  todo
}

pub fn update(
  in map: Map(a, b),
  update key: a,
  with fun: fn(Option(b)) -> b,
) -> Map(a, b) {
  todo
}

pub fn values(map: Map(a, b)) -> List(b) {
  todo
}
