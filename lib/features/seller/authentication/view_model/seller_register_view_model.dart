import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend_ecommerce/features/seller/authentication/model/seller_otp_request_model.dart';
import 'package:frontend_ecommerce/features/seller/authentication/model/seller_otp_verify_request_model.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

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
  final otpPinFieldController = GlobalKey<OtpPinFieldState>();
  bool isOtpScreen = false;
  String otp = "0000";

  String? firstNameErrorText,
      lastNameErrorText,
      emailErrorText,
      phoneNumberErrorText,
      passwordErrorText,
      confirmPasswordErrorText;

  String phoneNumber = '';
  String initialCountry = 'US';
  String initialDialCode = '+1';
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  bool phoneNumberValidated = true;




  onPhoneNumberInputChanged(PhoneNumber phoneNumberValue){
    initialCountry = phoneNumberValue.isoCode ?? 'US';
    initialDialCode = phoneNumberValue.dialCode ?? '+1';
    phoneNumber = phoneNumberValue.phoneNumber ?? '';
    notifyListeners();
  }

  void onPhoneNumberValidated(bool value){
    phoneNumberValidated = value;
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
      SellerRegisterRequestModel requestModel = SellerRegisterRequestModel(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          password: passwordController.text,confirmPassword: confirmPasswordController.text,phoneNumber: (phoneNumber ?? ''));

      await sellerDataSource.sellerRegister(context,requestModel)?.then((response) async{
        if (response.sellerRegisterModel != null) {
          if (response.sellerRegisterModel?.status == 200) {
            generateOtp(context,response.sellerRegisterModel?.data?.phoneNumber ?? '');
          }else{
            CustomSnackbar(
                message: response.errorResponseModel!.message ?? "",
                context: context)
                .showSnackbar();
          }
        } else {
          CustomSnackbar(
              message: response.errorResponseModel!.message ?? "",
              context: context)
              .showSnackbar();
        }
      });
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

  generateOtp(BuildContext context,String phone) async{

    SellerOTPRequestModel sellerOTPRequestModel = SellerOTPRequestModel(phoneNumber: phone);

    await sellerDataSource.generateOtp(context, sellerOTPRequestModel)?.then((onValue) async{

      if(onValue.sellerOTPRegisterModel != null){
        if(onValue.sellerOTPRegisterModel?.status == 200 ){
          toggleOtpScreen(true);
        }else{
          CustomSnackbar(
              message: onValue.errorResponseModel!.message ?? "",
              context: context)
              .showSnackbar();
        }
      }else{
        CustomSnackbar(
            message: onValue.errorResponseModel!.message ?? "",
            context: context)
            .showSnackbar();
      }
    });
  }


  verifyOtp(context) async{
    if(otp.length >= 4){
      SellerOTPVerifyRequestModel sellerVerifyOTPRequestModel = SellerOTPVerifyRequestModel(otp: otp, phoneNumber: phoneNumber);

      await sellerDataSource.verifyOtp(context, sellerVerifyOTPRequestModel)?.then((onValue) async{

        if(onValue.sellerVerifyOTPRegisterModel != null){
          if(onValue.sellerVerifyOTPRegisterModel?.status == 200 ){
            // Move to Home page
            CustomSnackbar(
                message: 'OTP Verified',
                context: context)
                .showSnackbar();
          }else{
            CustomSnackbar(
                message: onValue.errorResponseModel!.message ?? "",
                context: context)
                .showSnackbar();
          }
        }else{
          CustomSnackbar(
              message: onValue.errorResponseModel!.message ?? "",
              context: context)
              .showSnackbar();
        }
      });

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


}