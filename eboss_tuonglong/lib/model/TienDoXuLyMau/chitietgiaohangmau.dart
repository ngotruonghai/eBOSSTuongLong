class ChiTietGiaoHangMauModel {
  bool? succeeded;
  int? code;
  String? message;
  String? errors;
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
  String? processSampleAID;
  String? deliveryID;
  String? recordDate;
  String? productID;
  String? productName;
  String? productType;
  String? productTypeName;
  String? unitID;
  String? unitName;
  String? qty;
  String? dealUnitID;
  String? dealUnitName;
  String? dealQty;
  String? remark;

  Data(
      {
      this.processSampleAID,
      this.deliveryID,
      this.recordDate,
      this.productID,
      this.productName,
      this.productType,
      this.productTypeName,
      this.unitID,
      this.unitName,
      this.qty,
      this.dealUnitID,
      this.dealUnitName,
      this.dealQty,
      this.remark,
      });

  Data.fromJson(Map<String, dynamic> json)
      : processSampleAID = json['ProcessSampleAID'],
        deliveryID = json['DeliveryID'],
        recordDate = json['RecordDate'],
        productID = json['ProductID'],
        productName = json['ProductName'],
        productType = json['ProductType'],
        productTypeName = json['ProductTypeName'],
        unitID = json['UnitID'],
        unitName = json['UnitName'],
        qty = json['Qty'],
        dealUnitID = json['DealUnitID'],
        dealUnitName = json['DealUnitName'],
        dealQty = json['DealQty'],
        remark = json['Remark'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProcessSampleAID'] = this.processSampleAID;
    data['DeliveryID'] = this.deliveryID;
    data['RecordDate'] = this.recordDate;
    data['ProductID'] = this.productID;
    data['ProductName'] = this.productName;
    data['ProductType'] = this.productType;
    data['ProductTypeName'] = this.productTypeName;
    data['UnitID'] = this.unitID;
    data['UnitName'] = this.unitName;
    data['Qty'] = this.qty;
    data['DealUnitID'] = this.dealUnitID;
    data['DealUnitName'] = this.dealUnitName;
    data['DealQty'] = this.dealQty;
    data['Remark'] = this.remark;
    return data;
  }
}
