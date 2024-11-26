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
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
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
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 100,),
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
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {
                           provider.onPhoneNumberInputChanged(number);
                          },
                          onInputValidated: (bool value) {
                            provider.onPhoneNumberValidated(value);
                          },
                          selectorConfig: SelectorConfig(
                            trailingSpace: false,
                            leadingPadding: 0,
                            selectorType: ResponsiveWidget.isSmallScreen(context)? PhoneInputSelectorType.BOTTOM_SHEET :  PhoneInputSelectorType.DROPDOWN,
                          ),
                          ignoreBlank: false,
                          initialValue: provider.number,
                          scrollPadding: EdgeInsets.zero,
                          textFieldController: TextEditingController(),
                          formatInput: false,
                          keyboardType: const TextInputType.numberWithOptions(
                            signed: true,
                            decimal: true,
                          ),
                          inputDecoration:  InputDecoration(
                            labelText: AppLocalizations.of(context).phone_number,
                            hintText: AppLocalizations.of(context).enter_phone_number,
                            hintStyle: const TextStyle(color: AppColors.hintColor),
                            labelStyle: const TextStyle(color: AppColors.hintColor),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: provider.phoneNumberValidated? AppColors.darkBorder : AppColors.errorBorder)
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: provider.phoneNumberValidated? AppColors.darkBorder : AppColors.errorBorder)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: provider.phoneNumberValidated? AppColors.darkBorder : AppColors.errorBorder)
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: DimenConstant.bigContentSpacing,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomButton(
                        buttonText: AppLocalizations.of(context).register_with_otp,
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
