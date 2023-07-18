class ResponseResultToken {
  bool? success;
  String? message;
  Token? data;

  ResponseResultToken({this.success, this.message, this.data});

  ResponseResultToken.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Token.fromJson(json['data']) : null;
  }
}

class Token {
  String? token;

  Token({this.token});

  Token.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }
}
