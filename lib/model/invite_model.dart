class InviteResultModel {
  int code;
  List<InviteListModel> invites;
  int pageSum;
  int count;

  InviteResultModel({this.code, this.invites, this.pageSum, this.count});

  factory InviteResultModel.fromJson(Map<String, dynamic> json) {
    List invites = new List<InviteListModel>();
    if (json['invites'] != null) {
      json['invites'].forEach((v) {
        invites.add(new InviteListModel.fromJson(v));
      });
    }
    return InviteResultModel(
      code: json['code'],
      invites: invites,
      pageSum: json['pageSum'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.invites != null) {
      data['invites'] = this.invites.map((v) => v.toJson()).toList();
    }
    data['pageSum'] = this.pageSum;
    data['count'] = this.count;
    return data;
  }
}

class InviteListModel {
  int id;
  String nickname;
  String phone;
  String time;

  InviteListModel({this.id, this.nickname, this.phone, this.time});

  factory InviteListModel.fromJson(Map<String, dynamic> json) {
    return InviteListModel(
      id: json['id'],
      nickname: json['nickname'],
      phone: json['phone'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nickname'] = this.nickname;
    data['phone'] = this.phone;
    data['time'] = this.time;
    return data;
  }
}

class InviteCodeModel {
  int code;
  String inviteCode;
  String inviteUrl;

  InviteCodeModel({this.code, this.inviteCode, this.inviteUrl});

  factory InviteCodeModel.fromJson(Map<String, dynamic> json) {
    return InviteCodeModel(
      code: json['code'],
      inviteCode: json['inviteCode'],
      inviteUrl: json['inviteUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['inviteCode'] = this.inviteCode;
    data['inviteUrl'] = this.inviteUrl;
    return data;
  }
}
