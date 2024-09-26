import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend_ecommerce/common/widget/app_logo.dart';
import 'package:frontend_ecommerce/common/widget/shared/input_text_field.dart';
import 'package:frontend_ecommerce/constants/color_constants.dart';
import 'package:frontend_ecommerce/constants/dimen_constant.dart';
import 'package:frontend_ecommerce/features/buyer/authentication/view_model/login_viewmodel.dart';
import 'package:provider/provider.dart';

class BuyerLogin extends StatefulWidget {
  const BuyerLogin({super.key});

  @override
  State<BuyerLogin> createState() => _BuyerLoginState();
}

class _BuyerLoginState extends State<BuyerLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Consumer<LoginViewmodel>(builder: (context, provider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppLogo(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 1.5,
                      child: Column(
                        children: [
                          InputTextField(
                            formKey: provider.emailFormKey,
                            controller: provider.emailController,
                            errorText: provider.emailErrorText,
                            hintText: AppLocalizations.of(context).enter_email,
                            labelText: AppLocalizations.of(context).email,
                            onTextChange: (value) {
                              provider.validateEmail(context, value);
                            },
                          ),
                          SizedBox(
                    height: DimenConstant.inputContentSpacing,
                  ),
                  InputTextField(
                    formKey: provider.passwordFormKey,
                    controller: provider.passwordController,
                    errorText: provider.passwordErrorText,
                    isObscureText: true,
                    hintText: AppLocalizations.of(context).enter_password,
                    labelText: AppLocalizations.of(context).password,
                    onTextChange: (value) {
                      provider.validatePassword(context, value);
                    },
                  ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
