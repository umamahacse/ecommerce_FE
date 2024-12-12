import 'package:flutter/material.dart';
import 'package:frontend_ecommerce/common/styles/font_style.dart';
import 'package:frontend_ecommerce/constants/color_constants.dart';
import 'package:frontend_ecommerce/features/shared/custom_stepper.dart';
import 'package:provider/provider.dart';

import '../../../../common/widget/shared/custom_button.dart';
import '../../../../common/widget/shared/input_text_field.dart';
import '../../../../constants/screen_size_constants.dart';
import '../view_model/create_contract_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateContractScreen extends StatefulWidget {
  const CreateContractScreen({super.key});

  @override
  State<CreateContractScreen> createState() => _CreateContractScreenState();
}

class _CreateContractScreenState extends State<CreateContractScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     final auth = Provider.of<CreateContractViewModel>(context, listen: false);
     auth.setInitialStepperData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: Consumer<CreateContractViewModel>(builder: (context, provider, child){
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < ScreenSizeConstants.mobileBreakPoint) {
              return mobileLayout(context,provider);
            } else if (constraints.maxWidth < ScreenSizeConstants.tabletBreakPoint) {
              return tabletLayout(context,provider);
            } else if (constraints.maxWidth < ScreenSizeConstants.desktopBreakPoint) {
              return desktopOrTvLayout(context,provider);
            } else {
              return desktopOrTvLayout(context,provider);
            }
          }
      );}
    ));
  }

  Widget mobileLayout(BuildContext context, CreateContractViewModel provider){
    int currentStepIndex = provider.stepperData.indexWhere((element) => element.isCurrentStep == true);
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(
                Icons.keyboard_backspace_outlined,
                color: AppColors.defaultIconColor,
              ),
              const SizedBox(width: 50,),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: CustomStepper(data: provider.stepperData,onChanged: (stepIndex){
                        provider.goToSelectedStepperIndex(stepIndex);
                      },),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 30,),
          Expanded(
            child: SingleChildScrollView(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                    width: 400,
                    constraints: const BoxConstraints(
                        maxWidth: 400
                    ),
                    child: Column(
                      children: [
                        buildInfoUI(provider,currentStepIndex),
                        const SizedBox(height: 20,),
                        bottomButton(false, provider, currentStepIndex),
                        const SizedBox(height: 50,),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tabletLayout(BuildContext context, CreateContractViewModel provider){
    int currentStepIndex = provider.stepperData.indexWhere((element) => element.isCurrentStep == true);
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(
                Icons.keyboard_backspace_outlined,
                color: AppColors.defaultIconColor,
              ),
              const SizedBox(width: 50,),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: CustomStepper(data: provider.stepperData,onChanged: (stepIndex){
                        provider.goToSelectedStepperIndex(stepIndex);
                      },),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 30,),
          Expanded(
            child: SingleChildScrollView(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                    width: 400,
                    constraints: const BoxConstraints(
                        maxWidth: 400
                    ),
                    child: Column(
                      children: [
                        buildInfoUI(provider,currentStepIndex),
                        const SizedBox(height: 20,),
                        bottomButton(false, provider, currentStepIndex),
                        const SizedBox(height: 50,),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget desktopOrTvLayout(BuildContext context, CreateContractViewModel provider){
    int currentStepIndex = provider.stepperData.indexWhere((element) => element.isCurrentStep == true);
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 20, top: 50, end: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(
                Icons.keyboard_backspace_outlined,
                color: AppColors.defaultIconColor,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: CustomStepper(data: provider.stepperData,onChanged: (stepIndex){
                        provider.goToSelectedStepperIndex(stepIndex);
                      },),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 30,),
          Expanded(
            child: SingleChildScrollView(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 400,
                    constraints: const BoxConstraints(
                        maxWidth: 400
                    ),
                    child: Column(
                      children: [
                        buildInfoUI(provider,currentStepIndex),
                        const SizedBox(height: 20,),
                        bottomButton(false, provider, currentStepIndex),
                        const SizedBox(height: 50,),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoUI(CreateContractViewModel provider, int currentStepIndex){
     if(currentStepIndex != -1){
        switch(currentStepIndex){
          case 0:
            return buildGeneralInfo(provider);
          case 1:
            return buildGSTInfo(provider);
          case 2:
            return buildStoreDetails(provider);
          case 3:
            return buildTaxAndAccountInfo(provider);
          case 4:
            return buildShippingInfo(provider);
        }
     }
     return Container();
  }


  Widget buildGeneralInfo(CreateContractViewModel provider){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Text(AppLocalizations.of(context).add_general_information, style: FontStyles.labelMedium.copyWith(fontWeight: FontWeight.bold, color: AppColors.primaryTextColor),)),
        const SizedBox(height: 10,),
        Center(child: Text(AppLocalizations.of(context).fill_out_the_basic_details_for_this_contract, style: FontStyles.labelSmall.copyWith(color: AppColors.defaultTextColor),)),
        const SizedBox(height: 20,),
        Text('${AppLocalizations.of(context).first_name} *', style: FontStyles.labelSmall.copyWith(color: AppColors.primaryTextColor),),
        const SizedBox(height: 10,),
        InputTextField(
          formKey: provider.firstNameFormKey,
          controller: provider.firstNameController,
          errorText: provider.firstNameErrorText,
          hintText: '',
          labelText: '',
          cursorColor: AppColors.sellerTextFieldTextColor,
          textColor: AppColors.sellerTextFieldTextColor,
          focusedBorderColor: AppColors.sellerTextFieldBorder,
          inactiveBorderColor: AppColors.sellerTextFieldBorder,
          onTextChange: (value) {
            provider.validateName(context, value, true);
          },
        ),
        if(provider.firstNameErrorText?.isNotEmpty ?? false)
        const SizedBox(height: 10,),
        Text('${AppLocalizations.of(context).last_name} *', style: FontStyles.labelSmall.copyWith(color: AppColors.primaryTextColor),),
        const SizedBox(height: 10,),
        InputTextField(
          formKey: provider.lastNameFormKey,
          controller: provider.lastNameController,
          errorText: provider.lastNameErrorText,
          hintText: '',
          labelText: '',
          cursorColor: AppColors.sellerTextFieldTextColor,
          textColor: AppColors.sellerTextFieldTextColor,
          focusedBorderColor: AppColors.sellerTextFieldBorder,
          inactiveBorderColor: AppColors.sellerTextFieldBorder,
          onTextChange: (value) {
            provider.validateName(context, value, false);
          },
        ),
        if(provider.lastNameErrorText?.isNotEmpty ?? false)
        const SizedBox(height: 10,),
        Text('${AppLocalizations.of(context).email} *', style: FontStyles.labelSmall.copyWith(color: AppColors.primaryTextColor),),
        const SizedBox(height: 10,),
        InputTextField(
          formKey: provider.emailFormKey,
          controller: provider.emailController,
          errorText: provider.emailErrorText,
          hintText: '',
          labelText: '',
          cursorColor: AppColors.sellerTextFieldTextColor,
          textColor: AppColors.sellerTextFieldTextColor,
          focusedBorderColor: AppColors.sellerTextFieldBorder,
          inactiveBorderColor: AppColors.sellerTextFieldBorder,
          onTextChange: (value) {
            provider.validateEmail(context, value);
          },
        ),
        if(provider.emailErrorText?.isNotEmpty ?? false)
        const SizedBox(height: 10,),
        Text('${AppLocalizations.of(context).password} *', style: FontStyles.labelSmall.copyWith(color: AppColors.primaryTextColor),),
        const SizedBox(height: 10,),
        InputTextField(
          formKey: provider.passwordFormKey,
          controller: provider.passwordController,
          errorText: provider.passwordErrorText,
          hintText: '',
          labelText: '',
          isObscureText: true,
          cursorColor: AppColors.sellerTextFieldTextColor,
          textColor: AppColors.sellerTextFieldTextColor,
          focusedBorderColor: AppColors.sellerTextFieldBorder,
          inactiveBorderColor: AppColors.sellerTextFieldBorder,
          onTextChange: (value) {
            provider.validatePassword(context, value, true);
            if(provider.confirmPasswordController.text.isNotEmpty){
              provider.validatePassword(context, provider.confirmPasswordController.text, false, password: value);
            }
          },
        ),
        if(provider.passwordErrorText?.isNotEmpty ?? false)
        const SizedBox(height: 10,),
        Text('${AppLocalizations.of(context).confirm_password} *', style: FontStyles.labelSmall.copyWith(color: AppColors.primaryTextColor),),
        const SizedBox(height: 10,),
        InputTextField(
          formKey: provider.confirmPasswordFormKey,
          controller: provider.confirmPasswordController,
          errorText: provider.confirmPasswordErrorText,
          hintText: '',
          labelText: '',
          isObscureText: true,
          cursorColor: AppColors.sellerTextFieldTextColor,
          textColor: AppColors.sellerTextFieldTextColor,
          focusedBorderColor: AppColors.sellerTextFieldBorder,
          inactiveBorderColor: AppColors.sellerTextFieldBorder,
          onTextChange: (value) {
            provider.validatePassword(context, value, false, password: provider.passwordController.text);
          },
        ),
      ],
    );
  }

  Widget buildGSTInfo(CreateContractViewModel provider){
    return ValueListenableBuilder<int>(
      valueListenable: provider.rxSellGstProducts,
      builder: (context, value, child) {
        if(value == 1){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text(AppLocalizations.of(context).add_gst_information, style: FontStyles.labelMedium.copyWith(fontWeight: FontWeight.bold, color: AppColors.primaryTextColor),)),
              const SizedBox(height: 10,),
              Center(child: Text(AppLocalizations.of(context).gst_number_mandatory_text, style: FontStyles.labelSmall.copyWith(color: AppColors.defaultTextColor),)),
              const SizedBox(height: 20,),
              Text('${AppLocalizations.of(context).enter_15_digit_gst_number} *', style: FontStyles.labelSmall.copyWith(color: AppColors.primaryTextColor),),
              const SizedBox(height: 10,),
              InputTextField(
                formKey: provider.gstNoFormKey,
                controller: provider.gstNoTextField,
                errorText: provider.gstNoErrorText,
                hintText: '',
                labelText: '',
                cursorColor: AppColors.sellerTextFieldTextColor,
                textColor: AppColors.sellerTextFieldTextColor,
                focusedBorderColor: AppColors.sellerTextFieldBorder,
                inactiveBorderColor: AppColors.sellerTextFieldBorder,
                onTextChange: (value) {
                  int cursorPosition = provider.gstNoTextField.selection.base.offset;
                  provider.gstNoTextField.text = value.toUpperCase();
                  if (cursorPosition <= provider.gstNoTextField.text.length) {
                    provider.gstNoTextField.selection = TextSelection.collapsed(offset: cursorPosition);
                  } else {
                    provider.gstNoTextField.selection = TextSelection.collapsed(offset: provider.gstNoTextField.text.length);
                  }
                  provider.validGstNumber(context, value);
                },
              ),


              RadioListTile(
                  hoverColor: Colors.transparent,
                  dense: true,
                activeColor: Colors.transparent,
                title: Text(AppLocalizations.of(context).i_sell_only_books),
                  value: 2, groupValue: provider.rxSellGstProducts.value, onChanged: (value){
                provider.rxSellGstProducts.value = value ?? 0;
                if(provider.rxSellGstProducts.value == 1){
                  provider.validGstNumber<bool>(context, provider.gstNoTextField.text);
                }else{
                  provider.validPanNumber<bool>(context, provider.panNoTextField.text);
                }
                provider.notifyListener();
              })

            ],
          );
        }else{
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text(AppLocalizations.of(context).add_pan_card_details, style: FontStyles.labelMedium.copyWith(fontWeight: FontWeight.bold, color: AppColors.primaryTextColor),)),
              const SizedBox(height: 10,),
              Center(child: Text(AppLocalizations.of(context).pan_number_mandatory_info, style: FontStyles.labelSmall.copyWith(color: AppColors.defaultTextColor),)),
              const SizedBox(height: 20,),
              Text('${AppLocalizations.of(context).enter_10_digit_pan_number} *', style: FontStyles.labelSmall.copyWith(color: AppColors.primaryTextColor),),
              const SizedBox(height: 10,),
              InputTextField(
                formKey: provider.panNoFormKey,
                controller: provider.panNoTextField,
                errorText: provider.panNoErrorText,
                hintText: '',
                labelText: '',
                cursorColor: AppColors.sellerTextFieldTextColor,
                textColor: AppColors.sellerTextFieldTextColor,
                focusedBorderColor: AppColors.sellerTextFieldBorder,
                inactiveBorderColor: AppColors.sellerTextFieldBorder,
                onTextChange: (value) {
                  int cursorPosition = provider.panNoTextField.selection.base.offset;
                  provider.panNoTextField.text = value.toUpperCase();
                  if (cursorPosition <= provider.panNoTextField.text.length) {
                    provider.panNoTextField.selection = TextSelection.collapsed(offset: cursorPosition);
                  } else {
                    provider.panNoTextField.selection = TextSelection.collapsed(offset: provider.panNoTextField.text.length);
                  }
                  provider.validPanNumber(context, provider.panNoTextField.text);
                },
              ),
              RadioListTile(
                hoverColor: Colors.transparent,
                  dense: true,
                  title: Text(AppLocalizations.of(context).i_have_a_gst_number),
                  value: 1, groupValue: provider.rxSellGstProducts.value, onChanged: (value){
                provider.rxSellGstProducts.value = value ?? 0;
                if(provider.rxSellGstProducts.value == 1){
                  provider.validGstNumber<bool>(context, provider.gstNoTextField.text);
                }else{
                  provider.validPanNumber<bool>(context, provider.panNoTextField.text);
                }
                provider.notifyListener();
              })
            ],
          );
        }
      }
    );
  }
  Widget buildStoreDetails(CreateContractViewModel provider){
    return Column(
      children: [],
    );
  }
  Widget buildTaxAndAccountInfo(CreateContractViewModel provider){
    return Column(
      children: [],
    );
  }
  Widget buildShippingInfo(CreateContractViewModel provider){
    return Column(
      children: [],
    );
  }

  Widget bottomButton(bool isLoading, CreateContractViewModel provider, int currentIndex,){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CustomButton(
          buttonText: AppLocalizations.of(context).next_button_text,
          onPressed: () {
            if(enableDisableButtonBg(currentIndex,provider)){
              provider.setStepCompleted(currentIndex, true);
              provider.goToNextStep(currentIndex);
            }
          },
          isLoading: isLoading,
          loadingColor: AppColors.white,
          backgroundColor: enableDisableButtonBg(currentIndex, provider)?  AppColors.primaryColor : AppColors.greyButtonBg,
          textStyle: FontStyles.labelMedium
              .copyWith(color: AppColors.white)),
    );
  }


  bool enableDisableButtonBg(int currentIndex, CreateContractViewModel provider){
    if(currentIndex ==0){
      return provider.checkBasicDetails(context);
    }else if (currentIndex == 1){
      if(provider.rxSellGstProducts.value == 1){
        return provider.validGstNumber<bool>(context, provider.gstNoTextField.text);
      }else{
        return provider.validPanNumber<bool>(context, provider.panNoTextField.text);
      }
    }

    return false;
  }


}
