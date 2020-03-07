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
  int id;
  String name;
  int price;
  String image;
  int score;
  String time;

  UserCoursesModel({
    this.id,
    this.name,
    this.price,
    this.image,
    this.score,
    this.time,
  });

  factory UserCoursesModel.fromJson(Map<String, dynamic> json) {
    return UserCoursesModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      score: json['score'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    data['score'] = this.score;
    data['time'] = this.time;
    return data;
  }
}

class BalanceCoursesModel {
    num amount;
    int id;
    String image;
    String name;
    int productId;
    String time;

    BalanceCoursesModel({this.amount, this.id, this.image, this.name, this.productId, this.time});

    factory BalanceCoursesModel.fromJson(Map<String, dynamic> json) {
        return BalanceCoursesModel(
            amount: json['amount'],
            id: json['id'],
            image: json['image'],
            name: json['name'],
            productId: json['productId'],
            time: json['time'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['amount'] = this.amount;
        data['id'] = this.id;
        data['image'] = this.image;
        data['name'] = this.name;
        data['productId'] = this.productId;
        data['time'] = this.time;
        return data;
    }
}

class BstCoursesModel {
    double amount;
    int id;
    String image;
    String name;
    int productId;
    String time;
    String txHash;

    BstCoursesModel({this.amount, this.id, this.image, this.name, this.productId, this.time, this.txHash});

    factory BstCoursesModel.fromJson(Map<String, dynamic> json) {
        return BstCoursesModel(
            amount: json['amount'],
            id: json['id'],
            image: json['image'],
            name: json['name'],
            productId: json['productId'],
            time: json['time'],
            txHash: json['txHash'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['amount'] = this.amount;
        data['id'] = this.id;
        data['image'] = this.image;
        data['name'] = this.name;
        data['productId'] = this.productId;
        data['time'] = this.time;
        data['txHash'] = this.txHash;
        return data;
    }
}

class SimpleCoursesModel {
  int id;
  String name;
  String image;
  int apply;
  int price;
  bool selected;

  SimpleCoursesModel({
    this.id,
    this.name,
    this.image,
    this.apply,
    this.price,
    this.selected,
  });

  factory SimpleCoursesModel.fromJson(Map<String, dynamic> json) {
    return SimpleCoursesModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      apply: json['apply'],
      price: json['price'],
      selected: false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['apply'] = this.apply;
    data['price'] = this.price;
    return data;
  }
}

class ExamCoursesModel {
  int courseId;
  String courseName;
  String image;
  int state;
  num score;
  String startTime;
  String endTime;

  ExamCoursesModel({
    this.courseId,
    this.courseName,
    this.image,
    this.state,
    this.score,
    this.startTime,
    this.endTime,
  });

  factory ExamCoursesModel.fromJson(Map<String, dynamic> json) {
    return ExamCoursesModel(
      courseId: json['courseId'],
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
    data['courseId'] = this.courseId;
    data['courseName'] = this.courseName;
    data['image'] = this.image;
    data['state'] = this.state;
    data['score'] = this.score;
    return data;
  }
}
