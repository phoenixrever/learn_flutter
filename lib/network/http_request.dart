import 'package:dio/dio.dart';

class HttpRequest {
  ///全局配置
  static BaseOptions baseOptions = BaseOptions(
    baseUrl: "http://39.105.38.10:8081/book",
    connectTimeout: 5000,
  );

  static final dio = Dio(baseOptions);

  static Future request(
    String url, {
    String http_method = "get",
    Map<String, dynamic>? params,
  }) async {
    final options = Options(
      method: http_method,
    );
    final result;

    try {
      result =
          await dio.request(url, queryParameters: params, options: options);
    } on DioError catch (err) {
      print(err);
      throw err;
    }
    return result;
  }

  static Future<List> requestAll(
    List<String> urls, {
    String http_method = "get",
    Map<String, dynamic>? params,
  }) async {
    final options = Options(
      method: http_method,
    );
    final result;
    List<Future> list = [];

    urls.forEach((u) {
      list.add(dio.request(u, queryParameters: params, options: options));
    });

    try {
      result = await Future.wait(list);
    } on DioError catch (err) {
      print(err);
      throw err;
    }
    return result;
  }
}
