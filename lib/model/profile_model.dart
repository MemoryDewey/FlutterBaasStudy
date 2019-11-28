class ProfileModel {
  int code;
  int level;
  UserModel data;

  ProfileModel({this.code, this.level, this.data});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      code: json['code'],
      level: json['level'],
      data: json['data'] != null ? new UserModel.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['level'] = this.level;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class UserModel {
  String nickname;
  String avatarUrl;

  UserModel({this.nickname, this.avatarUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      nickname: json['nickname'],
      avatarUrl: json['avatarUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nickname'] = this.nickname;
    data['avatarUrl'] = this.avatarUrl;
    return data;
  }
}
