import 'package:baas_study/model/profile_model.dart';

class CommentAddModel {
  int code;
  String msg;
  String rate;

  CommentAddModel({this.code, this.msg, this.rate});

  CommentAddModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['rate'] = this.rate;
    return data;
  }
}

class CommentCountModel {
  int code;
  CommentCount count;
  int pageSum;

  CommentCountModel({this.code, this.count, this.pageSum});

  factory CommentCountModel.fromJson(Map<String, dynamic> json) {
    return CommentCountModel(
      code: json['code'],
      count:
          json['count'] != null ? CommentCount.fromJson(json['count']) : null,
      pageSum: json['pageSum'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.count != null) {
      data['count'] = this.count.toJson();
    }
    data['pageSum'] =this.pageSum;
    return data;
  }
}

class CommentCount {
  int all;
  int bad;
  int good;
  int mid;

  CommentCount({this.all, this.bad, this.good, this.mid});

  factory CommentCount.fromJson(Map<String, dynamic> json) {
    return CommentCount(
      all: json['all'],
      bad: json['bad'],
      good: json['good'],
      mid: json['mid'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all'] = this.all;
    data['bad'] = this.bad;
    data['good'] = this.good;
    data['mid'] = this.mid;
    return data;
  }
}

class CommentListModel {
  int code;
  List<CommentModel> comments;

  CommentListModel({this.code, this.comments});

  factory CommentListModel.fromJson(Map<String, dynamic> json) {
    return CommentListModel(
      code: json['code'],
      comments: json['comments'] != null
          ? (json['comments'] as List)
              .map((i) => CommentModel.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommentModel {
  String content;
  int courseID;
  int id;
  int star;
  String time;
  int userID;
  UserInfoModel user;

  CommentModel({
    this.content,
    this.courseID,
    this.id,
    this.star,
    this.time,
    this.userID,
    this.user,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      content: json['content'],
      courseID: json['courseID'],
      id: json['id'],
      star: json['star'],
      time: json['time'],
      userID: json['userID'],
      user: json['UserInformation'] != null
          ? UserInfoModel.fromJson(json['UserInformation'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['courseID'] = this.courseID;
    data['id'] = this.id;
    data['star'] = this.star;
    data['time'] = this.time;
    data['userID'] = this.userID;
    if (this.user != null) {
      data['UserInformation'] = this.user.toJson();
    }
    return data;
  }
}
