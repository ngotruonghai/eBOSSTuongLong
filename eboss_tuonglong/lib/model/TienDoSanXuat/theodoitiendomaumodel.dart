class TheoDoiTienDoMauModel {
  bool? succeeded;
  int? code;
  String? message;
  String? errors;
  List<Data>? data;

  TheoDoiTienDoMauModel(
      {this.succeeded, this.code, this.message, this.errors, this.data});

  TheoDoiTienDoMauModel.fromJson(Map<String, dynamic> json) {
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
  String? recordDate;
  String? maDonHang;
  String? tenKhachHang;
  String? nhanVienKinhDoanh;
  String? ngayCoSoi;
  String? ngayCoVaiMoc;
  String? ngayCoVaiThanhPhan;
  String? ngayCoKetQuaTest;
  String? ngayCoHanger;
  String? nhanXetHangNhapKho;

  Data(
      {this.sampleID,
      this.recordDate,
      this.maDonHang,
      this.tenKhachHang,
      this.nhanVienKinhDoanh,
      this.ngayCoSoi,
      this.ngayCoVaiMoc,
      this.ngayCoVaiThanhPhan,
      this.ngayCoKetQuaTest,
      this.ngayCoHanger,
      this.nhanXetHangNhapKho});

  Data.fromJson(Map<String, dynamic> json) {
    sampleID = json['SampleID'];
    recordDate = json['RecordDate'];
    maDonHang = json['MaDonHang'];
    tenKhachHang = json['TenKhachHang'];
    nhanVienKinhDoanh = json['NhanVienKinhDoanh'];
    ngayCoSoi = json['NgayCoSoi'];
    ngayCoVaiMoc = json['NgayCoVaiMoc'];
    ngayCoVaiThanhPhan = json['NgayCoVaiThanhPhan'];
    ngayCoKetQuaTest = json['NgayCoKetQuaTest'];
    ngayCoHanger = json['NgayCoHanger'];
    nhanXetHangNhapKho = json['NhanXetHangNhapKho'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SampleID'] = this.sampleID;
    data['RecordDate'] = this.recordDate;
    data['MaDonHang'] = this.maDonHang;
    data['TenKhachHang'] = this.tenKhachHang;
    data['NhanVienKinhDoanh'] = this.nhanVienKinhDoanh;
    data['NgayCoSoi'] = this.ngayCoSoi;
    data['NgayCoVaiMoc'] = this.ngayCoVaiMoc;
    data['NgayCoVaiThanhPhan'] = this.ngayCoVaiThanhPhan;
    data['NgayCoKetQuaTest'] = this.ngayCoKetQuaTest;
    data['NgayCoHanger'] = this.ngayCoHanger;
    data['NhanXetHangNhapKho'] = this.nhanXetHangNhapKho;
    return data;
  }
}
