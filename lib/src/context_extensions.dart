import 'package:flutter/widgets.dart';

import 'breakpoints.dart';

/// Responsive helpers on [BuildContext], based on the window size.
///
/// The breakpoint flags are mobile-first: each one is true from its width
/// upwards, so several can be true at once. Check the largest first.
extension TailwindBreakpointsContext on BuildContext {
  /// Current window size. Rebuilds only when the size changes.
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Current window width in logical pixels.
  double get screenWidth => screenSize.width;

  /// Current window height in logical pixels.
  double get screenHeight => screenSize.height;

  /// True when the width is at least [Breakpoints.xs] (480).
  bool get xs => screenWidth >= Breakpoints.xs;

  /// True when the width is at least [Breakpoints.sm] (640).
  bool get sm => screenWidth >= Breakpoints.sm;

  /// True when the width is at least [Breakpoints.md] (768).
  bool get md => screenWidth >= Breakpoints.md;

  /// True when the width is at least [Breakpoints.lg] (1024).
  bool get lg => screenWidth >= Breakpoints.lg;

  /// True when the width is at least [Breakpoints.xl] (1280).
  bool get xl => screenWidth >= Breakpoints.xl;

  /// True when the width is at least [Breakpoints.xxl] (1536).
  bool get xxl => screenWidth >= Breakpoints.xxl;

  /// True when the width is at least [breakpoint] (width >= breakpoint).
  bool minWidth(double breakpoint) => screenWidth >= breakpoint;

  /// True when the width is below [breakpoint] (width < breakpoint).
  ///
  /// Same as Tailwind's `max-*` variants.
  bool maxWidth(double breakpoint) => screenWidth < breakpoint;

  /// True when [min] <= width < [max].
  ///
  /// [min] must be less than [max].
  bool between(double min, double max) {
    assert(min < max, 'min must be less than max');
    return screenWidth >= min && screenWidth < max;
  }
}
