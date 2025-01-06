import 'dart:io';
import 'dart:typed_data';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend_ecommerce/common/styles/font_style.dart';
import 'package:frontend_ecommerce/constants/color_constants.dart';
import 'package:frontend_ecommerce/features/shared/custom_stepper.dart';
import 'package:frontend_ecommerce/features/shared/dotted_border.dart';
import 'package:provider/provider.dart';

import '../../../../common/widget/shared/custom_button.dart';
import '../../../../common/widget/shared/custom_snackbar.dart';
import '../../../../common/widget/shared/input_text_field.dart';
import '../../../../constants/screen_size_constants.dart';
import '../../../../utils/utils.dart';
import '../view_model/create_contract_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateContractScreen extends StatefulWidget {
  const CreateContractScreen({super.key, this.step = '1'});

  final String? step;

  @override
  State<CreateContractScreen> createState() => _CreateContractScreenState();
}

class _CreateContractScreenState extends State<CreateContractScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     final auth = Provider.of<CreateContractViewModel>(context, listen: false);
     auth.setInitialStepperData(context,currentStep: int.tryParse(widget.step ?? '1') ?? 1);
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
                  provider.validGstNumber(context, provider.gstNoTextField.text);
                },
              ),

              Row(
                children: [
                  Radio(hoverColor: Colors.transparent,
                      value: 2, groupValue: provider.rxSellGstProducts.value, onChanged: (value){
                        provider.rxSellGstProducts.value = value ?? 0;
                        if(provider.rxSellGstProducts.value == 1){
                          provider.validGstNumber<bool>(context, provider.gstNoTextField.text);
                        }else{
                          provider.validPanNumber<bool>(context, provider.panNoTextField.text);
                        }
                        provider.notifyListener();
                      }),
                  Flexible(child: InkWell(
                    hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: (){
                        if(provider.rxSellGstProducts.value == 1){
                          provider.rxSellGstProducts.value = 2;
                        }else{
                          provider.rxSellGstProducts.value = 1;
                        }

                        if(provider.rxSellGstProducts.value == 1){
                          provider.validGstNumber<bool>(context, provider.gstNoTextField.text);
                        }else{
                          provider.validPanNumber<bool>(context, provider.panNoTextField.text);
                        }
                        provider.notifyListener();
                      },
                      child: Text(AppLocalizations.of(context).i_sell_only_books))),
                ],
              )

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
              if(provider.rxSellGstProducts.value == 2 && provider.validPanNumber<bool>(context, provider.panNoTextField.text))
              panDetails(provider),

              Row(
                children: [
                  Radio(hoverColor: Colors.transparent,
                      value: 1, groupValue: provider.rxSellGstProducts.value, onChanged: (value){
                        provider.rxSellGstProducts.value = value ?? 0;
                        if(provider.rxSellGstProducts.value == 1){
                          provider.validGstNumber<bool>(context, provider.gstNoTextField.text);
                        }else{
                          provider.validPanNumber<bool>(context, provider.panNoTextField.text);
                        }
                        provider.notifyListener();
                      }),
                  Flexible(child: InkWell(
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: (){
                        if(provider.rxSellGstProducts.value == 1){
                          provider.rxSellGstProducts.value = 2;
                        }else{
                          provider.rxSellGstProducts.value = 1;
                        }

                        if(provider.rxSellGstProducts.value == 1){
                          provider.validGstNumber<bool>(context, provider.gstNoTextField.text);
                        }else{
                          provider.validPanNumber<bool>(context, provider.panNoTextField.text);
                        }
                        provider.notifyListener();

                      },
                      child: Text(AppLocalizations.of(context).i_have_a_gst_number))),
                ],
              )
            ],
          );
        }
      }
    );
  }


  Widget panDetails(CreateContractViewModel provider){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${AppLocalizations.of(context).pan_name} *', style: FontStyles.labelSmall.copyWith(color: AppColors.primaryTextColor),),
        const SizedBox(height: 10,),
          InputTextField(
            formKey: provider.panNameFormKey,
            controller: provider.panNameTextField,
            errorText: provider.panNameErrorText,
            hintText: '',
            labelText: '',
            cursorColor: AppColors.sellerTextFieldTextColor,
            textColor: AppColors.sellerTextFieldTextColor,
            focusedBorderColor: AppColors.sellerTextFieldBorder,
            inactiveBorderColor: AppColors.sellerTextFieldBorder,
            onTextChange: (value) {
              int cursorPosition = provider.panNameTextField.selection.base.offset;
              provider.panNameTextField.text = value.toUpperCase();
              if (cursorPosition <= provider.panNameTextField.text.length) {
                provider.panNameTextField.selection = TextSelection.collapsed(offset: cursorPosition);
              } else {
                provider.panNameTextField.selection = TextSelection.collapsed(offset: provider.panNameTextField.text.length);
              }
              provider.validatePanName(context, provider.panNameTextField.text);
            },
          ),
        if(provider.panNameErrorText?.isNotEmpty ?? false)
        const SizedBox(height: 10,),

        Text('${AppLocalizations.of(context).upload_pan_document} *', style: FontStyles.labelSmall.copyWith(color: AppColors.primaryTextColor, fontWeight: FontWeight.bold),),
        const SizedBox(height: 10,),
        ValueListenableBuilder(
          valueListenable: provider.isDragging,
          builder: (context,isDragging, child) {
            return DottedBorder(
                borderType: BorderType.RRect,
                dashPattern: const [6, 6],
                strokeWidth: 1,
                color: isDragging ?  AppColors.primaryColor :  AppColors.focusedBorder,
                child: provider.filePickerResult.count <= 0 ? DropTarget(
                  onDragEntered: (value){
                    provider.isDragging.value =true;
                  },
                  onDragExited: (value){
                    provider.isDragging.value =false;
                  },
                  onDragDone: (value) async{
                    if(Utils.getFileExtension(value.files[0].name ?? '') != '.png' && Utils.getFileExtension(value.files[0].name ?? '') != '.jpg' && Utils.getFileExtension(value.files[0].name ?? '') != '.pdf' && Utils.getFileExtension(value.files[0].name ?? '') != '.doc'){
                      CustomSnackbar(
                          message: AppLocalizations.of(context).the_selected_file_is_not_allowed,
                          context: context)
                          .showSnackbar();
                    }else{
                      provider.filePickerResult = FilePickerResult([PlatformFile.fromMap({'name' : value.files[0].name, 'size' : await value.files[0].length(), 'path' : value.files[0].path, 'bytes': await value.files[0].readAsBytes()})]);
                      provider.notifyListener();
                    }
                  }, child: Stack(
                    children: [
                      Row(
                      children: [
                        Flexible(
                          child: InkWell(
                            onTap: (){
                              FilePicker.platform.pickFiles(
                                  allowMultiple: false,
                                  type: FileType.custom,
                                  allowedExtensions: ['.pdf','.jpg','.png','.doc']
                              ).then((value){
                                if(value?.xFiles.where((test)=> Utils.getFileExtension(test.name) != '.png' && Utils.getFileExtension(test.name) != '.jpg' && Utils.getFileExtension(test.name) != '.pdf' && Utils.getFileExtension(test.name) != '.doc').isNotEmpty?? false){
                                  CustomSnackbar(
                                      message: AppLocalizations.of(context).the_selected_file_is_not_allowed,
                                      context: context)
                                      .showSnackbar();
                                }else{
                                  provider.filePickerResult = value ?? const FilePickerResult([]);
                                  provider.notifyListener();
                                }

                              });
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                              ),
                              padding: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 10, bottom: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.upload, size: 20,),
                                  Flexible(child: Text(AppLocalizations.of(context).upload))
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Flexible(child: Text(AppLocalizations.of(context).drag_here_to_upload))
                      ],
                                      ),
                      if(isDragging)Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                              color: isDragging? AppColors.greenColor.withOpacity(0.5) : Colors.transparent
                          ),
                        ),
                      )
                    ],
                  ),
                ) :
            Row(
              children: [
                Expanded(child: Utils.getFileExtension(provider.filePickerResult.files[0].name  ?? '') == '.png' || Utils.getFileExtension(provider.filePickerResult.files[0].name  ?? '') == '.jpg'? Image.memory(Uint8List.fromList(provider.filePickerResult.files[0].bytes?.toList() ?? []),height: 300,) :
                Utils.getFileExtension(provider.filePickerResult.files[0].name  ?? '') == '.pdf'? Column(
                  children: [
                    SvgPicture.asset(height: 100,'asset/images/file-type-pdf2.svg'),
                    const SizedBox(height: 5,),
                    Text(provider.filePickerResult.files[0].name, style: FontStyles.labelSmall,)
                  ],
                )  :  Column(
                  children: [
                    SvgPicture.asset(height: 100,'asset/images/microsoft-word.svg'),
                    const SizedBox(height: 5,),
                    Text(provider.filePickerResult.files[0].name, style: FontStyles.labelSmall,)
                  ],
                )
                )
              ],
            )
            );
          }
        ),
        const SizedBox(height: 5,),
        InkWell(
          onTap: (){
            provider.filePickerResult = const FilePickerResult([]);
            provider.notifyListener();
          },
          child: Text(
            AppLocalizations.of(context).clear_file,
            style: FontStyles.labelMedium.copyWith(color: AppColors.primaryColor),
          ),
        ),
        const SizedBox(height: 10,),
        RichText(text: TextSpan(
          text: '${AppLocalizations.of(context).allowed_extension}: ',
          style: FontStyles.labelMedium.copyWith(fontWeight: FontWeight.bold),
          children: const [
            TextSpan(
              text: 'pdf, jpg, png, doc',
              style: FontStyles.labelSmall,
            )
          ]
        )),
        const SizedBox(height: 20,),
      ],
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
      child: ValueListenableBuilder(valueListenable: provider.isBottomButtonLoading, builder: (context, value, child){
        return CustomButton(
            buttonText: AppLocalizations.of(context).next_button_text,
            onPressed: () {
              if(enableDisableButtonBg(currentIndex,provider)){
                provider.updateDetails(context,currentIndex);
              }
            },
            isLoading: value,
            loadingColor: AppColors.white,
            backgroundColor: enableDisableButtonBg(currentIndex, provider)?  AppColors.primaryColor : AppColors.greyButtonBg,
            textStyle: FontStyles.labelMedium
                .copyWith(color: AppColors.white));
      })
    );
  }


  bool enableDisableButtonBg(int currentIndex, CreateContractViewModel provider){
    if(currentIndex ==0){
      return provider.checkBasicDetails(context);
    }else if (currentIndex == 1){
      if(provider.rxSellGstProducts.value == 1){
        return provider.validGstNumber<bool>(context, provider.gstNoTextField.text);
      }else{
        return provider.validPanNumber<bool>(context, provider.panNoTextField.text) && provider.validatePanName(context, provider.panNameTextField.text, canShowError: false) && provider.validatePanDocument(context);
      }
    }

    return false;
  }


}
