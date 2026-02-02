import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../data/datasources/product_remote_data_source.dart';
import '../../../data/repositories/product_repository_impl.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/usecases/add_product_usecase.dart';
import '../../../domain/usecases/edit_product_usecase.dart';
import '../../../domain/usecases/get_product_by_category_usecase.dart';
import '../../../domain/usecases/get_product_by_id_usecase.dart';
import '../../../domain/usecases/get_products_usecase.dart';
import '../../blocs/cubit/product_cubit.dart';
import 'product_detail_view.dart';

class ProductsDetailPage extends StatelessWidget {
  const ProductsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductItemEntity? productItemEntity =
        GoRouterState.of(context).extra as ProductItemEntity?;

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

        getProductByIdUseCase: GetProductByIdUseCase(
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
      )..getProductById(id: productItemEntity?.id ?? 0),
      child: ProductDetailView(),
    );
  }
}
