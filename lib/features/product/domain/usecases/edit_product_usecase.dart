import '../repositories/product_repository.dart';

class EditProductUseCase {
  final ProductRepository repository;

  EditProductUseCase(this.repository);

  Future<int> call({required int productId, required String title}) async {
    return repository.editProduct(productId: productId, title: title);
  }
}
