import 'package:dio/dio.dart';

class DioUtil {
  static final String BASE_URL = "http://101.132.159.78:8080/flutter_book_backend-1.0.1-SNAPSHOT/api";  //base url
  static DioUtil _instance;
  
    Dio _dio; 
    BaseOptions _baseOptions;
    //单例模式
    static DioUtil getInstance() {
      if(_instance == null) {
        _instance = new DioUtil();
      }
      return _instance;   
    }
  
    /**
     * 初始化
     */
    DioUtil() {
      _baseOptions = new BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: 5000,
        receiveTimeout: 5000,
        headers: {
          "testHeader": "flutter_book"
        },
        responseType: ResponseType.json,
      );

      //创建dio实例
      _dio = new Dio(_baseOptions);

    //   _dio.interceptors.add(
    //   InterceptorsWrapper(onRequest: (RequestOptions requestions) async {
    //     //此处可网络请求之前做相关配置，比如会所有请求添加token，或者userId
    //     requestions.queryParameters["token"] = "testtoken123443423";
    //     requestions.queryParameters["userId"] = "123456";
    //     print('-----请求参数--'+requestions.queryParameters.toString());
    //     return requestions;
    //   }, onResponse: (Response response) {
    //     //此处拦截工作在数据返回之后，可在此对dio请求的数据做二次封装或者转实体类等相关操作
    //     return response;
    //   }, onError: (DioError error) {
    //     //处理错误请求
    //     return error;
    //   }),
    // );
  }

  post(url, {data, options}) async{
      Response response;
      try{
        response = await _dio.post(url, data: data, options: options);
      } on DioError catch(e) {
        print('请求失败---错误类型${e.request.data.toString()}--错误信息${e.request.uri}');
      }

      return response;
  }

  get(url, {data, options}) async{
    Response response;
    try{
      response = await _dio.get(url, options: options);
    } on DioError catch(e) {
     print('请求失败---错误类型${e.type}--错误信息${e.message}--${e.request.uri}');
    }
    return response;
  }
  
}


    