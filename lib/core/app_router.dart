import 'package:go_router/go_router.dart';

import '../features/product/presentation/pages/app_shell.dart';
import '../features/product/presentation/pages/dashboard/dashboard_page.dart';
import '../features/product/presentation/pages/product/products_detail_page.dart';
import '../features/product/presentation/pages/product/products_page.dart';
import '../features/product/presentation/pages/settings/settings_view.dart';

final router = GoRouter(
  initialLocation: '/productsPage',

  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return AppShell(child: child);
      },

      routes: [
        GoRoute(
          path: '/productsPage',
          builder: (_, __) => const ProductsPage(),
        ),
        GoRoute(
          path: '/dashboardPage',
          builder: (_, __) => const DashboardPage(),
        ),
        GoRoute(
          path: '/settingsPage',
          builder: (_, __) => const SettingsView(),
        ),

        GoRoute(
          path: '/productDetailView',
          builder: (_, __) => const ProductsDetailPage(),
        ),
      ],
    ),
  ],
);
