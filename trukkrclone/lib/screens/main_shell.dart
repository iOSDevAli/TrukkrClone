import 'package:flutter/material.dart';
import '../state/main_shell_tab_notifier.dart';
import '../widgets/trukkr_bottom_nav.dart';
import 'dashboard_screen.dart';
import 'events_alerts_screen.dart';
import 'map_screen.dart';
import 'settings_screen.dart';
import 'status_screen.dart';

/// The app's persistent frame: one Scaffold whose bottomNavigationBar
/// never goes away, with an IndexedStack swapping which tab is shown
/// above it.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  static const _tabs = [
    DashboardScreen(),
    MapScreen(),
    StatusScreen(),
    EventsAlertsScreen(showBackButton: false),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    mainShellTabIndex.addListener(_onGlobalTabChange);
  }

  @override
  void dispose() {
    mainShellTabIndex.removeListener(_onGlobalTabChange);
    super.dispose();
  }

  void _onGlobalTabChange() {
    if (mounted && mainShellTabIndex.value != _index) {
      setState(() => _index = mainShellTabIndex.value);
    }
  }

  void _onNavTap(int navIndex) {
    setState(() => _index = navIndex);
    mainShellTabIndex.value = navIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _tabs),
      bottomNavigationBar: TrukkrBottomNav(
        currentIndex: _index,
        onTap: _onNavTap,
      ),
    );
  }
}
