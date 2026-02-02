import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/cubit/product_cubit.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 600;
          final isVeryNarrow = constraints.maxWidth < 400;

          return OrientationBuilder(
            builder: (context, orientation) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isNarrow ? 12 : 24,
                  vertical: isNarrow ? 12 : 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Dashboard",
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Welcome back! Here's an overview of your products.",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _statsSection(context, isNarrow, isVeryNarrow),
                    const SizedBox(height: 24),
                    _quickActions(context, isNarrow),
                    const SizedBox(height: 24),
                    _recentInfo(context, isNarrow),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _statsSection(BuildContext context, bool isNarrow, bool isVeryNarrow) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final products = state.productModel?.products ?? [];
        final total = state.productModel?.total ?? products.length;
        final inStockCount = products.where((p) => (p.stock) > 0).length;
        final isLoading = state.getProductStatus == GetProductsStatus.loading;

        return Wrap(
          spacing: isNarrow ? 12 : 16,
          runSpacing: isNarrow ? 12 : 16,
          children: [
            _StatCard(
              icon: Icons.inventory_2_outlined,
              label: "Total Products",
              value: isLoading ? "—" : total.toString(),
              isNarrow: isVeryNarrow,
            ),
            _StatCard(
              icon: Icons.category_outlined,
              label: "Categories",
              value: isLoading ? "—" : "8",
              isNarrow: isVeryNarrow,
            ),
            _StatCard(
              icon: Icons.check_circle_outline,
              label: "In Stock",
              value: isLoading ? "—" : inStockCount.toString(),
              isNarrow: isVeryNarrow,
            ),
          ],
        );
      },
    );
  }

  Widget _quickActions(BuildContext context, bool isNarrow) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Actions",
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        isNarrow
            ? Column(
                children: [
                  _QuickActionTile(
                    icon: Icons.list_alt,
                    label: "View All Products",
                    onTap: () => context.go("/productsPage"),
                  ),
                  const SizedBox(height: 8),
                  _QuickActionTile(
                    icon: Icons.search,
                    label: "Search by Category",
                    onTap: () => context.go("/productsPage"),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: _QuickActionTile(
                      icon: Icons.list_alt,
                      label: "View All Products",
                      onTap: () => context.go("/productsPage"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _QuickActionTile(
                      icon: Icons.search,
                      label: "Search by Category",
                      onTap: () => context.go("/productsPage"),
                    ),
                  ),
                ],
              ),
      ],
    );
  }

  Widget _recentInfo(BuildContext context, bool isNarrow) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: isNarrow ? 20 : 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  "Getting Started",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              "Use the Products page to browse, add, and manage your inventory. "
              "You can search by category or view individual product details.",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.isNarrow,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool isNarrow;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(isNarrow ? 12 : 16),
        child: SizedBox(
          width: isNarrow ? null : 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: isNarrow ? 24 : 28,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  const _QuickActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
