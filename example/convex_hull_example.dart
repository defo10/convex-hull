import 'package:convex_hull/convex_hull.dart';

class Example {
  final double xCoordinate;
  final double yCoordinate;
  final String info;

  const Example(this.xCoordinate, this.yCoordinate, this.info);
}

void main() {
  final points = <Example>[
    Example(0.0, 0.0, "1"),
    Example(2.0, 0.0, "2"),
    Example(2.0, 2.0, "3"),
    Example(0.0, 2.0, "6"),
    Example(1.0, 1.0, "f1"), // lies within convex hull
  ];

  convexHull<Example>(points, x: (e) => e.xCoordinate, y: (e) => e.yCoordinate);
  // > [Example(0.0, 0.0, "1"), Example(2.0, 0.0, "2"), Example(2.0, 2.0, "3"), Example(0.0, 2.0, "6")]
}
