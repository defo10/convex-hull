import 'package:convex_hull/convex_hull.dart';

void main() {
  final points = <Point2d>[
    Point2d(0.0, 0.0),
    Point2d(2.0, 0.0),
    Point2d(2.0, 2.0),
    Point2d(0.0, 2.0),
    Point2d(1.0, 1.0), // lies within convex hull
  ];

  convexHull(points);
  // >>> [(0.0, 0.0), (2.0, 0.0), (2.0, 2.0), (0.0, 2.0)]
}
