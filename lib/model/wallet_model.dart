class WalletModel {
  int code;
  double balance;

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
  List<dynamic> logs;
  int pageSum;

  WalletLogsModel({this.code, this.logs, this.pageSum});

  factory WalletLogsModel.fromJson(
      Map<String, dynamic> json, dynamic logsType) {
    List<dynamic> logs;
    if (json['logs'] != null) {
      if (logsType is BalanceLogsModel) {
        logs = new List<BalanceLogsModel>();
        json['logs'].forEach((v) {
          logs.add(new BalanceLogsModel.fromJson(v));
        });
      } else if (logsType is BstLogsModel) {
        logs = new List<BstLogsModel>();
        json['logs'].forEach((v) {
          logs.add(new BstLogsModel.fromJson(v));
        });
      }
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
  num amount;
  String time;
  int id;
  int productId;
  String productType;
  String type;
  String details;
  String status;

  BalanceLogsModel({
    this.amount,
    this.time,
    this.id,
    this.productId,
    this.productType,
    this.type,
    this.details,
    this.status,
  });

  factory BalanceLogsModel.fromJson(Map<String, dynamic> json) {
    return BalanceLogsModel(
      amount: json['amount'],
      time: json['time'],
      id: json['id'],
      productId: json['productId'],
      productType: json['productType'],
      type: json['type'],
      details: json['details'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['time'] = this.time;
    data['userId'] = this.id;
    data['productId'] = this.productId;
    data['productType'] = this.productType;
    data['type'] = this.type;
    data['details'] = this.details;
    data['status'] = this.status;
    return data;
  }
}

class BstBalanceModel {
  int code;
  String balance;

  BstBalanceModel({this.code, this.balance});

  factory BstBalanceModel.fromJson(Map<String, dynamic> json) {
    return BstBalanceModel(
      code: json['code'],
      balance: json['balance'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['balance'] = this.balance;
    return data;
  }
}

class BstLogsModel {
  num amount;
  String time;
  int id;
  int statue;
  int productId;
  String productType;
  String txHash;

  BstLogsModel({
    this.amount,
    this.time,
    this.id,
    this.statue,
    this.productId,
    this.productType,
    this.txHash,
  });

  factory BstLogsModel.fromJson(Map<String, dynamic> json) {
    return BstLogsModel(
      amount: json['amount'],
      time: json['time'],
      id: json['id'],
      statue: json['statue'],
      productId: json['productId'],
      productType: json['productType'],
      txHash: json['txHash'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['time'] = this.time;
    data['id'] = this.id;
    data['statue'] = this.statue;
    data['productId'] = this.productId;
    data['productType'] = this.productType;
    data['txHash'] = this.txHash;
    return data;
  }
}

class WalletPubKeyModel {
  int code;
  String key;

  WalletPubKeyModel({this.code, this.key});

  factory WalletPubKeyModel.fromJson(Map<String, dynamic> json) {
    return WalletPubKeyModel(
      code: json['code'],
      key: json['publicKey'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['publicKey'] = this.key;
    return data;
  }
}

class BstPriceModel {
  int code;
  num price;

  BstPriceModel({this.code, this.price});

  BstPriceModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['price'] = this.price;
    return data;
  }
}