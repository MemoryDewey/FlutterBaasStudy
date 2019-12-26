import 'package:baas_study/model/profile_model.dart';

class CourseInfoDetailModel {
  int code;
  InfoDetailModel course;
  bool collection;

  CourseInfoDetailModel({this.code, this.course, this.collection});

  factory CourseInfoDetailModel.fromJson(Map<String, dynamic> json) {
    return CourseInfoDetailModel(
      code: json['code'],
      course: json['course'] != null
          ? InfoDetailModel.fromJson(json['course'])
          : null,
      collection: json['collection'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.course != null) {
      data['course'] = this.course.toJson();
    }
    data['collection'] = this.collection;
    return data;
  }
}

class InfoDetailModel {
  InfoModel info;
  DetailModel details;

  InfoDetailModel({this.info, this.details});

  factory InfoDetailModel.fromJson(Map<String, dynamic> json) {
    return InfoDetailModel(
      info: json['info'] != null ? new InfoModel.fromJson(json['info']) : null,
      details: json['details'] != null
          ? DetailModel.fromJson(json['details'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    if (this.details != null) {
      data['details'] = this.details.toJson();
    }
    return data;
  }
}

class InfoModel {
  int id;
  String name;
  String description;
  String image;
  int price;
  int discount;
  String discountTime;
  String form;
  double rate;
  int apply;

  InfoModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.price,
    this.discount,
    this.discountTime,
    this.form,
    this.rate,
    this.apply,
  });

  factory InfoModel.fromJson(Map<String, dynamic> json) {
    return InfoModel(
      id: json['courseID'],
      name: json['courseName'],
      description: json['courseDescription'],
      image: json['courseImage'],
      price: json['price'],
      discount: json['discount'],
      discountTime: json['discountTime'],
      form: json['courseForm'],
      rate: json['favorableRate'] == 1
          ? 1.0
          : json['favorableRate'] == 0 ? 0.0 : json['favorableRate'],
      apply: json['applyCount'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseID'] = this.id;
    data['courseName'] = this.name;
    data['courseDescription'] = this.description;
    data['courseImage'] = this.image;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['discountTime'] = this.discountTime;
    data['courseForm'] = this.form;
    data['favorableRate'] = this.rate;
    data['applyCount'] = this.apply;
    return data;
  }
}

class DetailModel {
  String start;
  String finish;
  String detail;
  String cover;
  String arrange;
  String schedule;
  UserInfoModel userInformation;

  DetailModel({
    this.start,
    this.finish,
    this.detail,
    this.cover,
    this.arrange,
    this.schedule,
    this.userInformation,
  });

  factory DetailModel.fromJson(Map<String, dynamic> json) {
    return DetailModel(
      start: json['startTime'],
      finish: json['finishTime'],
      detail: json['detail'],
      cover: json['coverUrl'],
      arrange: json['courseArrange'],
      schedule: json['schedule'],
      userInformation: json['UserInformation'] != null
          ? UserInfoModel.fromJson(json['UserInformation'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startTime'] = this.start;
    data['finishTime'] = this.finish;
    data['detail'] = this.detail;
    data['coverUrl'] = this.cover;
    data['courseArrange'] = this.arrange;
    data['schedule'] = this.schedule;
    if (this.userInformation != null) {
      data['UserInformation'] = this.userInformation.toJson();
    }
    return data;
  }
}

class LiveModel {
  int code;
  bool live;
  String streamName;
  bool state;
  String title;

  LiveModel({
    this.code,
    this.live,
    this.streamName,
    this.state,
    this.title,
  });

  factory LiveModel.fromJson(Map<String, dynamic> json) {
    return LiveModel(
      code: json['code'],
      live: json['live'],
      streamName: json['streamName'],
      state: json['state'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['live'] = this.live;
    data['streamName'] = this.streamName;
    data['state'] = this.state;
    data['title'] = this.title;
    return data;
  }
}

class ChapterInfoModel {
  int code;
  List<ChapterModel> data;
  int count;

  ChapterInfoModel({this.code, this.data, this.count});

  factory ChapterInfoModel.fromJson(Map<String, dynamic> json) {
    List<ChapterModel> data = new List<ChapterModel>();
    json['data'].forEach((v) {
      data.add(new ChapterModel.fromJson(v));
    });
    return ChapterInfoModel(
      code: json['code'],
      data: data,
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class ChapterModel {
  String number;
  String name;
  List<VideoModel> video;

  ChapterModel({this.number, this.name, this.video});

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    List<VideoModel> video = new List<VideoModel>();
    json['video'].forEach((v) {
      video.add(new VideoModel.fromJson(v));
    });
    return ChapterModel(
      number: json['number'],
      name: json['name'],
      video: video,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['name'] = this.name;
    if (this.video != null) {
      data['video'] = this.video.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideoModel {
  int id;
  String name;
  String ware;
  int duration;
  String url;

  VideoModel({this.id, this.name, this.ware, this.duration, this.url});

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'],
      name: json['name'],
      ware: json['ware'],
      duration: json['duration'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['ware'] = this.ware;
    data['duration'] = this.duration;
    data['url'] = this.url;
    return data;
  }
}

class CourseApplyModel {
  int applyCount;
  int code;
  String msg;

  CourseApplyModel({this.applyCount, this.code, this.msg});

  factory CourseApplyModel.fromJson(Map<String, dynamic> json) {
    return CourseApplyModel(
      applyCount: json['applyCount'],
      code: json['code'],
      msg: json['msg'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['applyCount'] = this.applyCount;
    data['code'] = this.code;
    data['msg'] = this.msg;
    return data;
  }
}
