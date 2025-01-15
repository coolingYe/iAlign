import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ialign/base/config/base_config.dart';
import 'package:ialign/base/net/net_client_adapter.dart';
import 'package:ialign/base/net/pretty_dio_logger.dart';
import 'package:ialign/base/protocol/response/base_resp.dart';
import 'package:logger/logger.dart';

import '../utils/log_util.dart';

class DioAdapter extends NetClientAdapter {

  final Logger logger = LogUtil().logger;

  DioAdapter(){
    DioUtil();
  }

  @override
  Future<BaseResp<T>> requestBase<T>(String method, String path, {data, Map<String, dynamic>? params}) async {
    DioUtil.dio.options.method = method;
    DioUtil.dio.options.baseUrl = BaseConfig.request_url;

    try {
      Response response = await DioUtil.dio.request(path, data: data, queryParameters: params);
      return BaseResp.fromJson(response.data);
    }on DioException catch(err){
      logger.e("request error1: $err");
      if (err.type == DioExceptionType.connectionTimeout || err.type == DioExceptionType.sendTimeout || err.type == DioExceptionType.receiveTimeout) {
        throw TimeoutException("网络超时！");
      } else if (err.type == DioExceptionType.badCertificate) {
        throw AppException(message: "错误证书！");
      } else if (err.type == DioExceptionType.cancel) {
        throw AppException(message: "连接被取消！");
      } else if (err.type == DioExceptionType.connectionError) {
        throw NetworkException("网络异常！");
      } else {
        throw NetworkException("网络异常！");
      }
    }catch(err){
      logger.e("request error2: $err");
      if (err is BaseException) {
        rethrow;
      }
      throw AppException(message: err.toString());
    }
  }

}

class DioUtil{
  static final DioUtil _singleton = DioUtil._init();
  static late Dio dio;
  factory DioUtil() {
    return _singleton;
  }
  DioUtil._init(){
    dio = Dio(_getDefaultOption());
    dio.interceptors.add(TokenInterceptor());
    dio.interceptors.add(PrettyDioLogger(requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }

  static BaseOptions _getDefaultOption(){
    BaseOptions options = BaseOptions();
    options.contentType = Headers.jsonContentType;
    options.connectTimeout = const Duration(seconds: 10);
    options.receiveTimeout = const Duration(seconds: 10);
    options.baseUrl = BaseConfig.request_url;
    return options;
  }
}

class TokenInterceptor extends Interceptor{

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //options.headers["authorization"] = BaseConf.token;
    options.headers["Content-type"] = 'application/json';

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null && err.response!.statusCode == 401) {
      ///todo 401
    }
    super.onError(err, handler);
  }
}

class NetworkException extends BaseException {
  NetworkException(String message) : super(message: message);
}

class ApiException extends BaseApiException {
  ApiException({
    required super.httpCode,
    required super.status,
    super.message,
  });
}

class AppException extends BaseException {
  AppException({
    super.message,
  });
}

abstract class BaseApiException extends AppException {
  final int httpCode;
  final String status;

  BaseApiException({this.httpCode = -1, this.status = "", super.message});
}

abstract class BaseException implements Exception {
  final String message;

  BaseException({this.message = ""});
}