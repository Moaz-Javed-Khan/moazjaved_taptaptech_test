import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/cubit/theme_cubit.dart';

class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.isDark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? Colors.blueGrey : Colors.white,
        title: Text("Moaz J. Khan Test"),

        actions: [
          CircleAvatar(
            backgroundColor: isDark ? Colors.white : Colors.blueGrey,
            child: Icon(Icons.manage_accounts),
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

      body: Row(
        children: [
          Container(
            width: 240,
            color: isDark ? Colors.blueGrey : Colors.white,
            child: Column(
              children: [
                const Divider(height: 1),
                ListTile(
                  title: Text("Dashboard"),
                  onTap: () => context.go("/dashboardPage"),
                ),
                ListTile(
                  title: Text("Products"),
                  onTap: () => context.go("/productsPage"),
                ),
                ListTile(
                  title: Text("Settings"),
                  onTap: () => context.go("/settingsPage"),
                ),
              ],
            ),
          ),

          Expanded(child: child),
        ],
      ),
    );
  }
}
