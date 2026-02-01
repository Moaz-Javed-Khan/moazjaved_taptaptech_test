import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ProductEntity> getAllProducts() async {
    return remoteDataSource.getAllProducts();
  }

  @override
  Future<int> addProduct({
    required String title,
    required num price,
    required num quantity,
  }) {
    return remoteDataSource.addProduct(
      title: title,
      price: price,
      quantity: quantity,
    );
  }

  @override
  Future<ProductEntity> getProductsCategory({required String category}) {
    return remoteDataSource.getProductsCategory(category: category);
  }

  @override
  Future<int> editProduct({required int productId, required String title}) {
    return remoteDataSource.editProduct(productId: productId, title: title);
  }
}
