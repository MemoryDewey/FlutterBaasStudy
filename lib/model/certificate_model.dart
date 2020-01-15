class CertificateModel {
  List<Certificate> certificates;
  int code;
  int pageSum;

  CertificateModel({this.certificates, this.code, this.pageSum});

  factory CertificateModel.fromJson(Map<String, dynamic> json) {
    return CertificateModel(
      certificates: json['certificates'] != null
          ? (json['certificates'] as List)
              .map((i) => Certificate.fromJson(i))
              .toList()
          : null,
      code: json['code'],
      pageSum: json['pageSum'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['pageSum'] = this.pageSum;
    if (this.certificates != null) {
      data['certificates'] = this.certificates.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Certificate {
  int courseID;
  CourseInformation courseInformation;
  String createdAt;
  String id;
  int score;
  int userID;
  UserInformation userInformation;

  Certificate(
      {this.courseID,
      this.courseInformation,
      this.createdAt,
      this.id,
      this.score,
      this.userID,
      this.userInformation});

  factory Certificate.fromJson(Map<String, dynamic> json) {
    return Certificate(
      courseID: json['courseID'],
      courseInformation: json['CourseInformation'] != null
          ? CourseInformation.fromJson(json['CourseInformation'])
          : null,
      createdAt: json['createdAt'],
      id: json['id'],
      score: json['score'],
      userID: json['userID'],
      userInformation: json['UserInformation'] != null
          ? UserInformation.fromJson(json['UserInformation'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseID'] = this.courseID;
    data['createdAt'] = this.createdAt;
    data['id'] = this.id;
    data['score'] = this.score;
    data['userID'] = this.userID;
    if (this.courseInformation != null) {
      data['CourseInformation'] = this.courseInformation.toJson();
    }
    if (this.userInformation != null) {
      data['UserInformation'] = this.userInformation.toJson();
    }
    return data;
  }
}

class UserInformation {
  String nickname;

  UserInformation({this.nickname});

  factory UserInformation.fromJson(Map<String, dynamic> json) {
    return UserInformation(
      nickname: json['nickname'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nickname'] = this.nickname;
    return data;
  }
}

class CourseInformation {
  String courseImage;
  String courseName;

  CourseInformation({this.courseImage, this.courseName});

  factory CourseInformation.fromJson(Map<String, dynamic> json) {
    return CourseInformation(
      courseImage: json['courseImage'],
      courseName: json['courseName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseImage'] = this.courseImage;
    data['courseName'] = this.courseName;
    return data;
  }
}
