class OCR {
  Header? header;
  Payload? payload;

  OCR.fromJson(Map<String, dynamic> json) :
        header = json['header'] != null
            ? Header.fromJson(json['header']) : null,
        payload = json['payload'] != null
            ? Payload.fromJson(json['payload']) : null;
}

class Header {
  int? code;
  String? message;
  String? sid;

  Header.fromJson(Map<String, dynamic> json) :
      code = json['code'],
      message = json['message'],
      sid = json['sid'];
}

class Payload {
  Result? result;

  Payload.fromJson(Map<String, dynamic> json) :
        result = json['result'] != null
            ? Result.fromJson(json['result']) : null;
}

class Result {
  String? compress;
  String? encoding;
  String? format;
  String? text;

  Result.fromJson(Map<String, dynamic> json) :
        compress = json['compress'],
        encoding = json['encoding'],
        format = json['format'],
        text = json['text'];
}