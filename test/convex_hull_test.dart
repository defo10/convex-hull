import 'package:convex_hull/convex_hull.dart';
import 'package:test/test.dart';

class Example {
  final double xCoordinate;
  final double yCoordinate;
  final String info;

  const Example(this.xCoordinate, this.yCoordinate, this.info);
}

void main() {
  test('starts at most leftern point and goes counter-clockwise', () {
    final points = <Example>[
      Example(0.5, 1.5, "1"),
      Example(1.5, 0.5, "2"),
      Example(2.5, 1.5, "3"),
      Example(1.5, 2.5, "4"),
    ];

    final hull = convexHull<Example>(points,
        x: (e) => e.xCoordinate, y: (e) => e.yCoordinate).map((e) => e.info);
    expect(hull, equals(["1", "2", "3", "4"]));
  });

  test("does not contain inner points", () {
    final points = <Example>[
      Example(0, 0, "a"),
      Example(0.2, 0.2, "b"),
      Example(1, 0, "c"),
      Example(0.2, 0.2, "d"),
      Example(1, 1, "e"),
      Example(0, 1, "f"),
    ];

    final expected = ["a", "c", "e", "f"];
    final hull = convexHull<Example>(points,
        x: (e) => e.xCoordinate, y: (e) => e.yCoordinate).map((e) => e.info);
    expect(hull, equals(expected));
  });

  test('does nothing if < 3 points', () {
    final points = <Example>[
      Example(0.5, 1.5, "1"),
      Example(1.5, 0.5, "2"),
    ];

    final hull = convexHull<Example>(points,
        x: (e) => e.xCoordinate, y: (e) => e.yCoordinate).map((e) => e.info);
    expect(hull, equals(["1", "2"]));
  });
}
