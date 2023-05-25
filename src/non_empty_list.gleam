pub type NonEmptyList(a) {
  End(first: a)
  Item(first: a, rest: NonEmptyList(a))
}
