class CommentAddModel {
  int code;
  String msg;
  double rate;

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
  int pageSize;

  CommentCountModel({this.code, this.count, this.pageSize});

  factory CommentCountModel.fromJson(Map<String, dynamic> json) {
    return CommentCountModel(
      code: json['code'],
      count:
          json['count'] != null ? CommentCount.fromJson(json['count']) : null,
      pageSize: json['pageSize'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.count != null) {
      data['count'] = this.count.toJson();
    }
    data['pageSize'] =this.pageSize;
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
  String avatar;
  String content;
  int id;
  int star;
  String time;
  String user;

  CommentModel({this.avatar, this.content, this.id, this.star, this.time, this.user});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      avatar: json['avatar'],
      content: json['content'],
      id: json['id'],
      star: json['star'],
      time: json['time'],
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['content'] = this.content;
    data['id'] = this.id;
    data['star'] = this.star;
    data['time'] = this.time;
    data['user'] = this.user;
    return data;
  }
}

