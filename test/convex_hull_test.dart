import 'package:convex_hull/convex_hull.dart';
import 'package:test/test.dart';

void main() {
  test('starts at most leftern point and goes counter-clockwise', () {
    final points = <Point2d>[
      Point2d(0.5, 1.5),
      Point2d(1.5, 0.5),
      Point2d(2.5, 1.5),
      Point2d(1.5, 2.5),
    ];

    expect(convexHull(points), equals(points));
  });

  test("does not contain inner points", () {
    final innerPoint1 = Point2d(0.2, 0.2);
    final innerPoint2 = Point2d(0.4, 0.4);
    final points = <Point2d>[
      Point2d(0, 0),
      innerPoint1,
      Point2d(1, 0),
      innerPoint2,
      Point2d(1, 1),
      Point2d(0, 1),
    ];

    final expected =
        points.where((el) => el != innerPoint1 && el != innerPoint2).toList();
    expect(convexHull(points), equals(expected));
  });

  test('does nothing if < 3 points', () {
    final points = <Point2d>[
      Point2d(0.5, 1.5),
      Point2d(1.5, 0.5),
    ];

    expect(convexHull(points), equals(points));
  });
}
