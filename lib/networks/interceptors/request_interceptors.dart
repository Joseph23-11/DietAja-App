import 'dart:async';

import 'package:get/get_connect/http/src/request/request.dart';

FutureOr<Request> requestInterceptor(Request request) async {
  print('requestInterceptor START /////////////////');
  print('               Method: ${request.method}');
  print('               Url: ${request.url}');
  print('               Headers: ${request.headers}');
  print('requestInterceptor END /////////////////');

  return request;
}
