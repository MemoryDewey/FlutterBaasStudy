class PswLoginModel {
  int code;
  String token;
  String msg;

  PswLoginModel({this.code, this.token, this.msg});

  factory PswLoginModel.fromJson(Map<String, dynamic> json) {
    return PswLoginModel(
      code: json['code'],
      token: json['token'],
      msg: json['msg'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['token'] = this.token;
    data['msg'] = this.msg;
    return data;
  }
}
