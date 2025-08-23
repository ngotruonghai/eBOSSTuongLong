class ChiTietYeuCauModel {
  bool? succeeded;
  int? code;
  Null? message;
  Null? errors;
  List<Data>? data;

  ChiTietYeuCauModel(
      {this.succeeded, this.code, this.message, this.errors, this.data});

  ChiTietYeuCauModel.fromJson(Map<String, dynamic> json) {
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
  String? inOrder;
  String? categoriesID;
  String? categoriesName;
  String? description;
  String? remark;
  String? sampleAID;

  Data(
      {
        this.inOrder,
        this.categoriesID,
        this.categoriesName,
        this.description,
        this.remark,
        this.sampleAID,
      });

  Data.fromJson(Map<String, dynamic> json) {
    inOrder = json['InOrder'];
    categoriesID = json['CategoriesID'];
    categoriesName = json['CategoriesName'];
    description = json['Description'];
    remark = json['Remark'];
    sampleAID = json['SampleAID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['InOrder'] = this.inOrder;
    data['CategoriesID'] = this.categoriesID;
    data['CategoriesName'] = this.categoriesName;
    data['Description'] = this.description;
    data['Remark'] = this.remark;
    data['SampleAID'] = this.sampleAID;
    return data;
  }
}
