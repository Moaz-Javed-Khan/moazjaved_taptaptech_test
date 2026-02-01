import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moazjaved_taptaptech_test/features/product/presentation/blocs/cubit/product_cubit.dart';

import '../../widgets/custom_dialog.dart';
import '../../widgets/product_item_widget.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                "Products",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 260,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Search by category',
                    hintText: 'Enter product category',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChanged: (val) {
                    context.read<ProductCubit>().onSearchChange(val);
                  },
                ),
              ),
              const SizedBox(width: 10),

              TextButton(
                onPressed: () {
                  context.read<ProductCubit>().getProductsByCategory();
                },
                child: Text("Search"),
              ),

              const SizedBox(width: 20),

              TextButton(
                onPressed: () {
                  context.read<ProductCubit>().getProducts();
                },
                child: Text("Clear Search"),
              ),

              const SizedBox(width: 10),

              addProduct(context),
            ],
          ),
          SizedBox(height: 8),
          productCard(context),
        ],
      ),
    );
  }

  Widget addProduct(BuildContext context) {
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
                content: Text("Product not added"),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state.addProductStatus == AddProductStatus.loaded) {
            context.pop();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Product added successfully 🎉, ID: ${state.newProductid}",
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
                    title: "Add Product",
                    icon: Icon(Icons.add_box_rounded, size: 35),
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

                              // Price
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Price',
                                  hintText: 'Enter product price',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                onChanged: (val) {
                                  final price = double.tryParse(val) ?? 0;
                                  cubit.onPriceChange(price);
                                },
                                validator: (val) {
                                  final price = double.tryParse(val ?? '');
                                  if (price == null || price <= 0) {
                                    return 'Enter a valid price';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 8),

                              // Quantity
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Quantity',
                                  hintText: 'Enter product quantity',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (val) {
                                  final qty = int.tryParse(val) ?? 0;
                                  cubit.onQuantityChange(qty);
                                },
                                validator: (val) {
                                  final qty = int.tryParse(val ?? '');
                                  if (qty == null || qty <= 0) {
                                    return 'Enter a valid quantity';
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
                                  ? Center(child: CircularProgressIndicator())
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
                                                color: Colors.red,
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
                                                cubit.addProduct();
                                              } else {
                                                return;
                                              }
                                            },
                                            child: Text(
                                              "Yes",
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.green,
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
            child: Text("Add Product"),
          );
        },
      ),
    );
  }

  Widget productCard(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [cardHeader(context), const Divider(), productList()],
        ),
      ),
    );
  }

  Widget productList() {
    return BlocBuilder<ProductCubit, ProductState>(
      buildWhen: (previous, current) =>
          previous.getProductStatus != current.getProductStatus,
      builder: (context, state) {
        if (state.getProductStatus == GetProductsStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.getProductStatus == GetProductsStatus.failure) {
          return const Text("Something went wrong!");
        } else if (state.getProductStatus == GetProductsStatus.loaded) {
          return ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount:
                (state.productModel?.products ?? []).isEmpty ||
                    state.productModel?.products == null
                ? 1
                : state.productModel!.products.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) =>
                (state.productModel?.products ?? []).isEmpty ||
                    state.productModel?.products == null
                ? Text("No Product Found!!")
                : ProductItemWidget(
                    productItemEntity: state.productModel?.products[index],
                  ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget cardHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            "ID",
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            "Name",
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            "Category",
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "Price",
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            "Stock Status",
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
