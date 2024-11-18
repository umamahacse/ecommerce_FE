import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend_ecommerce/common/styles/font_style.dart';
import 'package:frontend_ecommerce/common/widget/app_logo.dart';
import 'package:frontend_ecommerce/common/widget/shared/custom_button.dart';
import 'package:frontend_ecommerce/common/widget/shared/input_text_field.dart';
import 'package:frontend_ecommerce/constants/color_constants.dart';
import 'package:frontend_ecommerce/constants/dimen_constant.dart';
import 'package:frontend_ecommerce/features/seller/authentication/view_model/seller_register_view_model.dart';
import 'package:frontend_ecommerce/utils/responsive_layout.dart';
import 'package:provider/provider.dart';

class SellerRegisterForm extends StatelessWidget {
  SellerRegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ResponsiveWidget.isSmallScreen(context) ? 20 : 60),
      child: Consumer<SellerRegisterViewModel>(builder: (context, provider, child) {
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
              children: [
                Expanded(
                  child: Text(
                    AppLocalizations.of(context).create_seller_account,
                    style: FontStyles.displaySmall
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
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
                    formKey: provider.firstNameFormKey,
                    controller: provider.firstNameController,
                    errorText: provider.firstNameErrorText,
                    hintText: AppLocalizations.of(context).enter_first_name,
                    labelText: AppLocalizations.of(context).first_name,
                    onTextChange: (value) {
                      provider.validateName(context, value, true, false);
                    },
                  ),
                  SizedBox(
                    height: DimenConstant.inputContentSpacing,
                  ),
                  InputTextField(
                    formKey: provider.lastNameFormKey,
                    controller: provider.lastNameController,
                    errorText: provider.lastNameErrorText,
                    hintText: AppLocalizations.of(context).enter_last_name,
                    labelText: AppLocalizations.of(context).last_name,
                    onTextChange: (value) {
                      provider.validateName(context, value, false, false);
                    },
                  ),
                  SizedBox(
                    height: DimenConstant.inputContentSpacing,
                  ),
                  InputTextField(
                    formKey: provider.phoneNumberFormKey,
                    controller: provider.phoneNumberController,
                    errorText: provider.phoneNumberErrorText,
                    hintText: AppLocalizations.of(context).enter_phone_number,
                    labelText: AppLocalizations.of(context).phone_number,
                    onTextChange: (value) {
                      provider.validatePhoneNumber(context, value, false);
                    },
                  ),
                  SizedBox(
                    height: DimenConstant.inputContentSpacing,
                  ),
                  InputTextField(
                    formKey: provider.emailFormKey,
                    controller: provider.emailController,
                    errorText: provider.emailErrorText,
                    hintText: AppLocalizations.of(context).enter_email,
                    labelText: AppLocalizations.of(context).email,
                    onTextChange: (value) {
                      provider.validateEmail(context, value, false);
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
                      provider.validatePassword(context, value, true, false);
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
                      provider.validatePassword(context, value, false, false,password: provider.passwordController.text);
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
                          provider.sellerRegisterCall(context);
                        },
                        backgroundColor: AppColors.primaryColor,
                        textStyle: FontStyles.labelMedium
                            .copyWith(color: AppColors.white)),
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
