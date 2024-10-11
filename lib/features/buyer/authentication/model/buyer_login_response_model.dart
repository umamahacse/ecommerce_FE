import 'package:frontend_ecommerce/features/shared/model/error_response.dart';

class BuyerLoginResponseModel {
    BuyerLoginResponseModel({
        required this.status,
        required this.accessToken,
        required this.userId,
    });

    final int? status;
    final String? accessToken;
    final int? userId;

    BuyerLoginResponseModel copyWith({
        int? status,
        String? accessToken,
        int? userId,
    }) {
        return BuyerLoginResponseModel(
            status: status ?? this.status,
            accessToken: accessToken ?? this.accessToken,
            userId: userId ?? this.userId,
        );
    }

    factory BuyerLoginResponseModel.fromJson(Map<String, dynamic> json){ 
        return BuyerLoginResponseModel(
            status: json["status"],
            accessToken: json["access_token"],
            userId: json["user_id"],
        );
    }

    Map<String, dynamic> toJson() => {
        "status": status,
        "access_token": accessToken,
        "user_id": userId,
    };

    @override
    String toString(){
        return "$status, $accessToken, $userId, ";
    }
}

class BuyerLoginModel{
  final BuyerLoginResponseModel? buyerLoginResponseModel;
  final ErrorResponseModel? errorResponseModel; 

  BuyerLoginModel({
    required this.buyerLoginResponseModel,
    required this.errorResponseModel
  });
}