import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend_ecommerce/common/styles/font_style.dart';
import 'package:frontend_ecommerce/common/widget/app_logo.dart';
import 'package:frontend_ecommerce/common/widget/shared/custom_button.dart';
import 'package:frontend_ecommerce/common/widget/shared/input_text_field.dart';
import 'package:frontend_ecommerce/constants/color_constants.dart';
import 'package:frontend_ecommerce/constants/dimen_constant.dart';
import 'package:frontend_ecommerce/features/seller/authentication/view_model/seller_register_view_model.dart';
import 'package:frontend_ecommerce/utils/responsive_layout.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:provider/provider.dart';

import '../../../../utils/timer_provider.dart';

class SellerRegisterForm extends StatelessWidget {
  const SellerRegisterForm({super.key});

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
            if(provider.isOtpScreen)
              otpVerifyUI(context,provider)
            else
              phoneNumberUI(context,provider)
          ],
        );
      }),
    );
  }


  Widget phoneNumberUI(BuildContext context,SellerRegisterViewModel provider){
    return Column(
      children: [
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
                      initialValue: PhoneNumber(phoneNumber: provider.phoneNumber, dialCode: provider.initialDialCode, isoCode: provider.initialCountry),
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
              Consumer<TimerProvider>(
                  builder: (ctx, timerProvider, child){
                    return SizedBox(
                      width: MediaQuery.of(ctx).size.width,
                      child: CustomButton(
                          buttonText: AppLocalizations.of(ctx).register_with_otp,
                          onPressed: () {
                            timerProvider.startTimer(59);
                            provider.sellerRegisterCall(ctx);
                          },
                          backgroundColor: AppColors.primaryColor,
                          textStyle: FontStyles.labelMedium
                              .copyWith(color: AppColors.white)),
                    );
              }),
              const SizedBox(height: 20,),
            ],
          ),
        )
      ],
    );
  }

  Widget otpVerifyUI(BuildContext context,SellerRegisterViewModel provider){
    return Column(
      children: [
        Row(
          children: [
            InkWell(
                onTap: (){
                  provider.toggleOtpScreen(false);
                },
                child: const Icon(Icons.arrow_back_outlined,color: AppColors.darkBorder,)),
            const SizedBox(width: 20,),
            Expanded(
              child: Text(
                AppLocalizations.of(context).verify_otp,
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
              OtpPinField(
                key: provider.otpPinFieldController,
                autoFillEnable: true,
                textInputAction: TextInputAction.done,
                onSubmit: (text) {
                  provider.verifyOtp(context);
                },
                onChange: (text) {
                  provider.otp = text;
                },
                onCodeChanged: (code) {

                },
                otpPinFieldStyle: const OtpPinFieldStyle(
                  showHintText: true,
                  defaultFieldBorderColor: AppColors.inActiveBorder,
                  activeFieldBorderColor: AppColors.activeBorder,
                ),
                maxLength: 6,
                showCursor: true,
                highlightBorder: false,
                cursorColor: AppColors.primaryColor,
                showCustomKeyboard: false,
                cursorWidth: 3,
                mainAxisAlignment: MainAxisAlignment.center,
                otpPinFieldDecoration:
                OtpPinFieldDecoration.underlinedPinBoxDecoration,
              ),
              SizedBox(
                height: DimenConstant.bigContentSpacing,
              ),

              Consumer<TimerProvider>(builder: (ctx, timerProvider, child){
                if(timerProvider.secondsRemaining <=0){
                  return RichText(
                    text: TextSpan(
                      text: 'Didn\'t receive the OTP? ',
                      style: const TextStyle(fontSize: 14),
                      children: [
                        TextSpan(text: 'Send again',recognizer: TapGestureRecognizer()..onTap = () {
                          timerProvider.startTimer(59);
                          provider.generateOtp(ctx, provider.phoneNumber);
                        } , style: const TextStyle(color: AppColors.primaryColor,decoration: TextDecoration.underline,fontSize: 14))
                      ]
                    ),
                  );
                }else{
                  return Text('Resend OTP in ${timerProvider.secondsRemaining} s',style: const TextStyle(fontSize: 14),);
                }
              }),

              SizedBox(
                height: DimenConstant.contentSpacing,
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CustomButton(
                    buttonText: AppLocalizations.of(context).verify,
                    onPressed: () {
                      provider.verifyOtp(context);
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
  }


}
