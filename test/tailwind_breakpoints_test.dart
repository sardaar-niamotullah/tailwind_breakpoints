import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tailwind_breakpoints/tailwind_breakpoints.dart';

/// Pumps a tree at the given logical size and returns a BuildContext
/// that sits below the MediaQuery.
Future<BuildContext> pumpAt(
  WidgetTester tester, {
  required double width,
  double height = 800,
  double devicePixelRatio = 1,
}) async {
  tester.view.devicePixelRatio = devicePixelRatio;
  tester.view.physicalSize = Size(
    width * devicePixelRatio,
    height * devicePixelRatio,
  );
  addTearDown(tester.view.reset);

  late BuildContext ctx;
  await tester.pumpWidget(
    WidgetsApp(
      color: const Color(0xFFFFFFFF),
      builder: (context, _) => Builder(
        builder: (c) {
          ctx = c;
          return const SizedBox();
        },
      ),
    ),
  );
  return ctx;
}

void main() {
  // (name, breakpoint value, getter)
  final flags = <(String, double, bool Function(BuildContext))>[
    ('xs', Breakpoints.xs, (c) => c.xs),
    ('sm', Breakpoints.sm, (c) => c.sm),
    ('md', Breakpoints.md, (c) => c.md),
    ('lg', Breakpoints.lg, (c) => c.lg),
    ('xl', Breakpoints.xl, (c) => c.xl),
    ('xxl', Breakpoints.xxl, (c) => c.xxl),
  ];

  group('Breakpoints constants', () {
    test('match Tailwind-style values', () {
      expect(Breakpoints.xs, 480);
      expect(Breakpoints.sm, 640);
      expect(Breakpoints.md, 768);
      expect(Breakpoints.lg, 1024);
      expect(Breakpoints.xl, 1280);
      expect(Breakpoints.xxl, 1536);
    });

    test('are strictly ascending', () {
      final values = flags.map((f) => f.$2).toList();
      for (var i = 1; i < values.length; i++) {
        expect(values[i], greaterThan(values[i - 1]));
      }
    });
  });

  group('screenSize / screenWidth / screenHeight', () {
    testWidgets('return the logical window size', (tester) async {
      final ctx = await pumpAt(tester, width: 900, height: 600);
      expect(ctx.screenSize, const Size(900, 600));
      expect(ctx.screenWidth, 900);
      expect(ctx.screenHeight, 600);
    });

    testWidgets('use logical pixels, not physical', (tester) async {
      final ctx = await pumpAt(
        tester,
        width: 800,
        height: 400,
        devicePixelRatio: 2,
      );
      expect(ctx.screenWidth, 800);
      expect(ctx.screenHeight, 400);
    });
  });

  group('breakpoint flags', () {
    for (final (name, value, read) in flags) {
      testWidgets('$name is false just below $value', (tester) async {
        final ctx = await pumpAt(tester, width: value - 1);
        expect(read(ctx), isFalse);
      });

      testWidgets('$name is true exactly at $value', (tester) async {
        final ctx = await pumpAt(tester, width: value);
        expect(read(ctx), isTrue);
      });

      testWidgets('$name is true above $value', (tester) async {
        final ctx = await pumpAt(tester, width: value + 100);
        expect(read(ctx), isTrue);
      });
    }

    testWidgets('all flags are false below xs', (tester) async {
      final ctx = await pumpAt(tester, width: 300);
      for (final (_, _, read) in flags) {
        expect(read(ctx), isFalse);
      }
    });

    testWidgets('all flags are true at or above xxl', (tester) async {
      final ctx = await pumpAt(tester, width: 1600);
      for (final (_, _, read) in flags) {
        expect(read(ctx), isTrue);
      }
    });

    testWidgets('are mobile-first: smaller flags stay true', (tester) async {
      final ctx = await pumpAt(tester, width: 1100);
      expect(ctx.xs, isTrue);
      expect(ctx.sm, isTrue);
      expect(ctx.md, isTrue);
      expect(ctx.lg, isTrue);
      expect(ctx.xl, isFalse);
      expect(ctx.xxl, isFalse);
    });
  });

  group('minWidth', () {
    testWidgets('is inclusive at the boundary', (tester) async {
      var ctx = await pumpAt(tester, width: 768);
      expect(ctx.minWidth(768), isTrue);

      ctx = await pumpAt(tester, width: 767);
      expect(ctx.minWidth(768), isFalse);
    });

    testWidgets('works with Breakpoints constants and raw values',
        (tester) async {
      final ctx = await pumpAt(tester, width: 700);
      expect(ctx.minWidth(Breakpoints.sm), isTrue);
      expect(ctx.minWidth(Breakpoints.md), isFalse);
      expect(ctx.minWidth(500), isTrue);
      expect(ctx.minWidth(701), isFalse);
    });
  });

  group('maxWidth', () {
    testWidgets('is exclusive at the boundary', (tester) async {
      var ctx = await pumpAt(tester, width: 768);
      expect(ctx.maxWidth(768), isFalse);

      ctx = await pumpAt(tester, width: 767);
      expect(ctx.maxWidth(768), isTrue);
    });

    testWidgets('works with Breakpoints constants and raw values',
        (tester) async {
      final ctx = await pumpAt(tester, width: 700);
      expect(ctx.maxWidth(Breakpoints.md), isTrue);
      expect(ctx.maxWidth(Breakpoints.sm), isFalse);
      expect(ctx.maxWidth(701), isTrue);
      expect(ctx.maxWidth(700), isFalse);
    });

    testWidgets('is the exact opposite of the matching flag', (tester) async {
      for (final (_, value, read) in flags) {
        final ctx = await pumpAt(tester, width: value);
        expect(ctx.maxWidth(value), isNot(read(ctx)));
      }
    });
  });

  group('between', () {
    testWidgets('is true inside the range', (tester) async {
      final ctx = await pumpAt(tester, width: 800);
      expect(ctx.between(Breakpoints.sm, Breakpoints.lg), isTrue);
    });

    testWidgets('includes min and excludes max', (tester) async {
      var ctx = await pumpAt(tester, width: 640);
      expect(ctx.between(640, 1024), isTrue);

      ctx = await pumpAt(tester, width: 1023);
      expect(ctx.between(640, 1024), isTrue);

      ctx = await pumpAt(tester, width: 1024);
      expect(ctx.between(640, 1024), isFalse);

      ctx = await pumpAt(tester, width: 639);
      expect(ctx.between(640, 1024), isFalse);
    });

    testWidgets('is false outside the range', (tester) async {
      var ctx = await pumpAt(tester, width: 300);
      expect(ctx.between(Breakpoints.md, Breakpoints.xl), isFalse);

      ctx = await pumpAt(tester, width: 1500);
      expect(ctx.between(Breakpoints.md, Breakpoints.xl), isFalse);
    });

    testWidgets('throws an assertion error when min >= max', (tester) async {
      final ctx = await pumpAt(tester, width: 800);
      expect(() => ctx.between(1024, 640), throwsAssertionError);
      expect(() => ctx.between(768, 768), throwsAssertionError);
    });
  });

  group('rebuilding on resize', () {
    testWidgets('values update when the window size changes', (tester) async {
      var ctx = await pumpAt(tester, width: 500);
      expect(ctx.md, isFalse);

      ctx = await pumpAt(tester, width: 900);
      expect(ctx.md, isTrue);
      expect(ctx.screenWidth, 900);
    });
  });
}
