import 'package:eboss_tuonglong/model/SongNgu/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProductProvider {
  static Database? _database;
  static final ProductProvider instance = ProductProvider._privateConstructor();

  // Tên bảng và các cột
  static const String _tableName = 'products';
  static const String _colId = 'id';
  static const String _colName = 'name';
  static const String _colNameVietNam = 'nameVietNam';

  ProductProvider._privateConstructor();

  // Lấy thể hiện của database (singleton)
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Khởi tạo database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'product_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Hàm được gọi khi database được tạo lần đầu tiên
  Future<void> _onCreate(Database db, int version) async {
    // Tạo bảng products
    await db.execute('''
      CREATE TABLE $_tableName (
        $_colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $_colName TEXT NOT NULL,
        $_colNameVietNam TEXT NOT NULL
      )
    ''');
    // Thêm dữ liệu mẫu
    await _addInitialData(db);
  }

  // Hàm tự động thêm dữ liệu mẫu
  Future<void> _addInitialData(Database db) async {
    List<Product> initialProducts = [
      Product(name: 'Apple', nameVietNam: 'Táo'),
      Product(name: 'Banana', nameVietNam: 'Chuối'),
      Product(name: 'Orange', nameVietNam: 'Cam'),
      Product(name: 'Grape', nameVietNam: 'Nho'),
      Product(name: 'Watermelon', nameVietNam: 'Dưa hấu'),
      Product(name: 'Pineapple', nameVietNam: 'Dứa (Thơm)'),
      Product(name: 'Mango', nameVietNam: 'Xoài'),
    ];

    // Sử dụng batch để thêm nhiều sản phẩm cùng lúc cho hiệu quả
    Batch batch = db.batch();
    for (var product in initialProducts) {
      batch.insert(_tableName, product.toMap());
    }
    await batch.commit(noResult: true); // commit không trả về kết quả
    print('Đã thêm dữ liệu mẫu vào database.');
  }

  // --- CÁC HÀM CRUD ---

  // Thêm một sản phẩm mới
  Future<int> addProduct(Product product) async {
    Database db = await instance.database;
    return await db.insert(_tableName, product.toMap());
  }

  // Lấy tất cả sản phẩm từ database
  Future<List<Product>> getAllProducts() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    // Nếu không có dữ liệu, trả về danh sách rỗng
    if (maps.isEmpty) {
      return [];
    }

    // Chuyển đổi List<Map> thành List<Product>
    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }
  
  // (Tùy chọn) Xóa database để test lại hàm _addInitialData
  Future<void> deleteDatabaseFile() async {
    String path = join(await getDatabasesPath(), 'product_database.db');
    await deleteDatabase(path);
    _database = null; // Đặt lại để _initDatabase được gọi lại
    print('Đã xóa file database.');
  }
}