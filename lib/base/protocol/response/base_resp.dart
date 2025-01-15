

class BaseResp<T>{
  int code;
  String message;
  T? data;

  BaseResp(this.code, this.message, this.data);

  BaseResp.fromJson(Map<String, dynamic> json)
      : code=json['code'],
        message=json['message'],
        data=json['data'];

  bool isSuccessWithData(){
    return this.code == 0 && this.data != null;
  }

  bool isSuccess(){
    return this.code == 0;
  }

  @override
  String toString() {
    return 'BaseResp{code: $code, message: $message, data: $data}';
  }
}

class BaseMallResp<T>{
  String code;
  String message;
  T? context;
  bool success;
  Object? errorData;

  BaseMallResp(this.code, this.message, this.context, this.success, this.errorData);

  BaseMallResp.fromJson(Map<String, dynamic> json)
      : code=json['code'],
        message=json['message'],
        context=json['context'],
        success=json['success'],
        errorData=json['errorData'];

  bool isSuccessWithData(){
    return this.code == 'K000000' && this.success && this.context != null;
  }

  bool isSuccess(){
    return this.code == 'K000000' && this.success;
  }

  @override
  String toString() {
    return 'BaseMallResp{code: $code, message: $message, context: $context, success: $success, errorData: $errorData}';
  }
}
