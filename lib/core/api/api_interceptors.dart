import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // headers
    options.headers['accept'] = '*/*';
    super.onRequest(options, handler);
  }
}
  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) {
  //   debugPrint("response : ${response.data}");
  //   super.onResponse(response, handler);
  // }

  // @override
  // void onError(DioException err, ErrorInterceptorHandler handler) {
  //   debugPrint("response : ${err.response!.data}");

  //   super.onError(err, handler);

