import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttersearchcaep/repositories/back4app/back4app_dio_interceptor.dart';

class Back4appCustonDio {
  final _dio = Dio();

  Dio get dio => _dio;

  Back4appCustonDio() {
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("BACK4APPBASEURL");
    _dio.interceptors.add(Back4appDioInterceptor());
  }
}
