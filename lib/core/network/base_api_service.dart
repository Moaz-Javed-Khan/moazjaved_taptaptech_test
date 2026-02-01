abstract class BaseApiService {
  Future<dynamic> getApi({
    required String endPoints,
    Map<String, dynamic>? queryParameter,
    bool isAuthorize = false,
    headers,
  });
  Future<dynamic> postApi({
    required String endPoints,
    required Map<String, dynamic> payload,
    Map<String, dynamic>? queryParams,
    bool isAuthorize = false,
    headers,
  });
  Future<dynamic> patchApi({
    required String endPoints,
    required Map<String, dynamic> payload,
    Map<String, dynamic>? queryParams,
    bool isAuthorize = false,
    headers,
  });
  Future<dynamic> putApi({
    required String endPoints,
    required dynamic payload,
    Map<String, dynamic>? queryParams,
    bool isAuthorize = false,
    headers,
  });
  Future<dynamic> deleteApi({
    required String endPoints,
    Map<String, dynamic>? payload,
    Map<String, dynamic>? queryParams,
    bool isAuthorize = false,
    headers,
  });
}
