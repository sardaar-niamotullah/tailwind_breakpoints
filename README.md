# 📐 tailwind_breakpoints

TailwindCSS style, mobile-first responsive breakpoints for Flutter.

![tailwind_breakpoints](https://raw.githubusercontent.com/sardaar-niamotullah/tailwind_breakpoints/main/assets/tailwind_breakpoints.webp)

Each breakpoint (`context.sm`, `context.md`, ...) is true from its width upwards, just like Tailwind's `md:` prefix. Check the screen size with simple getters on `BuildContext`, like `context.md`, `context.minWidth(900)` or `context.screenWidth`, instead of writing `MediaQuery.of(context).size.width`.

## 📦 Installation

Run this in your project:

```bash
flutter pub add tailwind_breakpoints
```

Then import it:

```dart
import 'package:tailwind_breakpoints/tailwind_breakpoints.dart';
```

## 🚀 Usage

```dart
Widget build(BuildContext context) {
  if (context.lg) return const DesktopLayout();
  if (context.md) return const TabletLayout();
  return const MobileLayout();
}
```

## 📏 Breakpoints

Flags are **mobile-first**: each one is true from its width upwards, so
several can be true at once. Check the largest first.

| Flag          | Minimum width |
| ------------- | ------------- |
| `context.xs`  | 480           |
| `context.sm`  | 640           |
| `context.md`  | 768           |
| `context.lg`  | 1024          |
| `context.xl`  | 1280          |
| `context.xxl` | 1536          |

Widths are in logical pixels. Below 480, no flag is true.

## 🧩 API

| Member                         | Description                       |
| ------------------------------ | --------------------------------- |
| `context.screenSize`           | Current window `Size`             |
| `context.screenWidth`          | Window width                      |
| `context.screenHeight`         | Window height                     |
| `context.xs` ... `context.xxl` | True when width >= the breakpoint |
| `context.minWidth(value)`      | True when width >= `value`        |
| `context.maxWidth(value)`      | True when width < `value`         |
| `context.between(min, max)`    | True when `min` <= width < `max`  |
| `Breakpoints.xs` ... `.xxl`    | The default breakpoint values     |

📖 [Full reference](https://pub.dev/documentation/tailwind_breakpoints/latest/)

## ✨ Why use it?

**Before**

```dart
final width = MediaQuery.of(context).size.width;
if (width >= 768) {
  // tablet and up
}
```

**After**

```dart
if (context.md) {
  // tablet and up
}
```

- ✂️ **Less code.** One getter replaces the lookup and the comparison.
- 🎯 **No magic numbers.** Breakpoint values live in one place instead of being repeated across your widgets.
- ⚡ **Fewer rebuilds.** It is built on `MediaQuery.sizeOf(context)`, not `MediaQuery.of(context)`. Your widgets only rebuild when the screen size changes, not when the keyboard opens or the padding changes.

## 🧪 Example

See the [example](https://github.com/sardaar-niamotullah/tailwind_breakpoints/tree/main/example) app, and resize the window to watch the
breakpoints change.

## 🛠️ Maintainer

- [Sardaar Niamotullah](https://github.com/sardaar-niamotullah)
