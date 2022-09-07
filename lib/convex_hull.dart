/// Calculates the convex hull of a given set of points. Monotone chain
/// is used as algorithm.
///
/// The library consists of the [convexHull] function, which takes a generic
/// list and accessor functions for the x and y coordinates.
library convex_hull;

export 'src/convex_hull_base.dart' show convexHull;
