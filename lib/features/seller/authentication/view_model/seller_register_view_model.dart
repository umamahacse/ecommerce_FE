import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widget/shared/custom_snackbar.dart';
import '../../../../data/data_source/seller/seller_data_source.dart';
import '../../../../data/secured_storage/secured_storage.dart';
import '../../../../route/router_constant.dart';
import '../../../../utils/validators/pattern_validator.dart';
import '../model/seller_register_model.dart';
import '../model/seller_register_request_model.dart';

class SellerRegisterViewModel extends ChangeNotifier{
  final SellerDataSourceImpl buyerDataSource = SellerDataSourceImpl();
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

  String? firstNameErrorText,
      lastNameErrorText,
      emailErrorText,
      phoneNumberErrorText,
      passwordErrorText,
      confirmPasswordErrorText;


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

  validatePhoneNumber(context, String? value, bool? isForFinalCheck) {
    if(isForFinalCheck ?? false){
      String? str = PatternValidator.isValidPhoneNumber(
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
      phoneNumberErrorText = PatternValidator.isValidPhoneNumber(
          context,
          value,
          AppLocalizations.of(context).enter_phone_number,
          AppLocalizations.of(context).invalid_phone_number);
      notifyListeners();
    }
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
    return (validateName(context, firstNameController.text, true, true) && validateName(context, lastNameController.text, false, true) &&
        validateEmail(context, emailController.text, true) && validatePhoneNumber(context, phoneNumberController.text, true) && validatePassword(context, passwordController.text, true, true) && validatePassword(context, confirmPasswordController.text, false, true, password: passwordController.text));
  }


  sellerRegisterCall(BuildContext context) async {
    if (validateInputs(context)) {
      SellerRegisterRequestModel requestModel = SellerRegisterRequestModel(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          password: passwordController.text,confirmPassword: confirmPasswordController.text,phoneNumber: phoneNumberController.text);

      await buyerDataSource.buyerRegister(context,requestModel)?.then((response) {
        if (response.sellerRegisterModel != null) {
          if (response.sellerRegisterModel?.status == 200) {
            CustomSnackbar(
                message: AppLocalizations.of(context).register_successful,
                context: context)
                .showSnackbar();
            setStorageValues(response.sellerRegisterModel);
            Future.delayed(const Duration(seconds: 2), () {
              context.go(AppPages.auth + AppPages.sellerDashBoard);
            });
          }
        } else {
          CustomSnackbar(
              message: response.errorResponseModel!.message ?? "",
              context: context)
              .showSnackbar();
        }
      });
    } else {
      CustomSnackbar(
          message: AppLocalizations.of(context).enter_all_mandatory_field,
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

}