import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:ialign/base/config/base_config.dart';
import 'package:ialign/base/protocol/response/base_resp.dart';
import 'package:ialign/base/repository/data_repository.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../base/utils/log_util.dart';

class MainController extends GetxController {
  final Logger logger = LogUtil().logger;
  final DataRepository _dataRepository =
      Get.find(tag: (DataRepository).toString());
  var imagePath = 'images/test.jpg';

  Future<void> requestOCR() async {
    String requestUrl = BaseConfig.request_url;
    String httpRequestUrl = requestUrl
        .replaceAll("ws://", "http://")
        .replaceAll("wss://", "https://");

    Uri uri = Uri.parse(httpRequestUrl);
    var dateFormat = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'", 'en_US');
    String date = dateFormat.format(DateTime.now().toUtc());

    String host = uri.host;

    StringBuffer builder = StringBuffer()
      ..write("host: $host\n")
      ..write("date: $date\n")
      ..write("POST ${uri.path} HTTP/1.1");

    var key = utf8.encode(BaseConfig.api_secret);
    var mac = Hmac(sha256, key);
    var signature = mac.convert(utf8.encode(builder.toString()));

    String sha = base64Encode(signature.bytes);
    String authorization =
        'api_key="${BaseConfig.api_key}", algorithm="hmac-sha256", headers="host date request-line", signature="$sha"';
    Map<String, dynamic> requestData = await getImageData();
    _dataRepository.requestOCR(authorization, host, date, requestData).then(
        (BaseResp resp) async {
      if (resp.isSuccess()) {
        logger.d('requestOCR is success');
      }
    }, onError: (err) {
      logger.e('requestOCR is failed: $err');
    });
  }

  Future<List<int>> readImage(String path) async {
    File file = File(path);
    return await file.readAsBytes();
  }

  Future<Map<String, dynamic>> getImageData() async {
    List<int> imageBytes = await readImage('images/test.jpg');
    String base64Image = base64Encode(imageBytes);

    Map<String, dynamic> req = {};
    Map<String, dynamic> header = {};
    Map<String, dynamic> parameter = {};
    Map<String, dynamic> payload = {};
    Map<String, dynamic> sf8e6aca1_data_1 = {};
    Map<String, dynamic> sf8e6aca1 = {};
    Map<String, dynamic> result = {};
    req['header'] = header;
    req['parameter'] = parameter;
    req['payload'] = payload;
    header['app_id'] = BaseConfig.app_id;
    header['status'] = 3;
    parameter['sf8e6aca1'] = sf8e6aca1;
    sf8e6aca1['category'] = 'ch_en_public_cloud';
    sf8e6aca1['result'] = result;
    result['encoding'] = 'utf8';
    result['compress'] = 'raw';
    result['format'] = 'json';
    payload['sf8e6aca1_data_1'] = sf8e6aca1_data_1;
    sf8e6aca1_data_1['encoding'] = 'jpg';
    sf8e6aca1_data_1['status'] = 3;
    sf8e6aca1_data_1['images'] = base64Image;

    return req;
  }

  Future<String> buildParam(String imagePath) async {
    try {
      // Read the images file and encode it to Base64
      List<int> imageBytes = await readImage(imagePath);
      String base64Image = base64Encode(imageBytes);

      // Construct the JSON parameter
      String param = '''
{
  "header": {
    "app_id": "${BaseConfig.app_id}",
    "status": 3
  },
  "parameter": {
    "sf8e6aca1": {
      "category": "ch_en_public_cloud",
      "result": {
        "encoding": "utf8",
        "compress": "raw",
        "format": "json"
      }
    }
  },
  "payload": {
    "sf8e6aca1_data_1": {
      "encoding": "jpg",
      "status": 3,
      "images": "$base64Image"
    }
  }
}
''';
      return param;
    } catch (e) {
      throw Exception('Error building parameters: $e');
    }
  }
}
