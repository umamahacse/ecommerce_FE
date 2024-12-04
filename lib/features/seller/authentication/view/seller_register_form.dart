import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend_ecommerce/common/styles/font_style.dart';
import 'package:frontend_ecommerce/common/widget/app_logo.dart';
import 'package:frontend_ecommerce/common/widget/shared/custom_button.dart';
import 'package:frontend_ecommerce/constants/color_constants.dart';
import 'package:frontend_ecommerce/constants/dimen_constant.dart';
import 'package:frontend_ecommerce/features/seller/authentication/view_model/seller_register_view_model.dart';
import 'package:frontend_ecommerce/utils/responsive_layout.dart';
import 'package:provider/provider.dart';

import '../../../../common/widget/shared/input_phone_number_field.dart';
import '../../../../utils/otp_input_field.dart';
import '../../../../utils/timer_provider.dart';
import '../../../../utils/utils.dart';

class SellerRegisterForm extends StatelessWidget {
  const SellerRegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal:  ResponsiveWidget.isSmallScreen(context) ? 70 : 120),
      height: MediaQuery.of(context).size.height,
      child: Consumer<SellerRegisterViewModel>(builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              if(!ResponsiveWidget.isSmallScreen(context)) const SizedBox(height: 100,),
              ResponsiveWidget.isSmallScreen(context)
                  ? Container(
                  height: 100,
                  width: 100,
                  margin: const EdgeInsets.only(top: 50, bottom: 50),
                  child: const AppLogo())
                  : const SizedBox.shrink(),
              AnimatedSwitcher(duration: const Duration(milliseconds: 300),child: provider.isOtpScreen ? otpVerifyUI(context,provider) : phoneNumberUI(context,provider),)
              // AnimatedCrossFade(firstChild: otpVerifyUI(context,provider), secondChild: phoneNumberUI(context,provider), crossFadeState: provider.isOtpScreen ? CrossFadeState.showFirst : CrossFadeState.showSecond, duration: const Duration(milliseconds: 50))
            ],
          ),
        );
      }),
    );
  }


  Widget phoneNumberUI(BuildContext context,SellerRegisterViewModel provider){
    return Column(
      children: [
        Text(
          AppLocalizations.of(context).welcome,
          style: FontStyles.displayLarge
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5,),
        Text(
          AppLocalizations.of(context).please_enter_your_phone_number,
          style: FontStyles.labelSmall
              .copyWith(fontWeight: FontWeight.w300),
        ),
        SizedBox(
          height: DimenConstant.titleContentSpace,
        ),
        Column(
          children: [
            InputPhoneNumberField<SellerRegisterViewModel>(
              initialDialCode: provider.initialDialCode,
              phoneNumberController: provider.phoneNumberController,
              onDialCodeChanged: (value)=> provider.onDialCodeChanged(value),
              onPhoneNumberChanged: (value)=> provider.onPhoneNumberChanged(value),
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
                        isLoading: provider.registerLoading,
                        loadingColor: AppColors.white,
                        backgroundColor: provider.phoneNumberController.text.isNotEmpty?  AppColors.primaryColor : AppColors.greyButtonBg,
                        textStyle: FontStyles.labelMedium
                            .copyWith(color: AppColors.white)),
                  );
            }),
            const SizedBox(height: 20,),
          ],
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
                child: const Icon(Icons.arrow_back_outlined,color: AppColors.darkBorder,size: 30,)),
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
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: OTPInputField(
                length: 6,
                onCompleted: (value) {
                  provider.onOtpChanged(value);
                },
              ),
            ),
            SizedBox(
              height: DimenConstant.bigContentSpacing,
            ),

            Consumer<TimerProvider>(builder: (ctx, timerProvider, child){
              if(timerProvider.secondsRemaining <=0){
                return RichText(
                  text: TextSpan(
                    text: '${AppLocalizations.of(context).not_receive_otp} ',
                    style: const TextStyle(fontSize: 14),
                    children: [
                      TextSpan(text: AppLocalizations.of(context).send_again,recognizer: TapGestureRecognizer()..onTap = () {
                        timerProvider.startTimer(59);
                        provider.generateOtp(ctx, provider.getPhoneNumber());
                      } , style: const TextStyle(color: AppColors.primaryColor,decoration: TextDecoration.underline,fontSize: 14))
                    ]
                  ),
                );
              }else{
                return Text('${AppLocalizations.of(context).resend_otp_in} ${timerProvider.secondsRemaining} s',style: const TextStyle(fontSize: 14),);
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
                  isLoading: provider.verifyOtpLoading,
                  loadingColor: AppColors.white,
                  backgroundColor: provider.otp.length >=6?  AppColors.primaryColor : AppColors.greyButtonBg,
                  textStyle: FontStyles.labelMedium
                      .copyWith(color: AppColors.white)),
            ),
            const SizedBox(height: 20,),
          ],
        )
      ],
    );
  }


}
