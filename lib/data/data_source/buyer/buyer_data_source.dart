
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend_ecommerce/data/config/dio_client.dart';
import 'package:frontend_ecommerce/data/data_source/buyer/buyer_api_endpoints.dart';
import 'package:frontend_ecommerce/features/buyer/authentication/model/buyer_login_request_model.dart';
import 'package:frontend_ecommerce/features/buyer/authentication/model/buyer_login_model.dart';
import 'package:frontend_ecommerce/features/buyer/authentication/model/buyer_register_model.dart';
import 'package:frontend_ecommerce/features/buyer/authentication/model/buyer_register_request_model.dart';
import 'package:frontend_ecommerce/features/shared/model/error_response.dart';


abstract class BuyerDataSource {

    Future<BuyerRegisterResponseModel>? buyerRegister(BuildContext context, BuyerRegisterRequestModel data);
    Future<T>? buyerRegisterSocial<T,T1>(BuildContext context, T1? data);
    Future<BuyerLoginResponseModel>? buyerLogin(BuildContext context, BuyerLoginRequestModel data);
}

class BuyerDataSourceImpl implements BuyerDataSource{

  @override
  Future<T>? buyerRegisterSocial<T,T1>(BuildContext context, T1? data) async{
    final apiService = ApiService(context);
    ErrorResponseModel? errorResponseModel;
    BuyerRegisterModel? buyerRegisterModel;
    BuyerLoginModel? buyerLoginModel;
    Response response = await apiService.post(BuyerApiEndpoints.buyerRegisterSocial, T1 == BuyerRegisterRequestModel ? (data as BuyerRegisterRequestModel).toJson() : (data as BuyerLoginRequestModel).toJson());
    if(response.statusCode == 200){
      if(T == BuyerRegisterResponseModel){
        buyerRegisterModel = BuyerRegisterModel.fromJson(response.data);
      }else{
        buyerLoginModel = BuyerLoginModel.fromJson(response.data);
      }
    } else{
      errorResponseModel = ErrorResponseModel.fromJson(response.data);
    }

    if(T == BuyerRegisterResponseModel){
      return BuyerRegisterResponseModel(buyerRegisterModel: buyerRegisterModel, errorResponseModel: errorResponseModel) as T;
    }else{
      return BuyerLoginResponseModel(buyerLoginResponseModel: buyerLoginModel, errorResponseModel: errorResponseModel) as T;
    }
  }


  @override
  Future<BuyerRegisterResponseModel>? buyerRegister(BuildContext context, BuyerRegisterRequestModel data) async{
    final apiService = ApiService(context);
    ErrorResponseModel? errorResponseModel;
    BuyerRegisterModel? buyerRegisterModel;

    Response response = await apiService.post(BuyerApiEndpoints.buyerRegister, data);
    if(response.statusCode == 200){
      buyerRegisterModel = BuyerRegisterModel.fromJson(response.data); 
    } else{
      errorResponseModel = ErrorResponseModel.fromJson(response.data);
    }

    return BuyerRegisterResponseModel(buyerRegisterModel: buyerRegisterModel, errorResponseModel: errorResponseModel);
  }
  
  @override
  Future<BuyerLoginResponseModel>? buyerLogin(BuildContext context, BuyerLoginRequestModel data) async {
    final apiService = ApiService(context);
    ErrorResponseModel? errorResponseModel;
    BuyerLoginModel? buyerLoginModel;

    Response response = await apiService.post(BuyerApiEndpoints.buyerLogin, data.toJson());
    if(response.statusCode == 200){
      buyerLoginModel = BuyerLoginModel.fromJson(response.data);
    } else{
      errorResponseModel = ErrorResponseModel.fromJson(response.data);
    }
    return BuyerLoginResponseModel(buyerLoginResponseModel: buyerLoginModel, errorResponseModel: errorResponseModel);
  }

}
