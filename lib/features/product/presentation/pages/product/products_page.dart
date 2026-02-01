import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasources/product_remote_data_source.dart';
import '../../../data/repositories/product_repository_impl.dart';
import '../../../domain/usecases/add_product_usecase.dart';
import '../../../domain/usecases/edit_product_usecase.dart';
import '../../../domain/usecases/get_product_by_category_usecase.dart';
import '../../../domain/usecases/get_products_usecase.dart';
import '../../blocs/cubit/product_cubit.dart';
import 'products_view.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      )..getProducts(),
      child: ProductsView(),
    );
  }
}
