class RequestErrorModel {
  String msg;
  int code;

  RequestErrorModel({this.msg, this.code});

  factory RequestErrorModel.fromJson(Map<String, dynamic> json) {
    return RequestErrorModel(
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
