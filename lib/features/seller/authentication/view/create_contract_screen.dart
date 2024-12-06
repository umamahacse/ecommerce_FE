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
        Text(AppLocalizations.of(context).first_name, style: FontStyles.labelSmall.copyWith(color: AppColors.primaryTextColor),),
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
            // provider.validateEmail(context, value);
          },
        ),
        Text(AppLocalizations.of(context).last_name, style: FontStyles.labelSmall.copyWith(color: AppColors.primaryTextColor),),
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
            // provider.validateEmail(context, value);
          },
        ),
        Text('${AppLocalizations.of(context).email} (${AppLocalizations.of(context).optional})', style: FontStyles.labelSmall.copyWith(color: AppColors.primaryTextColor),),
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
            // provider.validateEmail(context, value);
          },
        ),
        Text(AppLocalizations.of(context).password, style: FontStyles.labelSmall.copyWith(color: AppColors.primaryTextColor),),
        const SizedBox(height: 10,),
        InputTextField(
          formKey: provider.passwordFormKey,
          controller: provider.passwordController,
          errorText: provider.passwordErrorText,
          hintText: '',
          labelText: '',
          cursorColor: AppColors.sellerTextFieldTextColor,
          textColor: AppColors.sellerTextFieldTextColor,
          focusedBorderColor: AppColors.sellerTextFieldBorder,
          inactiveBorderColor: AppColors.sellerTextFieldBorder,
          onTextChange: (value) {
            // provider.validateEmail(context, value);
          },
        ),
        Text(AppLocalizations.of(context).confirm_password, style: FontStyles.labelSmall.copyWith(color: AppColors.primaryTextColor),),
        const SizedBox(height: 10,),
        InputTextField(
          formKey: provider.confirmPasswordFormKey,
          controller: provider.confirmPasswordController,
          errorText: provider.confirmPasswordErrorText,
          hintText: '',
          labelText: '',
          cursorColor: AppColors.sellerTextFieldTextColor,
          textColor: AppColors.sellerTextFieldTextColor,
          focusedBorderColor: AppColors.sellerTextFieldBorder,
          inactiveBorderColor: AppColors.sellerTextFieldBorder,
          onTextChange: (value) {
            // provider.validateEmail(context, value);
          },
        ),
      ],
    );
  }

  Widget buildGSTInfo(CreateContractViewModel provider){
    return Column(
      children: [],
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
            provider.goToNextStep(currentIndex);
          },
          isLoading: isLoading,
          loadingColor: AppColors.white,
          backgroundColor: provider.checkBasicDetails()?  AppColors.primaryColor : AppColors.greyButtonBg,
          textStyle: FontStyles.labelMedium
              .copyWith(color: AppColors.white)),
    );
  }


}
