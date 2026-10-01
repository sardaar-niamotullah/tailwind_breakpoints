import 'package:flutter/widgets.dart';

import 'breakpoints.dart';

/// Responsive helpers on [BuildContext], based on the window size.
extension TailwindBreakpointsContext on BuildContext {
  /// Current window size. Rebuilds only when the size changes.
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  /// Mobile-first: true when width >= the breakpoint.
  bool get xs => screenWidth >= Breakpoints.xs;
  bool get sm => screenWidth >= Breakpoints.sm;
  bool get md => screenWidth >= Breakpoints.md;
  bool get lg => screenWidth >= Breakpoints.lg;
  bool get xl => screenWidth >= Breakpoints.xl;
  bool get xxl => screenWidth >= Breakpoints.xxl;

  /// True when width >= [breakpoint].
  bool minWidth(double breakpoint) => screenWidth >= breakpoint;

  /// True when width < [breakpoint] (same as Tailwind's `max-*`).
  bool maxWidth(double breakpoint) => screenWidth < breakpoint;

  /// True when [min] <= width < [max].
  bool between(double min, double max) {
    assert(min < max, 'min must be less than max');
    return screenWidth >= min && screenWidth < max;
  }
}
