import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/product_entity.dart';
import '../../blocs/cubit/product_cubit.dart';
import '../../widgets/custom_dialog.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state.getProductStatus == GetProductsStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.getProductStatus == GetProductsStatus.failure) {
          return const Center(child: Text("Something went wrong!"));
        } else if (state.getProductStatus == GetProductsStatus.loaded) {
          return Scaffold(
            body: LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 600;
                return OrientationBuilder(
                  builder: (context, orientation) {
                    final useVerticalLayout =
                        isNarrow || orientation == Orientation.portrait;
                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: isNarrow ? 12 : 16,
                        vertical: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            state.productItemEntity?.title ?? "Laptop",
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Card(
                            margin: EdgeInsets.zero,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: useVerticalLayout
                                  ? _verticalContent(
                                      context,
                                      state.productItemEntity,
                                    )
                                  : _horizontalContent(
                                      context,
                                      state.productItemEntity,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _verticalContent(
    BuildContext context,
    ProductItemEntity? productItemEntity,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(
            productItemEntity?.images.isNotEmpty == true
                ? productItemEntity!.images[0]
                : "",
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.image_not_supported, size: 64),
          ),
        ),
        const SizedBox(height: 16),
        _productInfo(context, productItemEntity),
      ],
    );
  }

  Widget _horizontalContent(
    BuildContext context,
    ProductItemEntity? productItemEntity,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Image.network(
            productItemEntity?.images.isNotEmpty == true
                ? productItemEntity!.images[0]
                : "",
            height: 300,
            fit: BoxFit.fitHeight,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.image_not_supported, size: 64),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(flex: 3, child: _productInfo(context, productItemEntity)),
      ],
    );
  }

  Widget _productInfo(
    BuildContext context,
    ProductItemEntity? productItemEntity,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("ID: ${productItemEntity?.id ?? "101"}"),
        Text("Category: ${productItemEntity?.category ?? "Electronics"}"),
        Text("Price: \$${productItemEntity?.price ?? 199}"),
        Text("Description: ${productItemEntity?.description ?? "Description"}"),
        Text((productItemEntity?.stock ?? 0) > 0 ? "In Stock" : "Out of Stock"),
        const Divider(),
        _editProduct(context, productItemEntity),
      ],
    );
  }

  Widget _editProduct(
    BuildContext context,
    ProductItemEntity? productItemEntity,
  ) {
    return BlocProvider.value(
      value: context.read<ProductCubit>(),
      child: BlocConsumer<ProductCubit, ProductState>(
        listenWhen: (previous, current) =>
            previous.addProductStatus != current.addProductStatus,
        listener: (context, state) {
          if (state.addProductStatus == AddProductStatus.loading) {
          } else if (state.addProductStatus == AddProductStatus.failure) {
            context.pop();

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Product edit failed"),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state.addProductStatus == AddProductStatus.loaded) {
            context.pop();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Product edited successfully 🎉, ID: ${state.newProductid}",
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else {}
        },
        buildWhen: (previous, current) =>
            previous.addProductStatus != current.addProductStatus,
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () {
              final cubit = context.read<ProductCubit>();

              GlobalKey<FormState> _formKey = GlobalKey();

              showDialog(
                context: context,
                builder: (context) {
                  return CustomDialog(
                    title: "Edit Product",
                    icon: const Icon(Icons.add_box_rounded, size: 35),
                    singleButton: false,
                    subTitle: "Fill information to add the product",
                    actions: [
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              // Title
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Title',
                                  hintText: 'Enter product title',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.text,
                                onChanged: (val) => cubit.onTitleChange(val),
                                validator: (val) {
                                  if (val == null || val.trim().isEmpty) {
                                    return 'Title is required';
                                  }
                                  if (val.length < 3) {
                                    return 'Title must be at least 3 characters';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 8),

                              const Divider(
                                height: 1,
                                thickness: 0.5,
                                color: Colors.grey,
                              ),
                              state.addProductStatus == AddProductStatus.loading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: TextButton(
                                            onPressed: context.pop,
                                            child: Text(
                                              "No",
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.red.shade700,
                                              ),
                                            ),
                                          ),
                                        ),

                                        Container(
                                          height: 24,
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                cubit.editProduct(
                                                  productId:
                                                      productItemEntity?.id ??
                                                      0,
                                                );
                                              } else {
                                                return;
                                              }
                                            },
                                            child: Text(
                                              "Yes",
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.green.shade700,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            child: const Text("Edit Product"),
          );
        },
      ),
    );
  }
}
