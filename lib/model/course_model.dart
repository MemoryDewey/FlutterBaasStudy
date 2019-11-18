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
