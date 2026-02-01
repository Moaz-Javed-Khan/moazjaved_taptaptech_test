import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

void _printInterceptorBox({
  required String method,
  required String url,
  // required String headers,
  required String body,
}) {
  const int boxWidth = 100;
  String border = '#' * boxWidth;

  void printRow(String key, String value) {
    String line = '$key: $value';
    int padding = boxWidth - 4 - line.length;
    if (padding < 0) {
      padding = 0; // Prevents overflow
    }
    debugPrint('# $line${' ' * padding} #');
  }

  debugPrint('\n$border');
  debugPrint('#${' ' * (boxWidth - 2)}#'); // Top padding
  printRow('Method', method);
  printRow('URL', url);
  // printRow('Headers', headers);
  printRow('Body', body);
  debugPrint('#${' ' * (boxWidth - 2)}#'); // Bottom padding
  debugPrint(border);
}

class AuthInterceptor extends Interceptor {
  final Function onTokenBlacklisted;

  AuthInterceptor({required this.onTokenBlacklisted});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    _printInterceptorBox(
      method: options.method,
      url: "${options.uri}",
      // headers: "${options.headers}",
      body: "${options.data}",
    );
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 401 &&
            response.data['message'] == 'Invalid or expired token provided' ||
        response.data['message'] == 'Unauthorized - Please relogin' ||
        response.data['message'] == 'No such User found - Access denied') {
      onTokenBlacklisted();
    }
    debugPrint("RESPONSE:::::::${response.data}");
    log("RESPONSE:::::::${response.data}");

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401 &&
            err.response?.data['message'] ==
                'Invalid or expired token provided' ||
        err.response?.data['message'] == 'Unauthorized - Please relogin' ||
        err.response?.data['message'] == 'No such User found - Access denied') {
      onTokenBlacklisted();
    }
    debugPrint("ERROR:::::::${err.response}");
    super.onError(err, handler);
  }
}
