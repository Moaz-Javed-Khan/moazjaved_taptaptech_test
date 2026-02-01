import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/product_entity.dart';
import '../../blocs/cubit/product_cubit.dart';
import '../../widgets/custom_dialog.dart';

import '../../../data/datasources/product_remote_data_source.dart';
import '../../../data/repositories/product_repository_impl.dart';
import '../../../domain/usecases/add_product_usecase.dart';
import '../../../domain/usecases/edit_product_usecase.dart';
import '../../../domain/usecases/get_product_by_category_usecase.dart';
import '../../../domain/usecases/get_products_usecase.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductItemEntity? productItemEntity =
        GoRouterState.of(context).extra as ProductItemEntity?;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              productItemEntity?.title ?? "Laptop",
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.network(
                        productItemEntity?.images[0] ?? "",
                        height: 300,
                        fit: BoxFit.fitHeight,
                        // loadingBuilder: (context, child, loadingProgress) =>
                        //     CircularProgressIndicator(),
                        // errorBuilder: (context, error, stackTrace) =>
                        //     Icon(Icons.error),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ID: ${productItemEntity?.id ?? "101"}"),
                          Text(
                            "Category: ${productItemEntity?.category ?? "Electronics"}",
                          ),
                          Text("Price: \$${productItemEntity?.price ?? 199}"),
                          Text(
                            "Description: ${productItemEntity?.description ?? "Description"}",
                          ),
                          Text(
                            (productItemEntity?.stock ?? 0) > 0
                                ? "In Stock"
                                : "Out of Stock",
                          ),
                          const Divider(),
                          editProduct(context, productItemEntity),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget editProduct(
    BuildContext context,
    ProductItemEntity? productItemEntity,
  ) {
    return BlocProvider(
      create: (context) => ProductCubit(
        getProductsUseCase: GetProductsUseCase(
          ProductRepositoryImpl(
            remoteDataSource: ProductRemoteDataSourceImpl(),
          ),
        ),

        getProductByCategoryUsecase: GetProductByCategoryUsecase(
          ProductRepositoryImpl(
            remoteDataSource: ProductRemoteDataSourceImpl(),
          ),
        ),

        addProductUseCase: AddProductUseCase(
          ProductRepositoryImpl(
            remoteDataSource: ProductRemoteDataSourceImpl(),
          ),
        ),

        editProductUseCase: EditProductUseCase(
          ProductRepositoryImpl(
            remoteDataSource: ProductRemoteDataSourceImpl(),
          ),
        ),
      ),
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
                    title: "Edit Product",
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
            child: Text("Edit Product"),
          );
        },
      ),
    );
  }
}
