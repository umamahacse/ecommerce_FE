

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend_ecommerce/route/router_constant.dart';

import '../../../../utils/validators/pattern_validator.dart';
import '../../../shared/model/stepper_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:html' as html;

class CreateContractViewModel extends ChangeNotifier{

  final int? steps = 5;
  final List<StepperData> stepperData = [];
  final GlobalKey<FormState> firstNameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> lastNameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> confirmPasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> gstNoFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> panNoFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> panNameFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController(text: "");
  TextEditingController lastNameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController confirmPasswordController = TextEditingController(text: "");
  TextEditingController gstNoTextField = TextEditingController(text: "");
  TextEditingController panNoTextField = TextEditingController(text: "");
  TextEditingController panNameTextField = TextEditingController(text: "");
  String? firstNameErrorText;
  String? lastNameErrorText;
  String? emailErrorText;
  String? passwordErrorText;
  String? confirmPasswordErrorText;
  String? gstNoErrorText;
  String? panNoErrorText;
  String? panNameErrorText;
  ValueNotifier<int> rxSellGstProducts = ValueNotifier<int>(1);
  FilePickerResult filePickerResult = const FilePickerResult([]);
  ValueNotifier<bool> isDragging = ValueNotifier<bool>(false);

  setInitialStepperData(context, {int currentStep = -1}){
    stepperData.clear();
    stepperData.add(StepperData(headerTitle: AppLocalizations.of(context).personal_information,isCurrentStep: false, stepCompleted: false));
    stepperData.add(StepperData(headerTitle: AppLocalizations.of(context).gst_verification,isCurrentStep: false, stepCompleted: false));
    stepperData.add(StepperData(headerTitle: AppLocalizations.of(context).store_details,isCurrentStep: false, stepCompleted: false));
    stepperData.add(StepperData(headerTitle: AppLocalizations.of(context).tax_and_account_information,isCurrentStep: false, stepCompleted: false));
    stepperData.add(StepperData(headerTitle: AppLocalizations.of(context).shipping_information,isCurrentStep: false, stepCompleted: false));


    if(currentStep > stepperData.length){
      /// Todo: check from the api and set the current step and also how many steps completed
      stepperData[0].isCurrentStep =true;
    }else{
      for(int i = 0; i <= currentStep; i++){
        if(i + 1 == currentStep){
          stepperData[i].isCurrentStep = true;
        }

        // Todo: To implement the steps completed from api.
        // For now i have implemented like, if current step is 3 then all the previous steps by default set as completed.
        if(i < (currentStep -1)){
          stepperData[i].stepCompleted = true;
        }
      }
    }
    notifyListeners();
  }


  T validateEmail<T>(context, String? value) {
    emailErrorText = PatternValidator.isValidEmail(
        context,
        value,
        AppLocalizations.of(context).email_mandatory,
        AppLocalizations.of(context).invalid_email);
    if(T == dynamic){
      notifyListeners();
    }
    return (emailErrorText?.isEmpty?? true) as T;
  }

 T validateName<T>(context, String? value, bool isFirstName) {
    if (isFirstName) {
      firstNameErrorText = PatternValidator.isValidName(
          context,
          value,
          AppLocalizations.of(context).first_name_mandatory,
          AppLocalizations.of(context).invalid_first_name);
      if(T == dynamic){
        notifyListeners();
      }
      return (firstNameErrorText?.isEmpty ?? true) as T;
    } else {
      lastNameErrorText = PatternValidator.isValidName(
          context,
          value,
          AppLocalizations.of(context).last_name_mandatory,
          AppLocalizations.of(context).invalid_last_name);
      if(T == dynamic){
        notifyListeners();
      }
      return (lastNameErrorText?.isEmpty ?? true) as T;
    }
  }

