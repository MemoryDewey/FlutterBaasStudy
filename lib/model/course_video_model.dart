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

class VideoFirstModel {
    int code;
    VideoModel video;

    VideoFirstModel({this.code, this.video});

    factory VideoFirstModel.fromJson(Map<String, dynamic> json) {
        return VideoFirstModel(
            code: json['code'],
            video: json['video'] != null ? VideoModel.fromJson(json['video']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        if (this.video != null) {
            data['video'] = this.video.toJson();
        }
        return data;
    }
}

class VideoModel {
    int chapterId;
    int duration;
    String fileId;
    int id;
    String mediaUrl;
    String name;
    String videoUrl;
    String wareUrl;

    VideoModel({this.chapterId, this.duration, this.fileId, this.id, this.mediaUrl, this.name, this.videoUrl, this.wareUrl});

    factory VideoModel.fromJson(Map<String, dynamic> json) {
        return VideoModel(
            chapterId: json['chapterId'],
            duration: json['duration'],
            fileId: json['fileId'],
            id: json['id'],
            mediaUrl: json['mediaUrl'],
            name: json['name'],
            videoUrl: json['videoUrl'],
            wareUrl: json['wareUrl'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['chapterId'] = this.chapterId;
        data['duration'] = this.duration;
        data['fileId'] = this.fileId;
        data['id'] = this.id;
        data['mediaUrl'] = this.mediaUrl;
        data['name'] = this.name;
        data['videoUrl'] = this.videoUrl;
        data['wareUrl'] = this.wareUrl;
        return data;
    }
}