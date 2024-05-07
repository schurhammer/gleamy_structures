//// This module provides a type and functions for working with non-empty lists,
//// which are lists that are guaranteed to have at least one element.

import gleam/list

/// The `NonEmptyList(a)` type represents a non-empty list of elements of type `a`.
/// It has two cases: `End(first: a)` for a list with a single element, and
/// `Next(first: a, rest: NonEmptyList(a))` for a list with multiple elements.
pub type NonEmptyList(a) {
  End(first: a)
  Next(first: a, rest: NonEmptyList(a))
}

/// Applies a function to every element in the non-empty list, accumulating
/// the results with the provided initial accumulator value.
pub fn fold(
  over list: NonEmptyList(a),
  from initial: b,
  with fun: fn(b, a) -> b,
) -> b {
  case list {
    End(item) -> fun(initial, item)
    Next(x, xs) -> fold(xs, fun(initial, x), fun)
  }
}

/// Returns the count (number of elements) in the non-empty list.
/// Time complexity: O(n)
pub fn count(list: NonEmptyList(a)) -> Int {
  fold(list, 0, fn(acc, _) { acc + 1 })
}

/// Applies a transformation function to every element in the non-empty list
/// and returns a new non-empty list with the transformed elements.
pub fn map(list: NonEmptyList(a), transform: fn(a) -> b) -> NonEmptyList(b) {
  case list {
    End(x) -> End(transform(x))
    Next(x, xs) ->
      fold(xs, End(transform(x)), fn(acc, item) { Next(transform(item), acc) })
      |> reverse
  }
}

/// Filters the elements of the non-empty list based on a predicate function
/// and returns a (potentially empty) list with the elements that satisfy the predicate.
pub fn filter(list: NonEmptyList(a), predicate: fn(a) -> Bool) -> List(a) {
  fold(list, [], fn(acc, item) {
    case predicate(item) {
      True -> [item, ..acc]
      False -> acc
    }
  })
  |> list.reverse()
}

/// Converts the non-empty list to a regular (potentially empty) list.
pub fn to_list(list: NonEmptyList(a)) -> List(a) {
  fold(list, [], fn(acc, item) { [item, ..acc] })
  |> list.reverse()
}

/// Tries to create a non-empty list from a regular (potentially empty) list.
/// Returns an error if the input list is empty.
pub fn from_list(list: List(a)) -> Result(NonEmptyList(a), Nil) {
  case list {
    [] -> Error(Nil)
    [x, ..xs] -> Ok(list.fold(xs, End(x), fn(acc, item) { Next(item, acc) }))
  }
}

/// Reverses the order of elements in the non-empty list.
pub fn reverse(list: NonEmptyList(a)) -> NonEmptyList(a) {
  case list {
    End(_) -> list
    Next(x, xs) -> fold(xs, End(x), fn(acc, x) { Next(x, acc) })
  }
}
