import 'dart:async';

/// Lớp này đại diện cho cấu trúc phản hồi từ API.
class MobileLanguageModel {
  bool? succeeded;
  int? code;
  String? message;
  String? errors;
  List<Data>? data;

  MobileLanguageModel(
      {this.succeeded, this.code, this.message, this.errors, this.data});

  /// Factory constructor để phân tích JSON từ API.
  MobileLanguageModel.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    code = json['code'];
    message = json['message'];
    errors = json['errors'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
  
  // --- HÀM MỚI ĐƯỢC THÊM VÀO ---
  /// Factory constructor để "gói" dữ liệu từ SQLite vào cấu trúc này.
  /// Nó nhận vào một danh sách các bản ghi từ SQLite và tạo ra một đối tượng MobileLanguageModel.
  factory MobileLanguageModel.fromSqliteList(List<Map<String, dynamic>> sqliteData) {
    // 1. Chuyển đổi List<Map> từ SQLite thành List<Data>.
    List<Data> dataList = sqliteData.map((item) => Data.fromSqliteRow(item)).toList();

    // 2. Tạo và trả về một đối tượng MobileLanguageModel hoàn chỉnh.
    //    Chúng ta có thể tự gán các giá trị như 'succeeded' và 'code'.
    return MobileLanguageModel(
      succeeded: true,
      code: 200, // Giả sử mã 200 là thành công
      message: 'Data loaded successfully from local database.',
      data: dataList,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['succeeded'] = succeeded;
    data['code'] = code;
    data['message'] = message;
    data['errors'] = errors;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/// Lớp này đại diện cho một bản ghi ngôn ngữ.
class Data {
  String? nameID;
  String? nameChinese;
  String? nameVietnamese;
  String? nameEnglish;
  String? nameOther;
  String? remark;

  Data(
      {this.nameID,
      this.nameChinese,
      this.nameVietnamese,
      this.nameEnglish,
      this.nameOther,
      this.remark});

  /// Hàm này dùng để phân tích JSON từ API.
  Data.fromJson(Map<String, dynamic> json) {
    nameID = json['NameID'];
    nameChinese = json['NameChinese'];
    nameVietnamese = json['NameVietnamese'];
    nameEnglish = json['NameEnglish'];
    nameOther = json['NameOther'];
    remark = json['Remark'];
  }

  // --- HÀM MỚI ĐƯỢC THÊM VÀO ---
  /// Factory constructor để tạo đối tượng Data từ một hàng (row) của SQLite.
  /// Tên hàm được đổi để rõ ràng hơn.
  factory Data.fromSqliteRow(Map<String, dynamic> sqliteRow) {
    return Data(
      nameID: sqliteRow['NameID'],
      nameChinese: sqliteRow['NameChinese'],
      nameVietnamese: sqliteRow['NameVietnamese'],
      nameEnglish: sqliteRow['NameEnglish'],
      nameOther: sqliteRow['NameOther'],
      remark: sqliteRow['Remark'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['NameID'] = nameID;
    data['NameChinese'] = nameChinese;
    data['NameVietnamese'] = nameVietnamese;
    data['NameEnglish'] = nameEnglish;
    data['NameOther'] = nameOther;
    data['Remark'] = remark;
    return data;
  }
}