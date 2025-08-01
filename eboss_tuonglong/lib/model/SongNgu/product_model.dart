// lib/models/product_model.dart
class Product {
  int? id; // id có thể null khi thêm mới (AUTOINCREMENT)
  String name;
  String nameVietNam;

  Product({this.id, required this.name, required this.nameVietNam});

  // Chuyển đổi từ Map (từ DB) sang đối tượng Product
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      nameVietNam: map['nameVietNam'],
    );
  }

  // Chuyển đổi từ đối tượng Product sang Map (để lưu vào DB)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nameVietNam': nameVietNam,
    };
  }

  // Phương thức tiện ích để in ra console
  @override
  String toString() {
    return 'Product(id: $id, name: $name, nameVietNam: $nameVietNam)';
  }
}