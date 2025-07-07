class ChiTietGiaoHangPermissionModel {
  bool? succeeded;
  int? code;
  String? message;
  String? errors;
  List<Data>? data;

  ChiTietGiaoHangPermissionModel(
      {this.succeeded, this.code, this.message, this.errors, this.data});

  ChiTietGiaoHangPermissionModel.fromJson(Map<String, dynamic> json) {
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
 int? inOrder;
  String? sampleAID;
  String? productID;
  String? productType;
  String? unitID;
  double? qty;
  String? dealUnitID;
  int? price;
  double? amount;
  int? inPrice;
  String? remark;
  double? dealQty;
  String? SampleID;
  String? GeneralName;
  String? TenDonVi;

  Data(
      {this.inOrder,
      this.sampleAID,
      this.productID,
      this.productType,
      this.unitID,
      this.qty,
      this.dealUnitID,
      this.dealQty,
      this.price,
      this.amount,
      this.inPrice,
      this.remark,
      this.SampleID,
      this.GeneralName,
      this.TenDonVi});

  Data.fromJson(Map<String, dynamic> json)
      : inOrder = json['InOrder'],
        sampleAID = json['SampleAID'],
        productID = json['ProductID'],
        productType = json['ProductType'],
        unitID = json['UnitID'],
        qty = json['Qty'],
        dealUnitID = json['DealUnitID'],
        dealQty = json['DealQty'],
        price = json['Price'],
        amount = json['Amount'],
        inPrice = json['InPrice'],
        remark = json['Remark'],
        GeneralName = json['GeneralName'],
        SampleID = json['SampleID'],
        TenDonVi = json['TenDonVi'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['InOrder'] = this.inOrder;
    data['SampleAID'] = this.sampleAID;
    data['ProductID'] = this.productID;
    data['ProductType'] = this.productType;
    data['UnitID'] = this.unitID;
    data['Qty'] = this.qty;
    data['DealUnitID'] = this.dealUnitID;
    data['DealQty'] = this.dealQty;
    data['Price'] = this.price;
    data['Amount'] = this.amount;
    data['InPrice'] = this.inPrice;
    data['Remark'] = this.remark;
    data['GeneralName'] = this.GeneralName;
    data['SampleID'] = this.SampleID;
    data['TenDonVi'] = this.TenDonVi;
    return data;
  }
}
