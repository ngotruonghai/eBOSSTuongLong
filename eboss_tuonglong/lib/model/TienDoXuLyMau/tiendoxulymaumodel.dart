class TienDoXuLyMauModel {
  bool? succeeded;
  int? code;
  String? message;
  String? errors;
  List<Data>? data;

  TienDoXuLyMauModel(
      {this.succeeded, this.code, this.message, this.errors, this.data});

  TienDoXuLyMauModel.fromJson(Map<String, dynamic> json) {
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
  String? processAID;
  String? processID;
  String? recordDate;
  String? productID;
  String? unitID;
  String? unitName;
  String? qty;
  String? trousersUnitID;
  String? trouserUnitName;
  String? trousersQty;
  String? shirtUnitID;
  String? shirtUnitName;
  String? shirtQty;
  String? customerAID;
  String? customerName;
  String? salesManAID;
  String? salesManName;
  String? commentsProduct;
  String? sewingDate;
  String? factoryWashDate;
  String? smartLabDate;
  String? sampleInnerInDate;
  int? isColorRed;
  String? statusColor;


  Data({
      this.processAID,
      this.processID,
      this.recordDate,
      this.productID,
      this.unitID,
      this.unitName,
      this.qty,
      this.trousersUnitID,
      this.trouserUnitName,
      this.trousersQty,
      this.shirtUnitID,
      this.shirtUnitName,
      this.shirtQty,
      this.customerAID,
      this.customerName,
      this.salesManAID,
      this.salesManName,
      this.commentsProduct,
      this.sewingDate,
      this.factoryWashDate,
      this.smartLabDate,
      this.sampleInnerInDate,
      this.isColorRed,
      this.statusColor,
    });

  Data.fromJson(Map<String, dynamic> json) {
    processAID = json['ProcessAID'];
    processID = json['ProcessID'];
    recordDate = json['RecordDate'];
    productID = json['ProductID'];
    unitID = json['UnitID'];
    unitName = json['UnitName'];
    qty = json['Qty'];
    trousersUnitID = json['TrousersUnitID'];
    trouserUnitName = json['TrouserUnitName'];
    trousersQty = json['TrousersQty'];
    shirtUnitID = json['ShirtUnitID'];
    shirtUnitName = json['ShirtUnitName'];
    shirtQty = json['ShirtQty'];
    customerAID = json['CustomerAID'];
    customerName = json['CustomerName'];
    salesManAID = json['SalesManAID'];
    salesManName = json['SalesManName'];
    commentsProduct = json['CommentsProduct'];
    sewingDate = json['SewingDate'];
    factoryWashDate = json['FactoryWashDate'];
    smartLabDate = json['SmartLabDate'];
    sampleInnerInDate = json['SampleInnerInDate'];
    isColorRed = json['IsColorRed'];
    statusColor = json['StatusColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProcessAID'] = this.processAID;
    data['ProcessID'] = this.processID;
    data['RecordDate'] = this.recordDate;
    data['ProductID'] = this.productID;
    data['UnitID'] = this.unitID;
    data['UnitName'] = this.unitName;
    data['Qty'] = this.qty;
    data['TrousersUnitID'] = this.trousersUnitID;
    data['TrouserUnitName'] = this.trouserUnitName;
    data['TrousersQty'] = this.trousersQty;
    data['ShirtUnitID'] = this.shirtUnitID;
    data['ShirtUnitName'] = this.shirtUnitName;
    data['ShirtQty'] = this.shirtQty;
    data['CustomerAID'] = this.customerAID;
    data['CustomerName'] = this.customerName;
    data['SalesManAID'] = this.salesManAID;
    data['SalesManName'] = this.salesManName;
    data['CommentsProduct'] = this.commentsProduct;
    data['SewingDate'] = this.sewingDate;
    data['FactoryWashDate'] = this.factoryWashDate;
    data['SmartLabDate'] = this.smartLabDate;
    data['SampleInnerInDate'] = this.sampleInnerInDate;
    data['IsColorRed'] = this.isColorRed;
    data['StatusColor'] = this.statusColor;
    return data;
  }
}
