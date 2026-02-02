import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/product_entity.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    required this.productItemEntity,
    this.isCompact = false,
  });

  final ProductItemEntity? productItemEntity;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final useCompactLayout = isCompact || constraints.maxWidth < 400;
        return useCompactLayout
            ? _buildCompactLayout(context)
            : _buildTableLayout(context);
      },
    );
  }

  Widget _buildCompactLayout(BuildContext context) {
    final inStock = (productItemEntity?.stock ?? 0) > 0;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () => context.push("/productDetailView", extra: productItemEntity),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      productItemEntity?.title ?? "Laptop",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: (inStock ? Colors.green : Colors.red).shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      inStock ? "In Stock" : "Out of Stock",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "ID: ${productItemEntity?.id ?? 101}",
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      productItemEntity?.category ?? "Electronics",
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "\$${productItemEntity?.price ?? 199}",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            (productItemEntity?.id ?? 101).toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Expanded(
          flex: 3,
          child: TextButton(
            onPressed: () =>
                context.push("/productDetailView", extra: productItemEntity),
            child: Text(
              productItemEntity?.title ?? "Laptop",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            productItemEntity?.category ?? "Electronics",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "\$${productItemEntity?.price ?? 199}",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              (productItemEntity?.stock ?? 0) > 0
                  ? "In Stock"
                  : "Out of Stock",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ],
    );
  }
}
