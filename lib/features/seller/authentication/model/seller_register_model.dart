import 'package:frontend_ecommerce/features/shared/model/error_response.dart';

class SellerRegisterModel {
  SellerRegisterModel({
    required this.status,
    required this.data,
    this.accessToken
  });

  final int? status;
  final Data? data;
  final String? accessToken;

  SellerRegisterModel copyWith({
    int? status,
    Data? data,
    String? accessToken
  }) {
    return SellerRegisterModel(
        status: status ?? this.status,
        data: data ?? this.data,
        accessToken: accessToken
    );
  }

  factory SellerRegisterModel.fromJson(Map<String, dynamic> json){
    return SellerRegisterModel(
        status: json["status"],
        data: json["result"] == null ? null : Data.fromJson(json["result"]),
        accessToken: json["access_token"]
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": data?.toJson(),
    "access_token": accessToken
  };

  @override
  String toString(){
    return "$status, $data, $accessToken";
  }
}

class Data {
  Data({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.updatedAt,
    required this.createdAt,
  });

  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? confirmPassword;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  Data copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? confirmPassword,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return Data(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      password: json["password"],
      confirmPassword: json["confirmPassword"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    "confirmPassword": confirmPassword,
    "updatedAt": updatedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
  };

  @override
  String toString(){
    return "$id, $firstName, $lastName, $email, $password, $confirmPassword, $updatedAt, $createdAt, ";
  }
}

class SellerRegisterResponseModel{
  final SellerRegisterModel? sellerRegisterModel;
  final ErrorResponseModel? errorResponseModel;

  SellerRegisterResponseModel({
    required this.sellerRegisterModel,
    required this.errorResponseModel
  });
}
