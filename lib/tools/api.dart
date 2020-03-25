import 'package:dio/dio.dart';

class DioHelper {
  static String host = "localhost:8080/api";
  Dio dio;
  DioHelper() {
    dio = Dio(
      BaseOptions(baseUrl: host, connectTimeout:500000, receiveTimeout: 3000000 )
    );
  }
}