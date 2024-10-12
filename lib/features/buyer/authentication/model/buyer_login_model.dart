import 'package:frontend_ecommerce/features/shared/model/error_response.dart';

class BuyerLoginModel{
    BuyerLoginModel({
        required this.status,
        this.accessToken,
        required this.data,
        required this.userId,
    });

    final int? status;
    final String? accessToken;
    final int? userId;
    final Data? data;

    BuyerLoginModel copyWith({
        int? status,
        String? accessToken,
        int? userId,
        Data? data
    }) {
        return BuyerLoginModel(
            status: status ?? this.status,
            accessToken: accessToken ?? this.accessToken,
            userId: userId ?? this.userId,
            data: data ?? this.data
        );
    }

    factory BuyerLoginModel.fromJson(Map<String, dynamic> json){
        return BuyerLoginModel(
            status: json["status"],
            accessToken: json["access_token"],
            userId: json["user_id"],
            data: json["buyerData"] == null ? null : Data.fromJson(json["buyerData"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "status": status,
        "access_token": accessToken,
        "user_id": userId,
        "buyerData": data?.toJson(),
    };

    @override
    String toString(){
        return "$status, $accessToken, $userId, ${data?.toJson()}";
    }
}

class Data {
    Data({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.password,
        required this.updatedAt,
        required this.createdAt,
    });

    final int? id;
    final String? firstName;
    final String? lastName;
    final String? email;
    final String? password;
    final DateTime? updatedAt;
    final DateTime? createdAt;

    Data copyWith({
        int? id,
        String? firstName,
        String? lastName,
        String? email,
        String? password,
        DateTime? updatedAt,
        DateTime? createdAt,
    }) {
        return Data(
            id: id ?? this.id,
            firstName: firstName ?? this.firstName,
            lastName: lastName ?? this.lastName,
            email: email ?? this.email,
            password: password ?? this.password,
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
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
    };

    @override
    String toString(){
        return "$id, $firstName, $lastName, $email, $password, $updatedAt, $createdAt, ";
    }
}

class BuyerLoginResponseModel{
  final BuyerLoginModel? buyerLoginResponseModel;
  final ErrorResponseModel? errorResponseModel;

  BuyerLoginResponseModel({
    required this.buyerLoginResponseModel,
    required this.errorResponseModel
  });
}