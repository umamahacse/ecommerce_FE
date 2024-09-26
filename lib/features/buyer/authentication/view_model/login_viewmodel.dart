import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend_ecommerce/data/data_source/buyer/buyer_data_source.dart';
import 'package:frontend_ecommerce/utils/validators/pattern_validator.dart';

class LoginViewmodel extends ChangeNotifier {
  final BuyerDataSourceImpl buyerDataSource = BuyerDataSourceImpl();
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  String? emailErrorText, passwordErrorText;

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
}
