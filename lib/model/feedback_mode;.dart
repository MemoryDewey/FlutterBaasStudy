class FeedbackModel {
  int code;
  List<FeedbackTypeModel> feedbackType;

  FeedbackModel({this.code, this.feedbackType});

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    List<FeedbackTypeModel> feedbackType;
    if (json['feedbackType'] != null) {
      feedbackType = new List<FeedbackTypeModel>();
      json['feedbackType'].forEach((v) {
        feedbackType.add(new FeedbackTypeModel.fromJson(v));
      });
    }
    return FeedbackModel(
      code: json['code'],
      feedbackType: feedbackType,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.feedbackType != null) {
      data['feedbackType'] = this.feedbackType.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeedbackTypeModel {
  String name;
  int id;

  FeedbackTypeModel({this.name, this.id});

  factory FeedbackTypeModel.fromJson(Map<String, dynamic> json) {
    return FeedbackTypeModel(
      name: json['name'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
