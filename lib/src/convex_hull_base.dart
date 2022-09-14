// ignore_for_file: non_constant_identifier_names

import 'package:logging/logging.dart';

extension on List<Point2d> {
  Point2d get secondToLast => elementAt(length - 2);
}

/// [Point2d] consists of the coordinate, x and y, a ref to the original Object
///  and some methods which are used to calculate the convex hull.
class Point2d<T> implements Comparable<Point2d> {
  final double x;
  final double y;
  final T? ref;

  const Point2d(this.x, this.y, [this.ref]);

  Point2d operator -(Point2d p) => Point2d(x - p.x, y - p.y);
  double cross(Point2d p) => x * p.y - y * p.x;

  @override
  int compareTo(Point2d other) =>
      ((x != other.x) ? x - other.x : y - other.y).round();

  @override
  String toString() => "($x;$y)";
}

enum Direction {
  clockwise,
  counterclockwise,
  collinear;

  /// returns the turn direction to go from line AB to o
  static Direction between(Point2d a, Point2d b, Point2d o) {
    final AB = b - a;
    final BO = o - b;
    final crossProduct = AB.cross(BO);
    if (crossProduct > 0) {
      return Direction.counterclockwise;
    } else if (crossProduct == 0) {
      return Direction.collinear;
    } else {
      return Direction.clockwise;
    }
  }
}

/// calculates the convex hull of [points].
///
/// [x] and [y] are accessor functions which specify what are the coordinates.
///
/// The returned convex hull starts with the leftmost point and traverses
/// counter-clockwise for standard orientation (positive x is right, positive
/// y is up), and clockwise for left-handed orientation (positive x is right,
/// positive y is *down*). Left-handed orientation is common in many computer
/// graphics applications.
///
/// Convex hull only works for lists of at least 3 points. If there are less,
/// the function returns the points without changing anything and logs an info
/// to the console.
///
/// Monotone chain is used as a n algorithm, having O(n log n) expected runtime.
Iterable<T> convexHull<T>(Iterable<T> points,
    {required double Function(T) x, required double Function(T) y}) {
  if (Set.from(points).length < 3) {
    Logger("ConvexHull").info("convexHull was called with less than 3 points.");
    return points;
  }

  final sortedPoints = points.map((e) => Point2d(x(e), y(e), e)).toList()
    ..sort();

  // wlog we assume a standard orientation, thus receive the lower half first,
  // then the upper half. For left-handed orientation, the names would switch.
  final lowerHalf = _halfHull(sortedPoints);
  final upperHalf = _halfHull(sortedPoints.reversed);

  lowerHalf.removeLast(); // last of lower half is same as first of upper half.
  upperHalf.removeLast();
  return [...lowerHalf.map((e) => e.ref), ...upperHalf.map((e) => e.ref)];
}

List<Point2d> _halfHull(Iterable<Point2d> points) {
  final halfHull = <Point2d>[];
  for (final point in points) {
    while (halfHull.length >= 2 &&
        Direction.between(halfHull.secondToLast, halfHull.last, point) !=
            Direction.counterclockwise) {
      halfHull.removeLast();
    }
    halfHull.add(point);
  }
  return halfHull;
}
