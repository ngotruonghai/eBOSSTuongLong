class DanhSachChiTietPhieuGiaoHangModel {
  bool? succeeded;
  int? code;
  Null? message;
  Null? errors;
  List<Data>? data;

  DanhSachChiTietPhieuGiaoHangModel(
      {this.succeeded, this.code, this.message, this.errors, this.data});

  DanhSachChiTietPhieuGiaoHangModel.fromJson(Map<String, dynamic> json) {
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
  String? maHang;
  String? tenSanPham;
  String? ghiChu;
  double? soLuong;
  String? donViTinh;

  Data(
      {this.maHang,
      this.tenSanPham,
      this.ghiChu,
      this.soLuong,
      this.donViTinh});

  Data.fromJson(Map<String, dynamic> json) {
    maHang = json['MaHang'];
    tenSanPham = json['TenSanPham'];
    ghiChu = json['GhiChu'];
    soLuong = json['SoLuong'];
    donViTinh = json['DonViTinh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MaHang'] = this.maHang;
    data['TenSanPham'] = this.tenSanPham;
    data['GhiChu'] = this.ghiChu;
    data['SoLuong'] = this.soLuong;
    data['DonViTinh'] = this.donViTinh;
    return data;
  }
}
