Calculates the convex hull of a given set of points. Monotone chain is used as algorithm.

## Info

Given a set of points, the convex hull is a subset of points which form a polygon that encloses all points. The implemented algorithm is [Andrew's monotone chain algorithm](), which has an efficient O(n log n) runtime.

<img src="https://upload.wikimedia.org/wikipedia/commons/9/9a/Animation_depicting_the_Monotone_algorithm.gif">
(Maonus, [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0), via Wikimedia Commons)

## Usage

The library consists of the `convexHull` function, which takes a generic list of objects and accessor function for the x and y coordinates, and returns the objects forming a convex hull.

```dart
import 'package:vector_math/vector_math_64.dart';
import 'package:convex_hull/convex_hull.dart';

// you can use an iterable of any object. Here,
// Vector2 is used.
const points = <Vector2>[
    Vector2(1, 2),
    Vector2(3.2, 1),
    Vector2(1.3, 1),
]
// specify what should be considered as the x and y coordinate
List<Vector2> hull = convexHull<Vector2>(points, x: (e) => e.x, y: (e) => e.y);
```
