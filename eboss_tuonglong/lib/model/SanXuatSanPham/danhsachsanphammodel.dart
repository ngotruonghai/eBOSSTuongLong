class DanhSachSanPhamModel {
  bool? succeeded;
  int? code;
  Null? message;
  Null? errors;
  List<Data>? data;

  DanhSachSanPhamModel(
      {this.succeeded, this.code, this.message, this.errors, this.data});

  DanhSachSanPhamModel.fromJson(Map<String, dynamic> json) {
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
  String? sampleID;
  String? parentSampleAID;
  String? recordDate;
  String? customerName;
  String? refOrderID;
  String? salesManAID;
  String? finishProduceDate;
  String? stockInDate;
  String? deliveryDate;
  String? responseDate;
  int? produceDay;
  int? responseDay;
  double? requestQty;
  double? stockInQty;
  double? deliveryQty;
  bool? isFinish;
  String? finishStatus;
  String? sampleAID;
  String? nhanVienKinhDoanh;
  String? tenKhachHang;
  String? yKienKhachHang;
  String? yKkienDanhGia;

  Data(
      {this.sampleID,
      this.parentSampleAID,
      this.recordDate,
      this.customerName,
      this.refOrderID,
      this.salesManAID,
      this.finishProduceDate,
      this.stockInDate,
      this.deliveryDate,
      this.responseDate,
      this.produceDay,
      this.responseDay,
      this.requestQty,
      this.stockInQty,
      this.deliveryQty,
      this.isFinish,
      this.finishStatus,
      this.sampleAID,
      this.nhanVienKinhDoanh,
      this.tenKhachHang,
      this.yKienKhachHang,
      this.yKkienDanhGia});

  Data.fromJson(Map<String, dynamic> json) {
    sampleID = json['SampleID'];
    parentSampleAID = json['ParentSampleAID'];
    recordDate = json['RecordDate'];
    customerName = json['CustomerName'];
    refOrderID = json['RefOrderID'];
    salesManAID = json['SalesManAID'];
    finishProduceDate = json['FinishProduceDate'];
    stockInDate = json['StockInDate'];
    deliveryDate = json['DeliveryDate'];
    responseDate = json['ResponseDate'];
    produceDay = json['ProduceDay'];
    responseDay = json['ResponseDay'];
    requestQty = json['RequestQty'];
    stockInQty = json['StockInQty'];
    deliveryQty = json['DeliveryQty'];
    isFinish = json['IsFinish'];
    finishStatus = json['FinishStatus'];
    sampleAID = json['SampleAID'];
    nhanVienKinhDoanh = json['NhanVienKinhDoanh'];
    tenKhachHang = json['TenKhachHang'];
    yKienKhachHang = json['YKienKhachHang'];
    yKkienDanhGia = json['YKkienDanhGia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SampleID'] = this.sampleID;
    data['ParentSampleAID'] = this.parentSampleAID;
    data['RecordDate'] = this.recordDate;
    data['CustomerName'] = this.customerName;
    data['RefOrderID'] = this.refOrderID;
    data['SalesManAID'] = this.salesManAID;
    data['FinishProduceDate'] = this.finishProduceDate;
    data['StockInDate'] = this.stockInDate;
    data['DeliveryDate'] = this.deliveryDate;
    data['ResponseDate'] = this.responseDate;
    data['ProduceDay'] = this.produceDay;
    data['ResponseDay'] = this.responseDay;
    data['RequestQty'] = this.requestQty;
    data['StockInQty'] = this.stockInQty;
    data['DeliveryQty'] = this.deliveryQty;
    data['IsFinish'] = this.isFinish;
    data['FinishStatus'] = this.finishStatus;
    data['SampleAID'] = this.sampleAID;
    data['NhanVienKinhDoanh'] = this.nhanVienKinhDoanh;
    data['TenKhachHang'] = this.tenKhachHang;
    data['YKienKhachHang'] = this.yKienKhachHang;
    data['YKienLanhDao'] = this.yKkienDanhGia;
    return data;
  }
}
