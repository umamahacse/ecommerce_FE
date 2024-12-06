import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend_ecommerce/features/seller/authentication/model/seller_otp_request_model.dart';
import 'package:frontend_ecommerce/features/seller/authentication/model/seller_otp_verify_request_model.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widget/shared/custom_snackbar.dart';
import '../../../../data/data_source/seller/seller_data_source.dart';
import '../../../../data/secured_storage/secured_storage.dart';
import '../../../../route/router_constant.dart';
import '../../../../utils/validators/pattern_validator.dart';
import '../model/seller_register_model.dart';
import '../model/seller_register_request_model.dart';

class SellerRegisterViewModel extends ChangeNotifier{
  final SellerDataSourceImpl sellerDataSource = SellerDataSourceImpl();
  TextEditingController firstNameController = TextEditingController(text: "");
  TextEditingController lastNameController = TextEditingController(text: "");
  TextEditingController phoneNumberController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController confirmPasswordController =
  TextEditingController(text: "");
  final GlobalKey<FormState> firstNameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> lastNameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> phoneNumberFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> confirmPasswordFormKey = GlobalKey<FormState>();
  final SecureStorage _secureStorage = SecureStorage();
  bool isOtpScreen = false;
  String otp = "";
  bool? registerLoading = false;
  bool? verifyOtpLoading = false;

  String? firstNameErrorText,
      lastNameErrorText,
      emailErrorText,
      phoneNumberErrorText,
      passwordErrorText,
      confirmPasswordErrorText;

  String phoneNumber = '';
  String initialCountry = 'US';
  String initialDialCode = '+1';
  bool phoneNumberValidated = true;

  onDialCodeChanged(String? value){
    initialDialCode = value ?? '+1';
    notifyListeners();
  }

  onPhoneNumberChanged(String? value){
    phoneNumber = value ?? '';
    notifyListeners();
  }

  onPhoneNumberValidated(bool value){
    phoneNumberValidated = value;
    notifyListeners();
  }

  onOtpChanged(String value){
    otp= value;
    notifyListeners();
  }


  validateEmail(context, String? value, bool? isForFinalCheck) {
    if(isForFinalCheck ?? false){
      String? str = PatternValidator.isValidEmail(
          context,
          value,
          '',
          '');
      if(str == null){
        return true;
      }else {
        return false;
      }
    }else{
      emailErrorText = PatternValidator.isValidEmail(
          context,
          value,
          AppLocalizations.of(context).email_mandatory,
          AppLocalizations.of(context).invalid_email);
      notifyListeners();
    }
  }

  validatePhoneNumber(context) {
      if(phoneNumber.isNotEmpty){
        return phoneNumberValidated;
      }
     return false;
  }

  validateName(context, String? value, bool isFirstName, bool? isForFinalCheck) {
    if (isForFinalCheck ?? false) {
        String? str = PatternValidator.isValidName(
            context,
            value,
            '',
            '');
        if (str == null) {
          return true;
        } else {
          return false;
        }
    }else {
      if (isFirstName) {
        firstNameErrorText = PatternValidator.isValidName(
            context,
            value,
            AppLocalizations
                .of(context)
                .first_name_mandatory,
            AppLocalizations
                .of(context)
                .invalid_first_name);
        notifyListeners();
      } else {
        lastNameErrorText = PatternValidator.isValidName(
            context,
            value,
            AppLocalizations
                .of(context)
                .last_name_mandatory,
            AppLocalizations
                .of(context)
                .invalid_last_name);
        notifyListeners();
      }
    }
  }

  validatePassword(context, String? value, bool isPassword, bool? isForFinalCheck,
      {String password = ""}) {
      if(isForFinalCheck ?? false){
        String? str = PatternValidator.isValidPassword(
            context,
            value,
            confirmPassword: password,
            '',
            '');
        if(str == null){
          return true;
        }else {
          return false;
        }
      }else{
        if (isPassword) {
          passwordErrorText = PatternValidator.isValidPassword(
              context,
              value,
              AppLocalizations.of(context).password_mandatory,
              AppLocalizations.of(context).invalid_password);
          notifyListeners();
        } else {
          confirmPasswordErrorText = PatternValidator.isValidPassword(
              context,
              value,
              AppLocalizations.of(context).confirm_password_mandatory,
              AppLocalizations.of(context).invalid_password,
              confirmPassword: password,
              misMatchErrorText:
              AppLocalizations.of(context).password_confrim_password_match);
          notifyListeners();
        }
      }}

  bool validateInputs(context) {
    return (validatePhoneNumber(context));
  }


