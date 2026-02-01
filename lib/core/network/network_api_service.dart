import 'package:dio/dio.dart';

import '../constants.dart';
import 'base_api_service.dart';

class NetworkApiService implements BaseApiService {
  NetworkApiService._();

  static final NetworkApiService instance = NetworkApiService._();

  /// DummyJSON base URL
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    ),
  );

  // ================= GET =================
  @override
  Future<dynamic> getApi({
    required String endPoints,
    Map<String, dynamic>? queryParameter,
    bool isAuthorize = false,
    headers,
  }) async {
    final response = await _dio.get(
      endPoints,
      queryParameters: queryParameter,
      options: Options(headers: headers),
    );

    return response.data;
  }

  // ================= POST =================
  @override
  Future<dynamic> postApi({
    required String endPoints,
    required Map<String, dynamic> payload,
    Map<String, dynamic>? queryParams,
    bool isAuthorize = false,
    headers,
  }) async {
    final response = await _dio.post(
      endPoints,
      data: payload,
      queryParameters: queryParams,
      options: Options(headers: headers),
    );

    return response.data;
  }

  // ================= PUT =================
  @override
  Future<dynamic> putApi({
    required String endPoints,
    required dynamic payload,
    Map<String, dynamic>? queryParams,
    bool isAuthorize = false,
    headers,
  }) async {
    final response = await _dio.put(
      endPoints,
      data: payload,
      queryParameters: queryParams,
      options: Options(headers: headers),
    );

    return response.data;
  }

  // ================= PATCH =================
  @override
  Future<dynamic> patchApi({
    required String endPoints,
    required Map<String, dynamic> payload,
    Map<String, dynamic>? queryParams,
    bool isAuthorize = false,
    headers,
  }) async {
    final response = await _dio.patch(
      endPoints,
      data: payload,
      queryParameters: queryParams,
      options: Options(headers: headers),
    );

    return response.data;
  }

  // ================= DELETE =================
  @override
  Future<dynamic> deleteApi({
    required String endPoints,
    Map<String, dynamic>? payload,
    Map<String, dynamic>? queryParams,
    bool isAuthorize = false,
    headers,
  }) async {
    final response = await _dio.delete(
      endPoints,
      data: payload,
      queryParameters: queryParams,
      options: Options(headers: headers),
    );

    return response.data;
  }
}
