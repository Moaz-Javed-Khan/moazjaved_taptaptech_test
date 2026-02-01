import 'dart:developer';

import '../../../../core/network/network_api_service.dart';
import '../../domain/entities/product_entity.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductEntity> getAllProducts();

  Future<ProductEntity> getProductsCategory({required String category});

  Future<int> addProduct({
    required String title,
    required num price,
    required num quantity,
  });

  Future<int> editProduct({required int productId, required String title});
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  static final NetworkApiService _apiService = NetworkApiService.instance;

  @override
  Future<ProductEntity> getAllProducts() async {
    final res = await _apiService.getApi(endPoints: "products");

    final model = ProductModel.fromJson(res);

    return model.toEntity();
  }

  @override
  Future<ProductEntity> getProductsCategory({required String category}) async {
    final res = await _apiService.getApi(
      endPoints: "products/category/$category",
    );

    final model = ProductModel.fromJson(res);

    return model.toEntity();
  }

  @override
  Future<int> addProduct({
    required String title,
    required num price,
    required num quantity,
  }) async {
    var payload = {"title": title, "price": price, "quantity": quantity};

    final res = await _apiService.postApi(
      endPoints: "products/add",
      payload: payload,
    );

    return res["id"];
  }

  @override
  Future<int> editProduct({
    required int productId,
    required String title,
  }) async {
    var payload = {"title": title};

    final res = await _apiService.putApi(
      endPoints: "products/$productId",
      payload: payload,
    );

    log(res.toString());

    return res["id"];
  }
}