 T validatePassword<T>(context, String? value, bool isPassword,
      {String password = ""}) {
    if (isPassword) {
      passwordErrorText = PatternValidator.isValidPassword(
          context,
          value,
          AppLocalizations.of(context).password_mandatory,
          AppLocalizations.of(context).invalid_password);
      if(T == dynamic){
        notifyListeners();
      }
      return (passwordErrorText?.isEmpty ?? true) as T;
    } else {
      confirmPasswordErrorText = PatternValidator.isValidPassword(
          context,
          value,
          AppLocalizations.of(context).confirm_password_mandatory,
          AppLocalizations.of(context).invalid_password,
          confirmPassword: password,
          misMatchErrorText:
          AppLocalizations.of(context).password_confrim_password_match);
      if(T == dynamic){
        notifyListeners();
      }
      return (confirmPasswordErrorText?.isEmpty ?? true) as T;
    }
  }

  T validGstNumber<T>(context, String value){
    if(T == dynamic){
      if(PatternValidator.isValidGstNumber(context, value)?? false){
        gstNoErrorText = '';
      }else{
        gstNoErrorText = AppLocalizations.of(context).please_enter_a_valid_gst_number;
      }

      notifyListeners();
      return (gstNoErrorText?.isEmpty ?? true) as T;
    }else{
      String gstNoErrorText = '';
      if(PatternValidator.isValidGstNumber(context, value)?? false){
         gstNoErrorText = '';
      }else{
        gstNoErrorText = AppLocalizations.of(context).please_enter_a_valid_gst_number;
      }
      return (gstNoErrorText.isEmpty) as T;
    }
  }


  T validPanNumber<T>(context, String value){
    if(T == dynamic){
      if(PatternValidator.isValidPanNumber(context, value)?? false){
        panNoErrorText = '';
      }else{
        panNoErrorText = AppLocalizations.of(context).please_enter_a_valid_pan_card_number;
      }
      notifyListeners();
      return (panNoErrorText?.isEmpty ?? true) as T;
    }else{
      String panNoErrorText = '';
      if(PatternValidator.isValidPanNumber(context, value)?? false){
        panNoErrorText = '';
      }else{
        panNoErrorText = AppLocalizations.of(context).please_enter_a_valid_pan_card_number;
      }
      return (panNoErrorText.isEmpty) as T;
    }
  }


  bool validatePanName(context, String value, {bool canShowError = true}){
    if(value.isNotEmpty){
      panNameErrorText = '';
      if(canShowError){
        notifyListeners();
      }
      return true;
    }
    if(canShowError){
      panNameErrorText = AppLocalizations.of(context).please_enter_pan_name;
      notifyListeners();
    }
    return false;
  }

  bool validatePanDocument(context){
    if(filePickerResult.count > 0){
      return true;
    }
    return false;
  }


  setStepCompleted(int index, bool isCompleted){
    stepperData[index].stepCompleted = isCompleted;
  }

  goToNextStep(int currentIndex){

    if(currentIndex < (stepperData.length - 1)){
      for(int i = 0; i< stepperData.length; i++){
        stepperData[i].isCurrentStep = false;
      }
      stepperData[currentIndex + 1].isCurrentStep = true;
      updateStepInUrl(currentIndex+2);
      notifyListeners();
    }else{
      /// Todo: Go to next page after full completion of create contract;
    }
  }


  void updateStepInUrl(int step){
    html.window.history.pushState({}, '', '/#${AppPages.auth}${AppPages.sellerCreateContract}?step=$step');
  }


  goToSelectedStepperIndex(int index){
    for(int i = 0; i< stepperData.length; i++){
      stepperData[i].isCurrentStep = false;
    }
    stepperData[index].isCurrentStep = true;
    updateStepInUrl(index + 1);
    notifyListeners();
  }


  bool checkBasicDetails(context){
    if(emailController.text.isEmpty || firstNameController.text.isEmpty || lastNameController.text.isEmpty || passwordController.text.isEmpty || confirmPasswordController.text.isEmpty){
      return false;
    }

    if(validateEmail<bool>(context, emailController.text) && validateName(context, firstNameController.text, true) && validateName(context, lastNameController.text, false) && validatePassword(context, passwordController.text, true) && validatePassword(context, confirmPasswordController.text, false, password: passwordController.text)){

      return true;
    }

    return false;
  }


  void notifyListener(){
    notifyListeners();
  }

}
