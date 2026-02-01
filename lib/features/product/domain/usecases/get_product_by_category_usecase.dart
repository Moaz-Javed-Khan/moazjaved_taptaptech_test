import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductByCategoryUsecase {
  final ProductRepository repository;

  GetProductByCategoryUsecase(this.repository);

  Future<ProductEntity> call({required String category}) async {
    return repository.getProductsCategory(category: category);
  }
}
