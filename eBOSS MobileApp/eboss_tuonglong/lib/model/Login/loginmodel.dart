class LoginModel {
  bool? succeeded;
  int? code;
  Null? message;
  Null? errors;
  Data? data;

  LoginModel({this.succeeded, this.code, this.message, this.errors, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    code = json['code'];
    message = json['message'];
    errors = json['errors'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['succeeded'] = this.succeeded;
    data['code'] = this.code;
    data['message'] = this.message;
    data['errors'] = this.errors;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;
  String? refreshToken;
  String? message;
  String? userID;
  String? userName;
  String? employeeAID;
  String? password;
  bool? allowAccess;

  Data(
      {this.token,
      this.refreshToken,
      this.message,
      this.userID,
      this.userName,
      this.employeeAID,
      this.password,
      this.allowAccess});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
    message = json['message'];
    userID = json['userID'];
    userName = json['userName'];
    employeeAID = json['employeeAID'];
    password = json['password'];
    allowAccess = json['allowAccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    data['message'] = this.message;
    data['userID'] = this.userID;
    data['userName'] = this.userName;
    data['employeeAID'] = this.employeeAID;
    data['password'] = this.password;
    data['allowAccess'] = this.allowAccess;
    return data;
  }
}
