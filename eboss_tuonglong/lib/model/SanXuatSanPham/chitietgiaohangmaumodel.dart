class ChiTietGiaoHangMauModel {
  bool? succeeded;
  int? code;
  Null? message;
  Null? errors;
  List<Data>? data;

  ChiTietGiaoHangMauModel(
      {this.succeeded, this.code, this.message, this.errors, this.data});

  ChiTietGiaoHangMauModel.fromJson(Map<String, dynamic> json) {
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
  String? deliveryID;
  String? recordDate;
  String? productID;
  String? productType;
  String? unitID;
  double? qty;
  String? dealUnitID;
  double? dealQty;
  String? remark;
  String? sampleAID;
  String? productName;

  Data(
      {this.deliveryID,
      this.recordDate,
      this.productID,
      this.productType,
      this.unitID,
      this.qty,
      this.dealUnitID,
      this.dealQty,
      this.remark,
      this.sampleAID,
      this.productName
      });

  Data.fromJson(Map<String, dynamic> json) {
    deliveryID = json['DeliveryID'];
    recordDate = json['RecordDate'];
    productID = json['ProductID'];
    productType = json['ProductType'];
    unitID = json['UnitID'];
    qty = json['Qty'];
    dealUnitID = json['DealUnitID'];
    dealQty = json['DealQty'];
    remark = json['Remark'];
    sampleAID = json['SampleAID'];
    productName = json['ProductName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DeliveryID'] = this.deliveryID;
    data['RecordDate'] = this.recordDate;
    data['ProductID'] = this.productID;
    data['ProductType'] = this.productType;
    data['UnitID'] = this.unitID;
    data['Qty'] = this.qty;
    data['DealUnitID'] = this.dealUnitID;
    data['DealQty'] = this.dealQty;
    data['Remark'] = this.remark;
    data['SampleAID'] = this.sampleAID;
    data['ProductName'] = this.productName;
    return data;
  }
}
