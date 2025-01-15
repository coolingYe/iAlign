import '../protocol/response/base_resp.dart';

abstract class NetClientAdapter {
  Future<BaseResp<T>> requestBase<T>(String method, String path, {dynamic data, Map<String, dynamic>? params});
}