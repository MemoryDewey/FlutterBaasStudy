class ProfileModel {
  int code;
  int level;
  UserModel info;

  ProfileModel({this.code, this.level, this.info});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      code: json['code'],
      level: json['level'],
      info: json['info'] != null ? new UserModel.fromJson(json['info']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['level'] = this.level;
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    return data;
  }
}

class UserModel {
  String mobile;
  String email;
  String birthday;
  String sex;
  String nickname;
  String realName;
  String avatarUrl;
  String bstAddress;

  UserModel({
    this.mobile,
    this.email,
    this.birthday,
    this.sex,
    this.nickname,
    this.realName,
    this.avatarUrl,
    this.bstAddress,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      mobile: json['mobile'],
      email: json['email'],
      birthday: json['birthday'],
      sex: json['sex'],
      nickname: json['nickname'],
      realName: json['realName'],
      avatarUrl: json['avatarUrl'],
      bstAddress: json['bstAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['birthday'] = this.birthday;
    data['sex'] = this.sex;
    data['nickname'] = this.nickname;
    data['realName'] = this.realName;
    data['avatarUrl'] = this.avatarUrl;
    data['bstAddress'] = this.bstAddress;
    return data;
  }
}

class AvatarModel {
  int code;
  String avatarUrl;
  String msg;

  AvatarModel({this.code, this.avatarUrl, this.msg});

  factory AvatarModel.fromJson(Map<String, dynamic> json) {
    return AvatarModel(
      code: json['code'],
      avatarUrl: json['avatarUrl'],
      msg: json['msg'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['avatarUrl'] = this.avatarUrl;
    data['msg'] = this.msg;
    return data;
  }
}

class UserInfoModel {
  String avatarUrl;
  String nickname;

  UserInfoModel({this.avatarUrl, this.nickname});

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      avatarUrl: json['avatarUrl'],
      nickname: json['nickname'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatarUrl'] = this.avatarUrl;
    data['nickname'] = this.nickname;
    return data;
  }
}
