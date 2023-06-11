// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String? name;
  final String? id;
  final String? email;

  UserModel({
    this.name,
    this.id,
    this.email,
  });

  UserModel copyWith({
    String? name,
    String? id,
    String? email,
  }) =>
      UserModel(
        name: name ?? this.name,
        id: id ?? this.id,
        email: email ?? this.email,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        id: json["id"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "email": email,
      };
}
