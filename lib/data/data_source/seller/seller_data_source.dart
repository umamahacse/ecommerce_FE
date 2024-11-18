import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend_ecommerce/data/data_source/seller/seller_api_endpoints.dart';

import '../../../features/seller/authentication/model/seller_register_model.dart';
import '../../../features/seller/authentication/model/seller_register_request_model.dart';
import '../../../features/shared/model/error_response.dart';
import '../../config/dio_client.dart';

abstract class BuyerDataSource {

  Future<SellerRegisterResponseModel>? buyerRegister(BuildContext context, SellerRegisterRequestModel data);
  // Future<T>? buyerRegisterSocial<T,T1>(BuildContext context, T1? data);
  // Future<BuyerLoginResponseModel>? buyerLogin(BuildContext context, BuyerLoginRequestModel data);
}

class SellerDataSourceImpl implements BuyerDataSource{

  // @override
  // Future<T>? buyerRegisterSocial<T,T1>(BuildContext context, T1? data) async{
  //   final apiService = ApiService(context);
  //   ErrorResponseModel? errorResponseModel;
  //   SellerRegisterModel? buyerRegisterModel;
  //   Response response = await apiService.post(SellerApiEndpoints.sellerRegisterSocial, T1 == SellerRegisterRequestModel ? (data as SellerRegisterRequestModel).toJson() : (data as SellerLoginRequestModel).toJson());
  //   if(response.statusCode == 200){
  //     if(T == SellerRegisterResponseModel){
  //       buyerRegisterModel = SellerRegisterModel.fromJson(response.data);
  //     }else{
  //       buyerLoginModel = BuyerLoginModel.fromJson(response.data);
  //     }
  //   } else{
  //     errorResponseModel = ErrorResponseModel.fromJson(response.data);
  //   }
  //
  //   if(T == BuyerRegisterResponseModel){
  //     return BuyerRegisterResponseModel(buyerRegisterModel: buyerRegisterModel, errorResponseModel: errorResponseModel) as T;
  //   }else{
  //     return BuyerLoginResponseModel(buyerLoginResponseModel: buyerLoginModel, errorResponseModel: errorResponseModel) as T;
  //   }
  // }


  @override
  Future<SellerRegisterResponseModel>? buyerRegister(BuildContext context, SellerRegisterRequestModel data) async{
    final apiService = ApiService(context);
    ErrorResponseModel? errorResponseModel;
    SellerRegisterModel? buyerRegisterModel;

    Response response = await apiService.post(SellerApiEndpoints.sellerRegister, data);
    if(response.statusCode == 200){
      buyerRegisterModel = SellerRegisterModel.fromJson(response.data);
    } else{
      errorResponseModel = ErrorResponseModel.fromJson(response.data);
    }

    return SellerRegisterResponseModel(sellerRegisterModel: buyerRegisterModel, errorResponseModel: errorResponseModel);
  }


  // @override
  // Future<BuyerLoginResponseModel>? buyerLogin(BuildContext context, BuyerLoginRequestModel data) async {
  //   final apiService = ApiService(context);
  //   ErrorResponseModel? errorResponseModel;
  //   BuyerLoginModel? buyerLoginModel;
  //
  //   Response response = await apiService.post(BuyerApiEndpoints.buyerLogin, data.toJson());
  //   if(response.statusCode == 200){
  //     buyerLoginModel = BuyerLoginModel.fromJson(response.data);
  //   } else{
  //     errorResponseModel = ErrorResponseModel.fromJson(response.data);
  //   }
  //   return BuyerLoginResponseModel(buyerLoginResponseModel: buyerLoginModel, errorResponseModel: errorResponseModel);
  // }

}