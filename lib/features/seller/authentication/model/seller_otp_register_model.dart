import 'package:frontend_ecommerce/features/seller/authentication/model/seller_register_model.dart';

import '../../../shared/model/error_response.dart';

class SellerOTPRegisterModel {
  SellerOTPRegisterModel({
    required this.status,
    required this.data,
    this.otp
  });

  final int? status;
  final Data? data;
  final String? otp;

  SellerOTPRegisterModel copyWith({
    int? status,
    Data? data,
    String? otp
  }) {
    return SellerOTPRegisterModel(
        status: status ?? this.status,
        data: data ?? this.data,
        otp: otp
    );
  }

  factory SellerOTPRegisterModel.fromJson(Map<String, dynamic> json){
    return SellerOTPRegisterModel(
        status: json["status"],
        data: json["result"] == null ? null : Data.fromJson(json["result"]),
        otp: json["otp"]
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": data?.toJson(),
    "otp": otp
  };

  @override
  String toString(){
    return "$status, $data, $otp";
  }
}

class SellerOTPResponseModel{
  final SellerOTPRegisterModel? sellerOTPRegisterModel;
  final ErrorResponseModel? errorResponseModel;

  SellerOTPResponseModel({
    required this.sellerOTPRegisterModel,
    required this.errorResponseModel
  });
}