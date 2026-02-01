part of 'product_cubit.dart';

enum GetProductsStatus { initial, loading, loaded, failure }

enum AddProductStatus { initial, loading, loaded, failure }

class ProductState extends Equatable {
  final GetProductsStatus getProductStatus;
  final AddProductStatus addProductStatus;
  final ProductEntity? productModel;

  final String searchedCategory;

  final String title;
  final num price;
  final num quantity;
  final int? newProductid;

  const ProductState({
    this.getProductStatus = GetProductsStatus.initial,
    this.addProductStatus = AddProductStatus.initial,
    this.productModel,
    this.searchedCategory = "",
    this.title = "",
    this.price = 0,
    this.quantity = 0,
    this.newProductid,
  });

  ProductState copyWith({
    GetProductsStatus? getProductStatus,
    AddProductStatus? addProductStatus,
    ProductEntity? productModel,

    String? searchedCategory,

    String? title,
    num? price,
    num? quantity,
    int? newProductid,
  }) {
    return ProductState(
      getProductStatus: getProductStatus ?? this.getProductStatus,
      addProductStatus: addProductStatus ?? this.addProductStatus,
      productModel: productModel ?? this.productModel,
      searchedCategory: searchedCategory ?? this.searchedCategory,
      title: title ?? this.title,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      newProductid: newProductid ?? this.newProductid,
    );
  }

  @override
  List<Object?> get props => [
    getProductStatus,
    addProductStatus,
    productModel,

    searchedCategory,

    title,
    price,
    quantity,
    newProductid,
  ];
}
