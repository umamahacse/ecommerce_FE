import 'package:frontend_ecommerce/features/seller/authentication/model/seller_register_model.dart';

import '../../../shared/model/error_response.dart';

class SellerVerifyOTPRegisterModel {
  SellerVerifyOTPRegisterModel({
    required this.status,
    required this.data,
    required this.token
  });

  final int? status;
  final Data? data;
  final String? token;

  SellerVerifyOTPRegisterModel copyWith({
    int? status,
    Data? data,
    String? token
  }) {
    return SellerVerifyOTPRegisterModel(
        status: status ?? this.status,
        data: data ?? this.data,
        token: token ?? this.token
    );
  }

  factory SellerVerifyOTPRegisterModel.fromJson(Map<String, dynamic> json){
    return SellerVerifyOTPRegisterModel(
        status: json["status"],
        data: json["result"] == null ? null : Data.fromJson(json["result"]),
        token: json["token"]
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": data?.toJson(),
    "token" : token
  };

  @override
  String toString(){
    return "$status, $data";
  }
}

class SellerVerifyOTPResponseModel{
  final SellerVerifyOTPRegisterModel? sellerVerifyOTPRegisterModel;
  final ErrorResponseModel? errorResponseModel;

  SellerVerifyOTPResponseModel({
    required this.sellerVerifyOTPRegisterModel,
    required this.errorResponseModel
  });
}