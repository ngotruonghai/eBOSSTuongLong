List<ChiTietPhieuMuaHangModel> chitietphieumuahang = [
  ChiTietPhieuMuaHangModel(
    maHang: "TL83994",
    tenSanPham: "Vải TL83994",
    donViTinh: "Yard",
    soLuong: 9.0,
    ghiChu: "FOC, may hanger TL",
  ),
  ChiTietPhieuMuaHangModel(
    maHang: "TL724140",
    tenSanPham: "Vải TL72414009",
    donViTinh: "Yard",
    soLuong: 4.5,
    ghiChu: "FOC, may hanger TL",
  ),
  // Dữ liệu trống để kiểm tra hiển thị bảng
  ChiTietPhieuMuaHangModel(
    maHang: "",
    tenSanPham: "",
    donViTinh: "",
    soLuong: null,
    ghiChu: "",
  ),
];

class ChiTietPhieuMuaHangModel {
  final String? maHang;
  final String? tenSanPham;
  final String? donViTinh;
  final double? soLuong;
  final String? ghiChu;

  ChiTietPhieuMuaHangModel({
    required this.maHang,
    required this.tenSanPham,
    required this.donViTinh,
    required this.soLuong,
    required this.ghiChu,
  });
}
