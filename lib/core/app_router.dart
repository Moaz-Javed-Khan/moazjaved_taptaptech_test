import 'package:go_router/go_router.dart';

import '../features/product/presentation/pages/app_shell.dart';
import '../features/product/presentation/pages/dashboard/dashboard_view.dart';
import '../features/product/presentation/pages/product/product_detail_view.dart';
import '../features/product/presentation/pages/product/products_page.dart';
import '../features/product/presentation/pages/settings/settings_view.dart';

final router = GoRouter(
  initialLocation: '/dashboardPage',

  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return AppShell(child: child);
      },

      routes: [
        GoRoute(
          path: '/dashboardPage',
          builder: (_, __) => const DashboardView(),
        ),
        GoRoute(
          path: '/productsPage',
          builder: (_, __) => const ProductsPage(),
        ),
        GoRoute(
          path: '/settingsPage',
          builder: (_, __) => const SettingsView(),
        ),

        GoRoute(
          path: '/productDetailView',
          builder: (_, __) => const ProductDetailView(),
        ),
      ],
    ),
  ],
);
