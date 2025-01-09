import 'package:frontend_ecommerce/features/seller/authentication/model/seller_register_model.dart';

import '../../../shared/model/error_response.dart';

class SellerCreateContractModel {
  SellerCreateContractModel({
    required this.status,
    required this.data
  });

  final int? status;
  final Data? data;

  SellerCreateContractModel copyWith({
    int? status,
    Data? data,
    String? token
  }) {
    return SellerCreateContractModel(
        status: status ?? this.status,
        data: data ?? this.data
    );
  }

  factory SellerCreateContractModel.fromJson(Map<String, dynamic> json){
    return SellerCreateContractModel(
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
    return "$status, $data";
  }
}

class SellerCreateContractResponseModel{
  final SellerCreateContractModel? sellerCreateContractModel;
  final ErrorResponseModel? errorResponseModel;

  SellerCreateContractResponseModel({
    required this.sellerCreateContractModel,
    required this.errorResponseModel
  });
}