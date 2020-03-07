class CourseModel {
  int id;
  String name;
  String description;
  String image;
  num rate;
  num apply;
  num price;
  num discount;
  String discountTime;

  CourseModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.rate,
    this.apply,
    this.price,
    this.discount,
    this.discountTime,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      rate: json['rate'],
      apply: json['apply'],
      price: json['price'],
      discount: json['discount'],
      discountTime: json['discountTime'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['rate'] = this.rate;
    data['apply'] = this.apply;
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

class CoursePageModel {
  int code;
  int page;
  int count;

  CoursePageModel({this.code, this.page, this.count});

  factory CoursePageModel.fromJson(Map<String, dynamic> json) {
    return CoursePageModel(
        code : json['code'],
        page : json['page'],
        count : json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['page'] = this.page;
    data['count'] = this.count;
    return data;
  }
}

class CourseSystemTypeModel {
    List<CourseSystemModel> data;
    int code;

    CourseSystemTypeModel({this.data, this.code});

    factory CourseSystemTypeModel.fromJson(Map<String, dynamic> json) {
        return CourseSystemTypeModel(
            data: json['data'] != null ? (json['data'] as List).map((i) => CourseSystemModel.fromJson(i)).toList() : null,
            code: json['code'], 
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
    int id;
    String name;
    List<CourseTypeModel> types;

    CourseSystemModel({this.id, this.name, this.types});

    factory CourseSystemModel.fromJson(Map<String, dynamic> json) {
        return CourseSystemModel(
            id: json['id'], 
            name: json['name'], 
            types: json['types'] != null ? (json['types'] as List).map((i) => CourseTypeModel.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['name'] = this.name;
        if (this.types != null) {
            data['types'] = this.types.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class CourseTypeModel {
    int id;
    String name;

    CourseTypeModel({this.id, this.name});

    factory CourseTypeModel.fromJson(Map<String, dynamic> json) {
        return CourseTypeModel(
            id: json['id'], 
            name: json['name'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['name'] = this.name;
        return data;
    }
}
