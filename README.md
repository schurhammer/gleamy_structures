# gleamy_structures

[![Package Version](https://img.shields.io/hexpm/v/gleamy_structures)](https://hex.pm/packages/gleamy_structures)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/gleamy_structures/)

Data structures in pure Gleam.

## Supported Structures

- Map
- Set
- Heap
- Non-Empty List
- Priority Queue
- Bidirectional Map

### Priority Queue

`gleamy/priority_queue`:

This priority queue is a wrapper around `gleamy/pairing_heap`, providing additional functionality. The priority is comparison based in ascending order (lowest value first).

You may use the pairing heap or other heap structures directly for much of the same functionality.

```gleam
// priotity queue example
import gleam/int
import gleamy/priority_queue as pq

pub fn main() {
  let q = pq.from_list([2, 1, 3], int.compare)
  let x = pq.peek(q)
  // x = Ok(1)
}
```

### Heap

These heaps are min-heaps, providing efficient access to the minimum value based on a given comparison function.

`gleamy/pairing_heap`:

This is the recommended heap structure for most use cases. However, for some non-linear use cases the performance can degrade because of the amortized nature of this structure.

`gleamy/leftist_heap`:

This heap structure has consistent performance across all use cases.

```gleam
// heap example
import gleam/int
import gleamy/pairing_heap as heap

pub fn main() {
  let h =
    heap.new(int.compare)
    |> heap.insert(2)
    |> heap.insert(1)
    |> heap.insert(3)
  let x = heap.find_min(h)
  // x = Ok(1)
}
```

### Non-Empty List

`gleamy/non_empty_list`:

Non-Empty list is a list structure that always contains at least one item.

### Map

Maps are used for key-value lookups. Keys are compared with a user-provided comparison function.

`gleamy/map`:

This is a wrapper around `red_black_tree_map` providing additional utility functions.

`gleamy/red_black_tree_map`:

A map based on a red-black balanced tree structure.

### Set

Sets are used to store a collection of items. Items are compared with a user-provided comparison function to remove duplicate values.

`gleamy/set`:

This is a wrapper around `red_black_tree_set` providing additional utility functions.

`gleamy/red_black_tree_set`:

A set based on a red-black balanced tree structure.

### Bidirectional Map

`gleamy/bimap`

Each key can have a single value, and each value can have a single key.
Ordering is not guaranteed.

### Planned Structures

- graph
- quadtree
- array (use the `iv` package!)

## Installation

This package can be added to your Gleam project:

```sh
gleam add gleamy_structures
```

and its documentation can be found at <https://hexdocs.pm/gleamy_structures>.

## Contributions Welcome

Feel free to make PRs, issues, or requests for new data structures and functions :)
