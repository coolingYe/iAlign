
import 'package:dio/dio.dart';

import '../protocol/response/base_resp.dart';
import 'dio_adapter.dart';
import 'net_client_adapter.dart';

class NetClient{
  factory NetClient() =>_getInstance();
  static  NetClient? _instance;
  NetClient._();
  static NetClient _getInstance() {
    _instance ??= NetClient._();
    return _instance!;
  }

  NetClientAdapter? netAdapter;

  Future<BaseResp<T>> requestBase<T>(String method, String path, {dynamic data, Map<String, dynamic>? params}) {
    netAdapter ??= DioAdapter();
    return netAdapter!.requestBase(method, path, data: data, params: params);
  }
}

class Method{
  static const String get = "GET";
  static const String post = "POST";
  static const String delete = "Delete";
  static const String put = "PUT";
}