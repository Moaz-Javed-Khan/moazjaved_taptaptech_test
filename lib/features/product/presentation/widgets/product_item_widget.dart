import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/product_entity.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key, required this.productItemEntity});

  final ProductItemEntity? productItemEntity;

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
              context.push("/productDetailView", extra: productItemEntity);
            },
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
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              (productItemEntity?.stock ?? 0) > 0 ? "In Stock" : "Out of Stock",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ],
    );
  }
}
