import 'package:flutter/material.dart';
import 'package:tailwind_breakpoints/tailwind_breakpoints.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tailwind_breakpoints example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const BreakpointDemo(),
    );
  }
}

/// How the breakpoint flags work
/// -----------------------------
/// Each flag is true from its breakpoint width UPWARDS (mobile-first):
///
///   context.xs   -> true when width >= 480
///   context.sm   -> true when width >= 640
///   context.md   -> true when width >= 768
///   context.lg   -> true when width >= 1024
///   context.xl   -> true when width >= 1280
///   context.xxl  -> true when width >= 1536
///
/// So at 1100px wide, xs, sm, md and lg are ALL true at the same time.
/// When you want to change something per screen size, check the
/// largest breakpoint first: the first one that is true wins.
class BreakpointDemo extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    Color color;

    if (context.xxl) {
      color = Colors.purple; // width >= 1536
    } else if (context.xl) {
      color = Colors.blue; // width 1280 to 1535
    } else if (context.lg) {
      color = Colors.teal; // width 1024 to 1279
    } else if (context.md) {
      color = Colors.green; // width 768 to 1023
    } else if (context.sm) {
      color = Colors.amber; // width 640 to 767
    } else if (context.xs) {
      color = Colors.orange; // width 480 to 639
    } else {
      color = Colors.blueGrey; // width < 480
    }

    return Scaffold(
      backgroundColor: color,
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(
              '${context.screenWidth.toStringAsFixed(0)} px',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 24),

            // Every flag, so you can see them overlap as you resize.
            Text('xs:  ${context.xs}'),
            Text('sm:  ${context.sm}'),
            Text('md:  ${context.md}'),
            Text('lg:  ${context.lg}'),
            Text('xl:  ${context.xl}'),
            Text('xxl: ${context.xxl}'),

            const SizedBox(height: 24),

            // Helpers for custom ranges.
            Text('minWidth(md): ${context.minWidth(Breakpoints.md)}'),
            Text('maxWidth(md): ${context.maxWidth(Breakpoints.md)}'),
            Text(
              'between(sm, lg): '
              '${context.between(Breakpoints.sm, Breakpoints.lg)}',
            ),
          ],
        ),
      ),
    );
  }
}
