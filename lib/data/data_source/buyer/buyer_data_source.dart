
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend_ecommerce/data/config/dio_client.dart';
import 'package:frontend_ecommerce/data/data_source/buyer/buyer_api_endpoints.dart';
import 'package:frontend_ecommerce/features/buyer/authentication/model/buyer_register_model.dart';
import 'package:frontend_ecommerce/features/buyer/authentication/model/buyer_register_request_model.dart';
import 'package:frontend_ecommerce/features/shared/model/error_response.dart';


abstract class BuyerDataSource {

    Future<BuyerRegisterResponseModel>? buyerRegister(BuildContext context, BuyerRegisterRequestModel data);
    Future<BuyerRegisterResponseModel>? buyerRegisterSocial(BuildContext context, BuyerRegisterRequestModel data);
}

class BuyerDataSourceImpl implements BuyerDataSource{

  @override
  Future<BuyerRegisterResponseModel>? buyerRegisterSocial(BuildContext context, BuyerRegisterRequestModel data) async{
    final apiService = ApiService(context);
    ErrorResponseModel? errorResponseModel;
    BuyerRegisterModel? buyerRegisterModel;

    Response response = await apiService.post(BuyerApiEndpoints.buyerRegisterSocial, data.toJson());
    print("response.statusCode ${response.statusCode}");
    if(response.statusCode == 200){
      buyerRegisterModel = BuyerRegisterModel.fromJson(response.data);
    } else{
      errorResponseModel = ErrorResponseModel.fromJson(response.data);
    }

    return BuyerRegisterResponseModel(buyerRegisterModel: buyerRegisterModel, errorResponseModel: errorResponseModel);
  }


  @override
  Future<BuyerRegisterResponseModel>? buyerRegister(BuildContext context, BuyerRegisterRequestModel data) async{
    final apiService = ApiService(context);
    ErrorResponseModel? errorResponseModel;
    BuyerRegisterModel? buyerRegisterModel;

    Response response = await apiService.post(BuyerApiEndpoints.buyerRegister, data);
    print("response.statusCode ${response.statusCode}");
    if(response.statusCode == 200){
      buyerRegisterModel = BuyerRegisterModel.fromJson(response.data); 
    } else{
      errorResponseModel = ErrorResponseModel.fromJson(response.data);
    }

    return BuyerRegisterResponseModel(buyerRegisterModel: buyerRegisterModel, errorResponseModel: errorResponseModel);
  }

}
