class DanhSachPhieuMuaHangModel {
  bool? succeeded;
  int? code;
  Null? message;
  Null? errors;
  List<Data>? data;

  DanhSachPhieuMuaHangModel(
      {this.succeeded, this.code, this.message, this.errors, this.data});

  DanhSachPhieuMuaHangModel.fromJson(Map<String, dynamic> json) {
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
  String? deliveryAID;
  String? deliveryID;
  String? maPhieu;
  String? nhanVienXuLy;
  String? nhanVienKinhDoanh;
  String? tenKhachHang;
  String? recordDate;
  String? loaiPhieu;
  String? statusID;
  String? nguoiDuyet;
  String? nguoiKiemTra;
  int? soNgayQuahan;
  String? responseDate;
  String? responseDay;
  int? stattustSoNgayDaQua;
  String? YKienKhachHang;
  String? YKienLanhDao;

  Data(
      {this.deliveryAID,
      this.deliveryID,
      this.maPhieu,
      this.nhanVienXuLy,
      this.nhanVienKinhDoanh,
      this.tenKhachHang,
      this.recordDate,
      this.loaiPhieu,
      this.statusID,
      this.nguoiDuyet,
      this.nguoiKiemTra,
      this.soNgayQuahan,
      this.responseDate,
      this.responseDay,
      this.stattustSoNgayDaQua,
      this.YKienLanhDao});

  Data.fromJson(Map<String, dynamic> json) {
    deliveryAID = json['DeliveryAID'];
    deliveryID = json['DeliveryID'];
    maPhieu = json['MaPhieu'];
    nhanVienXuLy = json['NhanVienXuLy'];
    nhanVienKinhDoanh = json['NhanVienKinhDoanh'];
    tenKhachHang = json['TenKhachHang'];
    recordDate = json['RecordDate'];
    loaiPhieu = json['LoaiPhieu'];
    statusID = json['StatusID'];
    nguoiDuyet = json['NguoiDuyet'];
    nguoiKiemTra = json['NguoiKiemTra'];
    soNgayQuahan = json['SoNgayQuahan'];
    responseDate = json['ResponseDate'];
    responseDay = json['ResponseDay'];
    stattustSoNgayDaQua = json['StattustSoNgayDaQua'];
    YKienKhachHang = json['YKienKhachHang'];
    YKienLanhDao = json['YKienLanhDao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DeliveryAID'] = this.deliveryAID;
    data['DeliveryID'] = this.deliveryID;
    data['MaPhieu'] = this.maPhieu;
    data['NhanVienXuLy'] = this.nhanVienXuLy;
    data['NhanVienKinhDoanh'] = this.nhanVienKinhDoanh;
    data['TenKhachHang'] = this.tenKhachHang;
    data['RecordDate'] = this.recordDate;
    data['LoaiPhieu'] = this.loaiPhieu;
    data['StatusID'] = this.statusID;
    data['NguoiDuyet'] = this.nguoiDuyet;
    data['NguoiKiemTra'] = this.nguoiKiemTra;
    data['SoNgayQuahan'] = this.soNgayQuahan;
    data['ResponseDate'] = this.responseDate;
    data['ResponseDay'] = this.responseDay;
    data['StattustSoNgayDaQua'] = this.stattustSoNgayDaQua;
    data['YKienKhachHang'] = this.YKienKhachHang; 
    data['YKienLanhDao'] = this.YKienLanhDao; 
    return data;
  }
}