  sellerRegisterCall(BuildContext context) async {
    if (validateInputs(context)) {
      registerLoading = true;
      notifyListeners();
      SellerRegisterRequestModel requestModel = SellerRegisterRequestModel(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          password: passwordController.text,confirmPassword: confirmPasswordController.text,phoneNumber: (getPhoneNumber()));

      try{
        await sellerDataSource.sellerRegister(context,requestModel)?.then((response) async{
          if (response.sellerRegisterModel != null) {
            if (response.sellerRegisterModel?.status == 200) {
              generateOtp(context,response.sellerRegisterModel?.data?.phoneNumber ?? '');
            }else{
              registerLoading = false;
              notifyListeners();
              CustomSnackbar(
                  message: response.errorResponseModel!.message ?? "",
                  context: context)
                  .showSnackbar();
            }
          } else {
            registerLoading = false;
            notifyListeners();
            CustomSnackbar(
                message: response.errorResponseModel!.message ?? "",
                context: context)
                .showSnackbar();
          }
        });
      }on DioException  catch (e){
        registerLoading = false;
        notifyListeners();
        showApiExceptionError(e, context);
      }
    } else {
      if(phoneNumber.isNotEmpty){
        if(!phoneNumberValidated){
          CustomSnackbar(
              message: AppLocalizations.of(context).invalid_phone_number,
              context: context)
              .showSnackbar();
        }
      }else{
        CustomSnackbar(
            message: 'Please enter phone number',
            context: context)
            .showSnackbar();
      }
    }
  }

  String getPhoneNumber(){
    return initialDialCode + phoneNumber;
  }


  generateOtp(BuildContext context,String phone) async{

    SellerOTPRequestModel sellerOTPRequestModel = SellerOTPRequestModel(phoneNumber: phone);

    try{
      await sellerDataSource.generateOtp(context, sellerOTPRequestModel)?.then((onValue) async{
        if(onValue.sellerOTPRegisterModel != null){
          if(onValue.sellerOTPRegisterModel?.status == 200 ){
            registerLoading = false;
            toggleOtpScreen(true);
          }else{
            CustomSnackbar(
                message: onValue.errorResponseModel!.message ?? "",
                context: context)
                .showSnackbar();
          }
        }else{
          registerLoading = false;
          notifyListeners();
          CustomSnackbar(
              message: onValue.errorResponseModel!.message ?? "",
              context: context)
              .showSnackbar();
        }
      });
    }on DioException catch (e) {
      registerLoading = false;
      notifyListeners();
      showApiExceptionError(e, context);
    }
  }


  verifyOtp(BuildContext context) async{
    if(otp.length >= 6){
      verifyOtpLoading = true;
      notifyListeners();
      SellerOTPVerifyRequestModel sellerVerifyOTPRequestModel = SellerOTPVerifyRequestModel(otp: otp, phoneNumber: getPhoneNumber());

      try{
        await sellerDataSource.verifyOtp(context, sellerVerifyOTPRequestModel)?.then((onValue) async{

          if(onValue.sellerVerifyOTPRegisterModel != null){
            verifyOtpLoading = false;
            notifyListeners();
            if(onValue.sellerVerifyOTPRegisterModel?.status == 200 ){
              context.go(AppPages.auth+AppPages.sellerCreateContract);
            }else{
              CustomSnackbar(
                  message: onValue.errorResponseModel!.message ?? "",
                  context: context)
                  .showSnackbar();
            }
          }else{
            verifyOtpLoading = false;
            notifyListeners();
            CustomSnackbar(
                message: onValue.errorResponseModel!.message ?? "",
                context: context)
                .showSnackbar();
          }
        });
      }on DioException catch (e) {
        verifyOtpLoading = false;
        notifyListeners();
        showApiExceptionError(e, context);
      }
    }else{
      CustomSnackbar(
          message: 'Please enter OTP',
          context: context)
          .showSnackbar();
    }
  }


  void setStorageValues(SellerRegisterModel? registerData) async{
    _secureStorage.setUserEmail(registerData?.data?.email ?? '');
    _secureStorage.setUserFirstName(registerData?.data?.firstName ?? '');
    _secureStorage.setUserLastName(registerData?.data?.lastName ?? '');
    _secureStorage.setAccessToken(registerData?.accessToken ?? '');
  }

  void toggleOtpScreen(bool? openVerifyOtpScreen){
    isOtpScreen = openVerifyOtpScreen ?? false;
    notifyListeners();
  }


  void showApiExceptionError(dynamic error, BuildContext context){
    CustomSnackbar(
        message: error.response?.data != null ? (error.response?.data is Map<String, dynamic> && (error.response?.data as Map<String,dynamic>).containsKey('message') ?  error.response?.data['message']  : 'Something went wrong') : 'Something went wrong',
        context: context)
        .showSnackbar();
  }


}