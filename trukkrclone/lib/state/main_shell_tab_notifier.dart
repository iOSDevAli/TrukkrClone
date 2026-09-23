import 'package:flutter/foundation.dart';

/// Lets a pushed screen (e.g. Vehicle Reports, reached from a Dashboard
/// tile) jump back into a specific MainShell tab: set this value, then
/// pop back to the root route. MainShell listens and updates itself.
/// Kept in its own file (rather than inside main_shell.dart) so screens
/// that need it don't have to import MainShell itself, which would
/// create an import cycle back through dashboard_screen.dart.
final ValueNotifier<int> mainShellTabIndex = ValueNotifier<int>(0);
