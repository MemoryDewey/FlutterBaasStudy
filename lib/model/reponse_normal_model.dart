/// response只包含code和msg的model
class ResponseNormalModel {
  String msg;
  int code;

  ResponseNormalModel({this.msg, this.code});

  factory ResponseNormalModel.fromJson(Map<String, dynamic> json) {
    return ResponseNormalModel(
      msg: json['msg'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['code'] = this.code;
    return data;
  }
}
