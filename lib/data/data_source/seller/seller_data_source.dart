import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend_ecommerce/data/data_source/seller/seller_api_endpoints.dart';
import 'package:frontend_ecommerce/features/seller/authentication/model/seller_create_contract_request_model.dart';
import 'package:frontend_ecommerce/features/seller/authentication/model/seller_create_contract_response_model.dart';
import 'package:frontend_ecommerce/features/seller/authentication/model/seller_otp_verify_request_model.dart';
import 'package:frontend_ecommerce/features/seller/authentication/model/seller_otp_verify_response_model.dart';

import '../../../features/seller/authentication/model/seller_otp_register_model.dart';
import '../../../features/seller/authentication/model/seller_register_model.dart';
import '../../../features/seller/authentication/model/seller_otp_request_model.dart';
import '../../../features/seller/authentication/model/seller_register_request_model.dart';
import '../../../features/shared/model/error_response.dart';
import '../../config/dio_client.dart';

abstract class BuyerDataSource {

  Future<SellerRegisterResponseModel>? sellerRegister(BuildContext context, SellerRegisterRequestModel data);
  Future<SellerOTPResponseModel>? generateOtp(BuildContext context, SellerOTPRequestModel data);
  Future<SellerVerifyOTPResponseModel>? verifyOtp(BuildContext context, SellerOTPVerifyRequestModel data);
  Future<SellerCreateContractResponseModel>? createContract(BuildContext context, SellerCreateContractRequestModel data);
  Future<SellerCreateContractResponseModel>? getContractDetails(BuildContext context);
}

class SellerDataSourceImpl implements BuyerDataSource{

  @override
  Future<SellerRegisterResponseModel>? sellerRegister(BuildContext context, SellerRegisterRequestModel data) async{
    try{
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
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<SellerOTPResponseModel>? generateOtp(BuildContext context, SellerOTPRequestModel data) async{
    try{
      final apiService = ApiService(context);
      ErrorResponseModel? errorResponseModel;
      SellerOTPRegisterModel? sellerOTPRegisterModel;

      Response response = await apiService.post(SellerApiEndpoints.sellerGenerateOTP, data);
      if(response.statusCode == 200){
        sellerOTPRegisterModel = SellerOTPRegisterModel.fromJson(response.data);
      } else{
        errorResponseModel = ErrorResponseModel.fromJson(response.data);
      }

      return SellerOTPResponseModel(sellerOTPRegisterModel: sellerOTPRegisterModel, errorResponseModel: errorResponseModel);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<SellerVerifyOTPResponseModel>? verifyOtp(BuildContext context, SellerOTPVerifyRequestModel data) async{
    try{
      final apiService = ApiService(context);
      ErrorResponseModel? errorResponseModel;
      SellerVerifyOTPRegisterModel? sellerVerifyOTPRegisterModel;

      Response response = await apiService.post(SellerApiEndpoints.sellerVerifyOTP, data);
      if(response.statusCode == 200){
        sellerVerifyOTPRegisterModel = SellerVerifyOTPRegisterModel.fromJson(response.data);
      } else{
        errorResponseModel = ErrorResponseModel.fromJson(response.data);
      }

      return SellerVerifyOTPResponseModel(sellerVerifyOTPRegisterModel: sellerVerifyOTPRegisterModel, errorResponseModel: errorResponseModel);
    }catch(e){
      rethrow;
    }

  }


  @override
  Future<SellerCreateContractResponseModel>? createContract(BuildContext context, SellerCreateContractRequestModel data) async{
    try{
      final apiService = ApiService(context);
      ErrorResponseModel? errorResponseModel;
      SellerCreateContractModel? sellerCreateContractModel;

      Response response = await apiService.post(SellerApiEndpoints.sellerCreateContract, data.toJson());
      if(response.statusCode == 200){
        sellerCreateContractModel = SellerCreateContractModel.fromJson(response.data);
      } else{
        errorResponseModel = ErrorResponseModel.fromJson(response.data);
      }

      return SellerCreateContractResponseModel(sellerCreateContractModel: sellerCreateContractModel, errorResponseModel: errorResponseModel);
    }catch(e){
      rethrow;
    }

  }


  @override
  Future<SellerCreateContractResponseModel>? getContractDetails(BuildContext context) async{
    try{
      final apiService = ApiService(context);
      ErrorResponseModel? errorResponseModel;
      SellerCreateContractModel? sellerCreateContractModel;

      Response response = await apiService.get(SellerApiEndpoints.getCreateContractDetails);
      if(response.statusCode == 200){
        sellerCreateContractModel = SellerCreateContractModel.fromJson(response.data);
      } else{
        errorResponseModel = ErrorResponseModel.fromJson(response.data);
      }

      return SellerCreateContractResponseModel(sellerCreateContractModel: sellerCreateContractModel, errorResponseModel: errorResponseModel);
    }catch(e){
      rethrow;
    }

  }


}