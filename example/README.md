# tailwind_breakpoints example

A small app that shows how the `tailwind_breakpoints` package works. Resize the
window and watch the background color and the breakpoint values change.

## What it shows

- The mobile-first flags (`context.xs` to `context.xxl`) and how several can be
  true at once.
- The current screen width from `context.screenWidth`.
- The `minWidth`, `maxWidth` and `between` helpers.
- How to pick one layout per screen size by checking the largest breakpoint
  first.

## Requirements

- [Flutter](https://docs.flutter.dev/get-started/install) 3.10 or newer
- A device or browser to run on (Chrome, an emulator, a simulator or a desktop
  target)

## Run the example

1. Clone the repository and go to the example folder:

```bash
   git clone https://github.com/sardaar-niamotullah/tailwind_breakpoints.git
   cd tailwind_breakpoints/example
```

2. Get the dependencies:

```bash
   flutter pub get
```

3. Run the app:

```bash
   flutter run -d chrome
```

Replace `chrome` with another device from `flutter devices`, for example
`macos`, `windows`, `linux` or the id of an emulator.

The example uses the package from the parent folder (`path: ../` in
`pubspec.yaml`), so any change you make to the package source shows up here
after a hot restart.

## Testing different screen sizes

| Breakpoint | Minimum width |
| ---------- | ------------- |
| `xs`       | 480           |
| `sm`       | 640           |
| `md`       | 768           |
| `lg`       | 1024          |
| `xl`       | 1280          |
| `xxl`      | 1536          |

- **Browser:** drag the window edge. To test widths below Chrome's ~500px
  minimum, use DevTools (`F12` / `Option+Cmd+I`), toggle the device toolbar
  (`Ctrl+Shift+M` / `Cmd+Shift+M`), pick **Responsive** and enter an exact
  width such as `479` or `768`.
- **Desktop:** resize the app window.
- **Phone or tablet:** run on an emulator or a real device and rotate it to
  cross a breakpoint.
