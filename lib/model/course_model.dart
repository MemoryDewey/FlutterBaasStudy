class CourseModel {
  int id;
  String name;
  String description;
  String imageUrl;
  num rate;
  num apply;
  num price;
  num discount;
  String discountTime;

  CourseModel({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.rate,
    this.apply,
    this.price,
    this.discount,
    this.discountTime,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['courseID'],
      name: json['courseName'],
      description: json['courseDescription'],
      imageUrl: json['courseImage'],
      rate: json['favorableRate'],
      apply: json['applyCount'],
      price: json['price'],
      discount: json['discount'],
      discountTime: json['discountTime'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseID'] = this.id;
    data['courseName'] = this.name;
    data['description'] = this.description;
    data['courseImage'] = this.imageUrl;
    data['favorableRate'] = this.rate;
    data['applyCount'] = this.apply;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['discountTime'] = this.discountTime;
    return data;
  }
}

class CourseListModel {
  int code;
  List<CourseModel> course;

  CourseListModel({this.code, this.course});

  CourseListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['course'] != null) {
      course = new List<CourseModel>();
      json['course'].forEach((v) {
        course.add(new CourseModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.course != null) {
      data['course'] = this.course.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseSystemTypeModel {
  int code;
  List<CourseSystemModel> data;

  CourseSystemTypeModel({this.code, this.data});

  factory CourseSystemTypeModel.fromJson(Map<String, dynamic> json) {
    int code = json['code'];
    List<CourseSystemModel> data;
    if (json['data'] != null) {
      data = new List<CourseSystemModel>();
      json['data'].forEach((v) {
        data.add(new CourseSystemModel.fromJson(v));
      });
    }
    return CourseSystemTypeModel(
      code: code,
      data: data,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseSystemModel {
  int systemID;
  String systemName;
  List<CourseTypeModel> courseTypes;

  CourseSystemModel({this.systemID, this.systemName, this.courseTypes});

  factory CourseSystemModel.fromJson(Map<String, dynamic> json) {
    int systemID = json['systemID'];
    String systemName = json['systemName'];
    List<CourseTypeModel> courseTypes;
    if (json['CourseTypes'] != null) {
      courseTypes = new List<CourseTypeModel>();
      json['CourseTypes'].forEach((v) {
        courseTypes.add(new CourseTypeModel.fromJson(v));
      });
    }
    return CourseSystemModel(
      systemID: systemID,
      systemName: systemName,
      courseTypes: courseTypes,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['systemID'] = this.systemID;
    data['systemName'] = this.systemName;
    if (this.courseTypes != null) {
      data['CourseTypes'] = this.courseTypes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseTypeModel {
  int typeID;
  String typeName;

  CourseTypeModel({this.typeID, this.typeName});

  factory CourseTypeModel.fromJson(Map<String, dynamic> json) {
    return CourseTypeModel(
      typeID: json['typeID'],
      typeName: json['typeName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeID'] = this.typeID;
    data['typeName'] = this.typeName;
    return data;
  }
}
