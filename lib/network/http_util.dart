import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:application/common/api.dart';

class HttpUtil {
  static HttpUtil? instance;
  Dio? dio;
  BaseOptions? options;

  CancelToken cancelToken = CancelToken();

  static HttpUtil getHttpUtil(){
    instance ??= HttpUtil();
    return instance!;
  }

  HttpUtil(){
    options = BaseOptions(
      baseUrl: Api.BASE_URL,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 5),
      headers: {

      },
      //请求的Content-Type，默认值是"application/json; charset=utf-8",Headers.formUrlEncodedContentType会自动编码请求体.
      contentType: Headers.formUrlEncodedContentType,
      //表示期望以那种格式(方式)接受响应数据。接受四种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
      responseType: ResponseType.plain,
    );

    dio = Dio(options);

    //Cookie管理 // First request, and save cookies (CookieManager do it). but 好像没生效嘛...
    final cookieJar = CookieJar();
    dio?.interceptors.add(CookieManager(cookieJar));

    //添加拦截器
    dio?.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options, RequestInterceptorHandler handler) {

      print("请求路径: ${options.path}");
      print("请求之前 header = ${options.headers.toString()}");
      // 如果你想完成请求并返回一些自定义数据，你可以使用 `handler.resolve(response)`。
      // 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。
      return handler.next(options); //continue
    }, onResponse: (Response response, ResponseInterceptorHandler handler) {
      print("响应之前");
      // 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。
      return handler.next(response); // continue
    }, onError: (DioError e, ErrorInterceptorHandler handler) {
      print("错误之前");
      // 如果你想完成请求并返回一些自定义数据，你可以使用 `handler.resolve(response)`。
      return handler.next(e);
    }));
  }

  /*
   * get请求
   */
//   get(url, {data, options, cancelToken}) async {
//     Response? response;
//     try {
//       response = await dio?.get(url, queryParameters: data, options: options, cancelToken: cancelToken);
//       print('get success---------${response?.statusCode}');
//       print('get success---------${response?.data}');
//
// //      response.data; 响应体
// //      response.headers; 响应头
// //      response.request; 请求体
// //      response.statusCode; 状态码
//     } on DioError catch (e) {
//       print('get error---------$e');
//       formatError(e);
//     }
//     return response;
//   }

  get(String path, {Map<String, dynamic>? data, Options? options, CancelToken? cancelToken}) async {
    Response? response;
    try {
      // 替换路径中的可替代部分
      String url = path.replaceAll("{page_size}", data?["page_size"] ?? "0"); // 如果没有提供 "page_size" 参数，则使用空字符串替代
      response = await dio?.get(url, queryParameters: data, options: options, cancelToken: cancelToken);
      print('get success---------${response?.statusCode}');
      print('get success---------${response?.data}');
    } on DioError catch (e) {
      print('get error---------$e');
      formatError(e);
    }
    return response;
  }


  /*
   * post请求
   */
  post(url, {data, options, cancelToken}) async {
    Response? response;
    try {
      response = await dio?.post(url, queryParameters: data, options: options, cancelToken: cancelToken);
      print('post success---------${response?.data}');
    } on DioError catch (e) {
      print('post error---------$e');
      formatError(e);
    }
    return response;
  }

  /*
   * 下载文件
   */
  downloadFile(urlPath, savePath) async {
    Response? response;
    try {
      response = await dio?.download(urlPath, savePath, onReceiveProgress: (int count, int total) {
        //进度
        print("$count $total");
      });
      print('downloadFile success---------${response?.data}');
    } on DioError catch (e) {
      print('downloadFile error---------$e');
      formatError(e);
    }
    return response?.data;
  }

  /*
   * error统一处理
   */
  void formatError(DioError e) {
    if (e.type == DioErrorType.connectionTimeout) {
      // It occurs when url is opened timeout.
      print("连接超时");
    } else if (e.type == DioErrorType.sendTimeout) {
      // It occurs when url is sent timeout.
      print("请求超时");
    } else if (e.type == DioErrorType.receiveTimeout) {
      //It occurs when receiving timeout
      print("响应超时");
    } else if (e.type == DioErrorType.badResponse) {
      // When the server response, but with a incorrect status, such as 404, 503...
      print("出现异常");
    } else if (e.type == DioErrorType.cancel) {
      // When the request is cancelled, dio will throw a error with this type.
      print("请求取消");
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      print("未知错误");
    }
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }
}