class CourseManageModel {
  int code;
  int pageSum;
  List<dynamic> courses;

  CourseManageModel({this.code, this.pageSum, this.courses});

  factory CourseManageModel.fromJson(
      Map<String, dynamic> json, dynamic courseType) {
    List<dynamic> courses = [];
    if (json['courses'] != null) {
      if (courseType is UserCoursesModel) {
        courses = new List<UserCoursesModel>();
        json['courses'].forEach((v) {
          courses.add(new UserCoursesModel.fromJson(v));
        });
      } else if (courseType is BalanceCoursesModel) {
        courses = new List<BalanceCoursesModel>();
        json['courses'].forEach((v) {
          courses.add(new BalanceCoursesModel.fromJson(v));
        });
      } else if (courseType is BstCoursesModel) {
        courses = new List<BstCoursesModel>();
        json['courses'].forEach((v) {
          courses.add(new BstCoursesModel.fromJson(v));
        });
      } else if (courseType is SimpleCoursesModel) {
        courses = new List<SimpleCoursesModel>();
        json['courses'].forEach((v) {
          courses.add(new SimpleCoursesModel.fromJson(v));
        });
      }else if(courseType is ExamCoursesModel){
        courses = new List<ExamCoursesModel>();
        json['courses'].forEach((v) {
          courses.add(new ExamCoursesModel.fromJson(v));
        });
      }
    }
    return CourseManageModel(
      code: json['code'],
      pageSum: json['pageSum'],
      courses: courses,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['pageSum'] = this.pageSum;
    if (this.courses != null) {
      data['courses'] = this.courses.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserCoursesModel {
  int courseID;
  String courseName;
  int price;
  String image;
  int score;
  String joinTime;

  UserCoursesModel({
    this.courseID,
    this.courseName,
    this.price,
    this.image,
    this.score,
    this.joinTime,
  });

  factory UserCoursesModel.fromJson(Map<String, dynamic> json) {
    return UserCoursesModel(
      courseID: json['courseID'],
      courseName: json['courseName'],
      price: json['price'],
      image: json['image'],
      score: json['score'],
      joinTime: json['joinTime'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseID'] = this.courseID;
    data['courseName'] = this.courseName;
    data['price'] = this.price;
    data['image'] = this.image;
    data['score'] = this.score;
    data['joinTime'] = this.joinTime;
    return data;
  }
}

class BalanceCoursesModel {
  String amount;
  String createdAt;
  int productID;
  int userID;
  CourseInfoModel courseInformation;

  BalanceCoursesModel({
    this.amount,
    this.createdAt,
    this.productID,
    this.userID,
    this.courseInformation,
  });

  factory BalanceCoursesModel.fromJson(Map<String, dynamic> json) {
    return BalanceCoursesModel(
      amount: json['amount'],
      createdAt: json['createdAt'],
      productID: json['productID'],
      userID: json['userID'],
      courseInformation: json['CourseInformation'] != null
          ? new CourseInfoModel.fromJson(json['CourseInformation'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['createdAt'] = this.createdAt;
    data['productID'] = this.productID;
    data['userID'] = this.userID;
    if (this.courseInformation != null) {
      data['CourseInformation'] = this.courseInformation.toJson();
    }
    return data;
  }
}

class BstCoursesModel {
  String amount;
  String createdAt;
  int productID;
  int userID;
  String txHash;
  CourseInfoModel courseInformation;

  BstCoursesModel({
    this.amount,
    this.createdAt,
    this.productID,
    this.userID,
    this.txHash,
    this.courseInformation,
  });

  factory BstCoursesModel.fromJson(Map<String, dynamic> json) {
    return BstCoursesModel(
      amount: json['amount'],
      createdAt: json['createdAt'],
      productID: json['productID'],
      userID: json['userID'],
      txHash: json['txHash'],
      courseInformation: json['CourseInformation'] != null
          ? new CourseInfoModel.fromJson(json['CourseInformation'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['createdAt'] = this.createdAt;
    data['productID'] = this.productID;
    data['userID'] = this.userID;
    data['txHash'] = this.txHash;
    if (this.courseInformation != null) {
      data['CourseInformation'] = this.courseInformation.toJson();
    }
    return data;
  }
}

class CourseInfoModel {
  String courseName;
  String courseImage;

  CourseInfoModel({this.courseName, this.courseImage});

  factory CourseInfoModel.fromJson(Map<String, dynamic> json) {
    return CourseInfoModel(
      courseName: json['courseName'],
      courseImage: json['courseImage'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseName'] = this.courseName;
    data['courseImage'] = this.courseImage;
    return data;
  }
}

class SimpleCoursesModel {
  int courseID;
  String courseName;
  String courseImage;
  int applyCount;
  int price;
  bool selected;

  SimpleCoursesModel({
    this.courseID,
    this.courseName,
    this.courseImage,
    this.applyCount,
    this.price,
    this.selected,
  });

  factory SimpleCoursesModel.fromJson(Map<String, dynamic> json) {
    return SimpleCoursesModel(
      courseID: json['courseID'],
      courseName: json['courseName'],
      courseImage: json['courseImage'],
      applyCount: json['applyCount'],
      price: json['price'],
      selected: false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseID'] = this.courseID;
    data['courseName'] = this.courseName;
    data['courseImage'] = this.courseImage;
    data['applyCount'] = this.applyCount;
    data['price'] = this.price;
    return data;
  }
}

class ExamCoursesModel {
  int courseID;
  String courseName;
  String image;
  int state;
  int score;
  String startTime;
  String endTime;

  ExamCoursesModel({
    this.courseID,
    this.courseName,
    this.image,
    this.state,
    this.score,
    this.startTime,
    this.endTime,
  });

  factory ExamCoursesModel.fromJson(Map<String, dynamic> json) {
    return ExamCoursesModel(
      courseID: json['courseID'],
      courseName: json['courseName'],
      image: json['image'],
      state: json['state'],
      score: json['score'],
      startTime: json['time'] != null ? json['time']['startTime'] : null,
      endTime: json['time'] != null ? json['time']['endTime'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseID'] = this.courseID;
    data['courseName'] = this.courseName;
    data['image'] = this.image;
    data['state'] = this.state;
    data['score'] = this.score;
    return data;
  }
}
