import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.email,
    this.fullName,
    this.specification,
    this.password,
  });

  String? email;
  String? fullName;
  String? specification;
  String? password;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(
        email: json["email"] == null ? null : json["email"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        specification: json["specification"] == null ? null : json["specification"],
        password: json["password"] == null ? null : json["password"],
      );

  Map<String, dynamic> toJson() =>
      {
        "email": email == null ? null : email,
        "full_name": fullName == null ? null : fullName,
        "specification": specification == null ? null : specification,
        "password": password == null ? null : password,
      };
}

class LoginModel {
  LoginModel({
    this.email,
    this.password,
  });

  String? email;
  String? password;

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      LoginModel(
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
      );

  Map<String, dynamic> toJson() =>
      {
        "email": email == null ? null : email,
        "password": password == null ? null : password,
      };
}
