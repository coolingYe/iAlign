

import 'package:ialign/base/net/net_client.dart';
import 'package:ialign/base/protocol/response/base_resp.dart';

import 'data_repository.dart';

class DataRepositoryImpl implements DataRepository {

  @override
  Future<BaseResp> requestOCR(String authorization, String host, String date, Map<String, dynamic> req) {
    return NetClient().requestBase(Method.post, '?authorization=$authorization&host=$host&date=$date', data: req);
  }

}