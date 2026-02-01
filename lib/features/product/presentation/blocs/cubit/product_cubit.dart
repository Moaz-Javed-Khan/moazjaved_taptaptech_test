import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/product_entity.dart';
import '../../../domain/usecases/add_product_usecase.dart';
import '../../../domain/usecases/edit_product_usecase.dart';
import '../../../domain/usecases/get_product_by_category_usecase.dart';
import '../../../domain/usecases/get_products_usecase.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductsUseCase getProductsUseCase;
  final GetProductByCategoryUsecase getProductByCategoryUsecase;
  final AddProductUseCase addProductUseCase;
  final EditProductUseCase editProductUseCase;

  ProductCubit({
    required this.getProductsUseCase,
    required this.getProductByCategoryUsecase,
    required this.addProductUseCase,
    required this.editProductUseCase,
  }) : super(ProductState());

  Future<void> getProducts() async {
    try {
      emit(state.copyWith(getProductStatus: GetProductsStatus.loading));

      final products = await getProductsUseCase();

      emit(
        state.copyWith(
          getProductStatus: GetProductsStatus.loaded,
          productModel: products,
        ),
      );
    } catch (e) {
      emit(state.copyWith(getProductStatus: GetProductsStatus.failure));
    }
  }

  Future<void> getProductsByCategory() async {
    try {
      emit(state.copyWith(getProductStatus: GetProductsStatus.loading));

      final products = await getProductByCategoryUsecase(
        category: state.searchedCategory,
      );

      emit(
        state.copyWith(
          getProductStatus: GetProductsStatus.loaded,
          productModel: products,
        ),
      );
    } catch (e) {
      emit(state.copyWith(getProductStatus: GetProductsStatus.failure));
    }
  }

  Future<void> addProduct() async {
    try {
      emit(state.copyWith(addProductStatus: AddProductStatus.loading));

      final id = await addProductUseCase(
        title: state.title,
        price: state.price,
        quantity: state.quantity,
      );

      emit(
        state.copyWith(
          addProductStatus: AddProductStatus.loaded,
          newProductid: id,
        ),
      );
      getProducts();
    } catch (e) {
      emit(state.copyWith(addProductStatus: AddProductStatus.failure));
    }
  }

  Future<void> editProduct({required int productId}) async {
    // try {
    emit(state.copyWith(addProductStatus: AddProductStatus.loading));

    final id = await editProductUseCase(
      title: state.title,
      productId: productId,
    );

    emit(
      state.copyWith(
        addProductStatus: AddProductStatus.loaded,
        newProductid: id,
      ),
    );
    getProducts();
    // } catch (e) {
    //   emit(state.copyWith(addProductStatus: AddProductStatus.failure));
    // }
  }

  void onSearchChange(String val) {
    emit(state.copyWith(searchedCategory: val));
  }

  void onTitleChange(String val) {
    emit(state.copyWith(title: val));
  }

  void onPriceChange(num val) {
    emit(state.copyWith(price: val));
  }

  void onQuantityChange(num val) {
    emit(state.copyWith(quantity: val));
  }
}
