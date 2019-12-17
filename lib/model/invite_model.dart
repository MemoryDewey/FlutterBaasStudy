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
  String inviteTime;
  int id;
  int userID;
  int inviteUserID;
  InviteUserModel invitedUser;

  InviteListModel({
    this.inviteTime,
    this.id,
    this.userID,
    this.inviteUserID,
    this.invitedUser,
  });

  factory InviteListModel.fromJson(Map<String, dynamic> json) {
    return InviteListModel(
      inviteTime: json['createdAt'],
      id: json['id'],
      userID: json['userID'],
      inviteUserID: json['inviteUserID'],
      invitedUser: json['Invited'] != null
          ? new InviteUserModel.fromJson(json['Invited'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.inviteTime;
    data['id'] = this.id;
    data['userID'] = this.userID;
    data['inviteUserID'] = this.inviteUserID;
    if (this.invitedUser != null) {
      data['Invited'] = this.invitedUser.toJson();
    }
    return data;
  }
}

class InviteUserModel {
  int userID;
  String nickname;
  String phone;

  InviteUserModel({this.userID, this.nickname, this.phone});

  factory InviteUserModel.fromJson(Map<String, dynamic> json) {
    return InviteUserModel(
      userID: json['userID'],
      nickname: json['nickname'],
      phone:
          json['UserPassport'] != null ? json['UserPassport']['phone'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['nickname'] = this.nickname;
    data['phone'] = this.phone;
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
