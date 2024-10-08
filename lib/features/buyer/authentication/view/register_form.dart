import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend_ecommerce/common/styles/font_style.dart';
import 'package:frontend_ecommerce/common/widget/app_logo.dart';
import 'package:frontend_ecommerce/common/widget/shared/custom_button.dart';
import 'package:frontend_ecommerce/common/widget/shared/input_text_field.dart';
import 'package:frontend_ecommerce/constants/color_constants.dart';
import 'package:frontend_ecommerce/constants/dimen_constant.dart';
import 'package:frontend_ecommerce/features/buyer/authentication/view_model/register_viewmodel.dart';
import 'package:frontend_ecommerce/utils/responsive_layout.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ResponsiveWidget.isSmallScreen(context) ? 20 : 60),
      child: Consumer<RegisterViewmodel>(builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ResponsiveWidget.isSmallScreen(context)
                ? Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(top: 50, bottom: 50),
                    child: const AppLogo())
                : const SizedBox.shrink(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).create_account,
                  style: FontStyles.displaySmall
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(AppLocalizations.of(context).seller_signup,
                        style: FontStyles.labelMedium),
                    const SizedBox(
                      width: 8,
                    ),
                    const Icon(Icons.arrow_right_alt)
                  ],
                )
              ],
            ),
            SizedBox(
              height: DimenConstant.titleContentSpace,
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: ResponsiveWidget.isSmallScreen(context)
                      ? 0
                      : MediaQuery.of(context).size.width / 8),
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
                      provider.validatePassword(context, value, true);
                    },
                  ),
                  SizedBox(
                    height: DimenConstant.inputContentSpacing,
                  ),
                  InputTextField(
                    formKey: provider.confirmPasswordFormKey,
                    controller: provider.confirmPasswordController,
                    errorText: provider.confirmPasswordErrorText,
                    isObscureText: true,
                    hintText:
                        AppLocalizations.of(context).enter_confirm_password,
                    labelText: AppLocalizations.of(context).confirm_password,
                    onTextChange: (value) {
                      provider.validatePassword(context, value, false,
                          password: provider.passwordController.text);
                    },
                  ),
                  SizedBox(
                    height: DimenConstant.inputContentSpacing,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomButton(
                        buttonText: AppLocalizations.of(context).create_account,
                        onPressed: () {
                          provider.buyerRegisterCall(context);
                        },
                        backgroundColor: AppColors.primaryColor,
                        textStyle: FontStyles.labelMedium
                            .copyWith(color: AppColors.white)),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
