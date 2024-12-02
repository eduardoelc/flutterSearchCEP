import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttersearchcaep/repositories/viacep/via_cep_dio_interceptor.dart';

class ViaCepCustonDio {
  final _dio = Dio();

  Dio get dio => _dio;

  Back4appCustonDio() {
    // _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("VIACEPBASEURL");
    _dio.interceptors.add(ViaCepDioInterceptor());
  }
}
