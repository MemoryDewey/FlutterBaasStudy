class ExamInfoModel {
  int code;
  List<ExamModel> exam;
  FinishedModel finished;

  ExamInfoModel({this.code, this.exam, this.finished});

  factory ExamInfoModel.fromJson(Map<String, dynamic> json) {
    return ExamInfoModel(
      code: json['code'],
      exam: json['exam'] != null
          ? (json['exam'] as List).map((i) => ExamModel.fromJson(i)).toList()
          : null,
      finished: json['finished'] != null
          ? FinishedModel.fromJson(json['finished'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.exam != null) {
      data['exam'] = this.exam.map((v) => v.toJson()).toList();
    }
    if (this.finished != null) {
      data['finished'] = this.finished.toJson();
    }
    return data;
  }
}

class FinishedModel {
  List<ResultModel> result;
  int score;
  bool state;

  FinishedModel({this.result, this.score, this.state});

  factory FinishedModel.fromJson(Map<String, dynamic> json) {
    return FinishedModel(
      result: json['result'] != null
          ? (json['result'] as List)
              .map((i) => ResultModel.fromJson(i))
              .toList()
          : null,
      score: json['score'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['score'] = this.score;
    data['state'] = this.state;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultModel {
  String choose;
  int number;
  num score;

  ResultModel({this.choose, this.number, this.score});

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      choose: json['choose'],
      number: json['number'],
      score: json['score'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['choose'] = this.choose;
    data['number'] = this.number;
    data['score'] = this.score;
    return data;
  }
}

class ExamModel {
  int number;
  num score;
  List<SectionModel> section;
  String title;

  ExamModel({this.number, this.score, this.section, this.title});

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      number: json['number'],
      score: json['score'],
      section: json['section'] != null
          ? (json['section'] as List)
              .map((i) => SectionModel.fromJson(i))
              .toList()
          : null,
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['score'] = this.score;
    data['title'] = this.title;
    if (this.section != null) {
      data['section'] = this.section.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SectionModel {
  String choose;
  String content;

  SectionModel({this.choose, this.content});

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      choose: json['choose'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['choose'] = this.choose;
    data['content'] = this.content;
    return data;
  }
}

class SubmitExamModel {
  List<String> answer;
  int courseID;
  SubmitExamInfoModel exam;

  SubmitExamModel({this.answer, this.courseID, this.exam});

  factory SubmitExamModel.fromJson(Map<String, dynamic> json) {
    return SubmitExamModel(
      answer:
          json['answer'] != null ? new List<String>.from(json['answer']) : null,
      courseID: json['courseID'],
      exam: json['exam'] != null
          ? SubmitExamInfoModel.fromJson(json['exam'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseID'] = this.courseID;
    if (this.answer != null) {
      data['answer'] = this.answer;
    }
    if (this.exam != null) {
      data['exam'] = this.exam.toJson();
    }
    return data;
  }
}

class SubmitExamInfoModel {
  int id;
  String type;

  SubmitExamInfoModel({this.id, this.type});

  factory SubmitExamInfoModel.fromJson(Map<String, dynamic> json) {
    return SubmitExamInfoModel(
      id: json['id'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    return data;
  }
}
