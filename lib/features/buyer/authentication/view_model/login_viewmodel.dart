import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend_ecommerce/common/widget/shared/custom_snackbar.dart';
import 'package:frontend_ecommerce/data/data_source/buyer/buyer_data_source.dart';
import 'package:frontend_ecommerce/features/buyer/authentication/model/buyer_login_request_model.dart';
import 'package:frontend_ecommerce/features/buyer/authentication/model/buyer_login_model.dart';
import 'package:frontend_ecommerce/route/router_constant.dart';
import 'package:frontend_ecommerce/utils/validators/pattern_validator.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/secured_storage/secured_storage.dart';

class LoginViewmodel extends ChangeNotifier {
  final BuyerDataSourceImpl buyerDataSource = BuyerDataSourceImpl();
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  String? emailErrorText, passwordErrorText;
  final SecureStorage _secureStorage = SecureStorage();

  validateEmail(context, String? value) {
    emailErrorText = PatternValidator.isValidEmail(
        context,
        value,
        AppLocalizations.of(context).email_mandatory,
        AppLocalizations.of(context).invalid_email);
    notifyListeners();
  }

  validatePassword(context, String? value) {
    passwordErrorText = PatternValidator.isValidPassword(
        context,
        value,
        AppLocalizations.of(context).password_mandatory,
        AppLocalizations.of(context).invalid_password);
    notifyListeners();
  }
  bool validateInputs(context) {
    return (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty);
  }

  buyerLogin(BuildContext context) async {
    if (validateInputs(context)) {
      BuyerLoginRequestModel requestModel = BuyerLoginRequestModel(
          email: emailController.text,
          password: passwordController.text);

      await buyerDataSource.buyerLogin(context,requestModel)?.then((response) {
        if (response.buyerLoginResponseModel != null) {
          if (response.buyerLoginResponseModel?.status == 200) {
            setStorageValues(response.buyerLoginResponseModel);
            Future.delayed(const Duration(seconds: 1), () {
              context.go(AppPages.buyerDashboard);
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
    BuyerLoginRequestModel requestModel = BuyerLoginRequestModel(
        email: email,
        password: '',
        displayName: name,
        idToken: idToken);

    await buyerDataSource.buyerRegisterSocial<BuyerLoginResponseModel, BuyerLoginRequestModel>(context,requestModel)?.then((response) {
      if (response.buyerLoginResponseModel != null) {
        if (response.buyerLoginResponseModel?.status == 200) {
          setStorageValues(response.buyerLoginResponseModel);
          Future.delayed(const Duration(seconds: 1), () {
            context.go(AppPages.buyerDashboard);
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

  void setStorageValues(BuyerLoginModel? loginData) async{
    _secureStorage.setUserEmail(loginData?.data?.email ?? '');
    _secureStorage.setUserFirstName(loginData?.data?.firstName ?? '');
    _secureStorage.setUserLastName(loginData?.data?.lastName ?? '');
    _secureStorage.setAccessToken(loginData?.accessToken ?? '');
  }

}
