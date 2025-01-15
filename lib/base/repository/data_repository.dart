
import '../protocol/response/base_resp.dart';

abstract class DataRepository {

  Future<BaseResp> requestOCR(String authorization, String host, String date, Map<String, dynamic> req);

}
