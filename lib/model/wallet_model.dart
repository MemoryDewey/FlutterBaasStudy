class WalletModel {
  int code;
  String balance;

  WalletModel({this.code, this.balance});

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      code: json['code'],
      balance: json['wallet'] != null ? json['wallet']['balance'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['balance'] = this.balance;
    return data;
  }
}

class WalletLogsModel {
  int code;
  List<BalanceLogsModel> logs;
  int pageSum;

  WalletLogsModel({this.code, this.logs, this.pageSum});

  factory WalletLogsModel.fromJson(Map<String, dynamic> json) {
    List<BalanceLogsModel> logs;
    if (json['logs'] != null) {
      logs = new List<BalanceLogsModel>();
      json['logs'].forEach((v) {
        logs.add(new BalanceLogsModel.fromJson(v));
      });
    }
    return WalletLogsModel(
      code: json['code'],
      logs: logs,
      pageSum: json['pageSum'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.logs != null) {
      data['logs'] = this.logs.map((v) => v.toJson()).toList();
    }
    data['pageSum'] = this.pageSum;
    return data;
  }
}

class BalanceLogsModel {
  String amount;
  String time;
  int userID;
  int productID;
  String productType;
  String type;
  String details;
  String status;

  BalanceLogsModel({
    this.amount,
    this.time,
    this.userID,
    this.productID,
    this.productType,
    this.type,
    this.details,
    this.status,
  });

  factory BalanceLogsModel.fromJson(Map<String, dynamic> json) {
    return BalanceLogsModel(
      amount: json['amount'],
      time: json['createdAt'],
      userID: json['userID'],
      productID: json['productID'],
      productType: json['productType'],
      type: json['type'],
      details: json['details'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['createdAt'] = this.time;
    data['userID'] = this.userID;
    data['productID'] = this.productID;
    data['productType'] = this.productType;
    data['type'] = this.type;
    data['details'] = this.details;
    data['status'] = this.status;
    return data;
  }
}
