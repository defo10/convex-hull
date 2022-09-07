/// Calculates the convex hull of a given set of points. Monotone chain
/// is used as algorithm.
///
/// The library consists of the [convexHull] function, which takes a list of
/// [Pointd2d]s and returns the convex hull.
library convex_hull;

export 'src/convex_hull_base.dart' show convexHull, Point2d;
