import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<ProductEntity> getAllProducts();

  Future<ProductEntity> getProductsCategory({required String category});

  Future<ProductItemEntity> getProductById({required int id});

  Future<int> addProduct({
    required String title,
    required num price,
    required num quantity,
  });

  Future<int> editProduct({required int productId, required String title});
}
