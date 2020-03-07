class CertificateModel {
    List<Certificate> certificates;
    int code;
    int pageSum;

    CertificateModel({this.certificates, this.code, this.pageSum});

    factory CertificateModel.fromJson(Map<String, dynamic> json) {
        return CertificateModel(
            certificates: json['certificates'] != null ? (json['certificates'] as List).map((i) => Certificate.fromJson(i)).toList() : null,
            code: json['code'],
            pageSum: json['pageSum'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['pageSum'] = this.pageSum;
        if (this.certificates != null) {
            data['certificates'] = this.certificates.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Certificate {
    int courseId;
    String courseImage;
    String courseName;
    String id;
    String nickname;
    int score;
    String time;

    Certificate({this.courseId, this.courseImage, this.courseName, this.id, this.nickname, this.score, this.time});

    factory Certificate.fromJson(Map<String, dynamic> json) {
        return Certificate(
            courseId: json['courseId'],
            courseImage: json['courseImage'],
            courseName: json['courseName'],
            id: json['id'],
            nickname: json['nickname'],
            score: json['score'],
            time: json['time'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['courseId'] = this.courseId;
        data['courseImage'] = this.courseImage;
        data['courseName'] = this.courseName;
        data['id'] = this.id;
        data['nickname'] = this.nickname;
        data['score'] = this.score;
        data['time'] = this.time;
        return data;
    }
}