import 'package:eboss_tuonglong/services/NetWorkRequest.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:eboss_tuonglong/model/SongNgu/mobileapplanguge.dart';

class MobileLanguageProvider {
  // --- Singleton Pattern ---
  static Database? _database;
  static final MobileLanguageProvider instance =
      MobileLanguageProvider._privateConstructor();
  MobileLanguageProvider._privateConstructor();

  // --- Tên bảng và các cột ---
  // 2. SỬA LỖI: Thêm tên file database vào một hằng số để dễ quản lý.
  static const String _databaseName = 'eBOSS_XL_M.db';
  static const String _tableName = 'tblAppMobileLanguage';
  static const String _colNameID = 'NameID';
  static const String _colNameChinese = 'NameChinese';
  static const String _colNameVietnamese = 'NameVietnamese';
  static const String _colNameEnglish = 'NameEnglish';
  static const String _colNameOther = 'NameOther';
  static const String _colRemark = 'Remark';

  // --- Khởi tạo Database ---
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        $_colNameID TEXT PRIMARY KEY,
        $_colNameChinese TEXT,
        $_colNameVietnamese TEXT,
        $_colNameEnglish TEXT,
        $_colNameOther TEXT,
        $_colRemark TEXT
      )
    ''');
  }

  // --- HÀM TẠO DỮ LIỆU MẪU ---
  Future<void> _addInitialData(Database db) async {
    List<Data> initialData = [
      Data(
        nameID: 'ghichu',
        nameVietnamese: 'Xin chào nè',
        nameEnglish: 'Hello',
        nameChinese: '你好',
      ),
    ];

    Batch batch = db.batch();
    for (var model in initialData) {
      // 3. SỬA LỖI (Giả định): Dùng toJson() để khớp với model bạn đã tạo trước đó.
      // Nếu lớp Data của bạn dùng toMap() thì giữ nguyên.
      batch.insert(
        _tableName,
        model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
    print('Đã thêm dữ liệu mẫu vào database $_tableName');
  }

  Future<void> seedDatabase() async {
    final db = await instance.database;
    await _addInitialData(db);
  }

  // --- CÁC HÀM CRUD ---

  /// Cập nhật danh sách song ngữ mới.
  Future<void> UpDateLanguage() async {
    await deleteDatabaseFile();
    List<Data> languages = [];
    final db = await instance.database;

    final response = await NetWorkRequest.Get(
      "/api/MobileLanguage/GetAllAppMobileLanguage",
    );
    final parsed = MobileLanguageModel.fromJson(response);

    languages = parsed.data ?? [];

    Batch batch = db.batch();
    for (var model in languages) {
      batch.insert(
        _tableName,
        model.toJson(), // Dùng toJson() cho nhất quán
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    // 4. SỬA LỖI: Commit đúng 'batch' đã được thêm dữ liệu, không phải một batch mới.
    await batch.commit(noResult: true);
    print('Đã cập nhật lại ngôn ngữ.');
  }

  /// Thêm một bản ghi mới.
  Future<int> add(Data model) async {
    final db = await instance.database;
    return await db.insert(
      _tableName,
      model.toJson(), // Dùng toJson() cho nhất quán
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Lấy tất cả các bản ghi.
  Future<List<Data>> getAll() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    if (maps.isEmpty) {
      return [];
    }
    // 5. TỐI ƯU: Dùng fromSqliteRow để rõ ràng hơn về nguồn dữ liệu.
    return List.generate(maps.length, (i) => Data.fromSqliteRow(maps[i]));
  }

  /// Cập nhật một bản ghi.
  Future<int> update(Data model) async {
    final db = await instance.database;
    return await db.update(
      _tableName,
      model.toJson(), // Dùng toJson() cho nhất quán
      where: '$_colNameID = ?',
      whereArgs: [model.nameID],
    );
  }

  /// Xóa một bản ghi dựa trên NameID.
  Future<int> delete(String nameID) async {
    final db = await instance.database;
    return await db.delete(
      _tableName,
      where: '$_colNameID = ?',
      whereArgs: [nameID],
    );
  }

  Future<void> deleteDatabaseFile() async {
    String path = join(await getDatabasesPath(), _databaseName);
    await deleteDatabase(path);
    _database = null;
    print('Đã xóa file database $_databaseName.');
  }

  /// Kiểm tra xem database có tồn tại không.
  Future<bool> checkDatabaseExists() async {
    try {
      String databasesPath = await getDatabasesPath();
      // 6. SỬA LỖI: Đường dẫn phải là tên file database, không phải tên bảng.
      String path = join(databasesPath, _databaseName);
      bool exists = await databaseExists(path);
      print('Đường dẫn database $_databaseName đang kiểm tra: $path');
      return exists;
    } catch (e) {
      print('Lỗi khi kiểm tra sự tồn tại của database: $e');
      return false;
    }
  }
}
