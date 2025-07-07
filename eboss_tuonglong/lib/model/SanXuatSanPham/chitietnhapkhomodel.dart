class ChiTietNhapKhoModel {
  bool? succeeded;
  int? code;
  Null? message;
  Null? errors;
  List<Data>? data;

  ChiTietNhapKhoModel(
      {this.succeeded, this.code, this.message, this.errors, this.data});

  ChiTietNhapKhoModel.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    code = json['code'];
    message = json['message'];
    errors = json['errors'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['succeeded'] = this.succeeded;
    data['code'] = this.code;
    data['message'] = this.message;
    data['errors'] = this.errors;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? stockID;
  String? recordDate;
  String? productID;
  String? productType;
  String? productName;
  String? unitID;
  double? qty;
  String? remark;

  Data(
      {this.stockID,
      this.recordDate,
      this.productID,
      this.productType,
      this.unitID,
      this.qty,
      this.remark,
      this.productName});

  Data.fromJson(Map<String, dynamic> json) {
    stockID = json['StockID'];
    recordDate = json['RecordDate'];
    productID = json['ProductID'];
    productType = json['ProductType'];
    unitID = json['UnitID'];
    qty = json['Qty'];
    remark = json['Remark'];
    productName = json['ProductName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StockID'] = this.stockID;
    data['RecordDate'] = this.recordDate;
    data['ProductID'] = this.productID;
    data['ProductType'] = this.productType;
    data['UnitID'] = this.unitID;
    data['Qty'] = this.qty;
    data['Remark'] = this.remark;
    data['ProductName'] = this.productName;
    return data;
  }
}
