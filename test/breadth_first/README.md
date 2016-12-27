# problem parameters #

find walls and such, of a 2-d space, with given parameters:

number of "1" bits of a given square are even, using
```
 x*x + 3*x + 2*x*y + y + y*y

times the designer's favorite number
```

steps:
first, create a grid that resembles this:

```
 0123456789
0 .#.####.##
1 ..#..#...#
2 #....##...
3 ###.#.###.
4 .##..#..#.
5 ..##....#.
6 #...##.###
```

solver
* NEED: hash of previous locations.
* NEED: breadth-first search

1. position 1,1
2. find valid moves
3. create new position, with current list of moves for each valid move

* repeat?
