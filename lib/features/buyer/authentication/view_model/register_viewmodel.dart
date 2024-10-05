import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend_ecommerce/common/widget/shared/custom_snackbar.dart';
import 'package:frontend_ecommerce/data/data_source/buyer/buyer_data_source.dart';
import 'package:frontend_ecommerce/features/buyer/authentication/model/buyer_register_request_model.dart';
import 'package:frontend_ecommerce/route/router_constant.dart';
import 'package:frontend_ecommerce/utils/validators/pattern_validator.dart';
import 'package:go_router/go_router.dart';

class RegisterViewmodel with ChangeNotifier {
  final BuyerDataSourceImpl buyerDataSource = BuyerDataSourceImpl();
  TextEditingController firstNameController = TextEditingController(text: "");
  TextEditingController lastNameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController confirmPasswordController =
      TextEditingController(text: "");
  final GlobalKey<FormState> firstNameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> lasttNameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> confirmPasswordFormKey = GlobalKey<FormState>();
  String? firstNameErrorText,
      lastNameErrorText,
      emailErrorText,
      passwordErrorText,
      confirmPasswordErrorText;

  validateEmail(context, String? value) {
    emailErrorText = PatternValidator.isValidEmail(
        context,
        value,
        AppLocalizations.of(context).email_mandatory,
        AppLocalizations.of(context).invalid_email);
    notifyListeners();
  }

  validateName(context, String? value, bool isFirstName) {
    if (isFirstName) {
      firstNameErrorText = PatternValidator.isValidName(
          context,
          value,
          AppLocalizations.of(context).first_name_mandatory,
          AppLocalizations.of(context).invalid_first_name);
      notifyListeners();
    } else {
      lastNameErrorText = PatternValidator.isValidName(
          context,
          value,
          AppLocalizations.of(context).last_name_mandatory,
          AppLocalizations.of(context).invalid_last_name);
      notifyListeners();
    }
  }

  validatePassword(context, String? value, bool isPassword,
      {String password = ""}) {
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
  }

  bool validateInputs(context) {
    return (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty);
  }

  buyerRegisterCall(BuildContext context) async {
    if (validateInputs(context)) {
      BuyerRegisterRequestModel requestModel = BuyerRegisterRequestModel(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          password: passwordController.text);

      await buyerDataSource.buyerRegister(context,requestModel)?.then((response) {
        if (response.buyerRegisterModel != null) {
          if (response.buyerRegisterModel?.status == 200) {
            CustomSnackbar(
                    message: AppLocalizations.of(context).register_successful,
                    context: context)
                .showSnackbar();
            Future.delayed(const Duration(seconds: 2), () {
              context.go(AppPages.auth + AppPages.buyerLogin);
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


  buyerRegisterCallSocial(BuildContext context, String name, String email, String idToken) async {
      BuyerRegisterRequestModel requestModel = BuyerRegisterRequestModel(
          firstName: name,
          lastName: '',
          email: email,
          password: '',
          idToken: idToken);

      await buyerDataSource.buyerRegisterSocial(context,requestModel)?.then((response) {
        if (response.buyerRegisterModel != null) {
          if (response.buyerRegisterModel?.status == 200) {
            CustomSnackbar(
                message: AppLocalizations.of(context).register_successful,
                context: context)
                .showSnackbar();
            Future.delayed(const Duration(seconds: 2), () {
              context.go(AppPages.auth + AppPages.buyerLogin);
            });
          }
        } else {
          CustomSnackbar(
              message: response.errorResponseModel!.message ?? "",
              context: context)
              .showSnackbar();
        }
      });
  }
}
