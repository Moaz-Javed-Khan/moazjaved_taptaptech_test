import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/cubit/theme_cubit.dart';

class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  static const double _mobileBreakpoint = 600;

  bool _isMobile(double width) => width < _mobileBreakpoint;

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.isDark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = _isMobile(constraints.maxWidth);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: isDark ? Colors.blueGrey : Colors.white,
            title: const Text("Moaz J. Khan Test"),
            actions: [
              CircleAvatar(
                backgroundColor: isDark ? Colors.white : Colors.blueGrey,
                child: const Icon(Icons.manage_accounts),
              ),
              const SizedBox(width: 8),
              Switch(
                value: isDark,
                onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => context.read<ThemeCubit>().toggleTheme(),
                child: AnimatedCrossFade(
                  firstChild: const Icon(Icons.sunny),
                  secondChild: const Icon(Icons.brightness_2),
                  crossFadeState: isDark
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 1200),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          drawer: isMobile ? _buildDrawer(context, isDark) : null,
          body: OrientationBuilder(
            builder: (context, orientation) {
              return Row(
                children: [
                  if (!isMobile) _buildSidebar(context, isDark),
                  Expanded(child: child),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSidebar(BuildContext context, bool isDark) {
    return Container(
      width: 240,
      color: isDark ? Colors.blueGrey : Colors.white,
      child: Column(
        children: [
          const Divider(height: 1),
          ListTile(
            title: const Text("Products"),
            onTap: () => context.go("/productsPage"),
          ),
          ListTile(
            title: const Text("Dashboard"),
            onTap: () => context.go("/dashboardPage"),
          ),
          ListTile(
            title: const Text("Settings"),
            onTap: () => context.go("/settingsPage"),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, bool isDark) {
    return Drawer(
      backgroundColor: isDark ? Colors.blueGrey : Colors.white,
      child: Column(
        children: [
          const DrawerHeader(
            child: Text(
              "Moaz J. Khan Test",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.inventory_2),
            title: const Text("Products"),
            onTap: () {
              context.go("/productsPage");
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text("Dashboard"),
            onTap: () {
              context.go("/dashboardPage");
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {
              context.go("/settingsPage");
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
