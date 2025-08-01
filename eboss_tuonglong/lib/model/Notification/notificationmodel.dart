class NotificationModel {
  bool? succeeded;
  int? code;
  Null? message;
  Null? errors;
  List<Data>? data;

  NotificationModel(
      {this.succeeded, this.code, this.message, this.errors, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
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
  int? iD;
  String? employeeAID;
  String? tieuDe;
  String? noiDung;
  String? createDate;
  String? NhanVienKinhDoanh;
  String? nameVietnamese;
  String? TenCongTy;
  String? MaPhieuGiaoHang;

  Data(
      {this.iD,
      this.employeeAID,
      this.tieuDe,
      this.noiDung,
      this.createDate,
      this.NhanVienKinhDoanh,
      this.nameVietnamese,
      this.TenCongTy,
      this.MaPhieuGiaoHang});

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    employeeAID = json['EmployeeAID'];
    tieuDe = json['TieuDe'];
    noiDung = json['NoiDung'];
    createDate = json['CreateDate'];
    nameVietnamese = json['NameVietnamese'];
    NhanVienKinhDoanh = json['NhanVienKinhDoanh'] ?? "";
    TenCongTy = json['TenCongTy'] ?? "";
    MaPhieuGiaoHang = json['MaPhieuGiaoHang'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['EmployeeAID'] = this.employeeAID;
    data['TieuDe'] = this.tieuDe;
    data['NoiDung'] = this.noiDung;
    data['CreateDate'] = this.createDate;
    data['NameVietnamese'] = this.nameVietnamese;
    data['NhanVienKinhDoanh'] = this.NhanVienKinhDoanh;
    data['TenCongTy'] = this.TenCongTy;
    data['MaPhieuGiaoHang'] = this.MaPhieuGiaoHang;
    return data;
  }
}
