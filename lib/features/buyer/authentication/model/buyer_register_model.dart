import 'package:frontend_ecommerce/features/shared/model/error_response.dart';

class BuyerRegisterModel {
    BuyerRegisterModel({
        required this.status,
        required this.data,
    });

    final int? status;
    final Data? data;

    BuyerRegisterModel copyWith({
        int? status,
        Data? data,
    }) {
        return BuyerRegisterModel(
            status: status ?? this.status,
            data: data ?? this.data,
        );
    }

    factory BuyerRegisterModel.fromJson(Map<String, dynamic> json){ 
        return BuyerRegisterModel(
            status: json["status"],
            data: json["result"] == null ? null : Data.fromJson(json["result"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "status": status,
        "result": data?.toJson(),
    };

    @override
    String toString(){
        return "$status, $data, ";
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

class BuyerRegisterResponseModel{
  final BuyerRegisterModel? buyerRegisterModel;
  final ErrorResponseModel? errorResponseModel; 

  BuyerRegisterResponseModel({
    required this.buyerRegisterModel,
    required this.errorResponseModel
  });
}
