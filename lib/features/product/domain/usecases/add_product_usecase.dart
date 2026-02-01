import '../repositories/product_repository.dart';

class AddProductUseCase {
  final ProductRepository repository;

  AddProductUseCase(this.repository);

  Future<int> call({
    required String title,
    required num price,
    required num quantity,
  }) async {
    return repository.addProduct(
      title: title,
      price: price,
      quantity: quantity,
    );
  }
}
