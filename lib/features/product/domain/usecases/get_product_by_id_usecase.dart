import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductByIdUseCase {
  final ProductRepository repository;

  GetProductByIdUseCase(this.repository);

  Future<ProductItemEntity> call({required int id}) async {
    return repository.getProductById(id: id);
  }
}
