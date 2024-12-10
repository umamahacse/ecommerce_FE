

import 'package:flutter/material.dart';

import '../../../../utils/validators/pattern_validator.dart';
import '../../../shared/model/stepper_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateContractViewModel extends ChangeNotifier{

  final int? steps = 5;
  final List<StepperData> stepperData = [];
  final GlobalKey<FormState> firstNameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> lastNameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> confirmPasswordFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController(text: "");
  TextEditingController lastNameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController confirmPasswordController = TextEditingController(text: "");
  String? firstNameErrorText;
  String? lastNameErrorText;
  String? emailErrorText;
  String? passwordErrorText;
  String? confirmPasswordErrorText;

  setInitialStepperData(){
    stepperData.clear();
    stepperData.add(StepperData(headerTitle: 'Personal Information',isCurrentStep: true, stepCompleted: false));
    stepperData.add(StepperData(headerTitle: 'GST Verification',isCurrentStep: false, stepCompleted: false));
    stepperData.add(StepperData(headerTitle: 'Store Details',isCurrentStep: false, stepCompleted: false));
    stepperData.add(StepperData(headerTitle: 'Tax and Account Information',isCurrentStep: false, stepCompleted: false));
    stepperData.add(StepperData(headerTitle: 'Shipping Information',isCurrentStep: false, stepCompleted: false));
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


  setStepCompleted(int index, bool isCompleted){
    stepperData[index].stepCompleted = isCompleted;
  }

  goToNextStep(int currentIndex){
    for(int i = 0; i< stepperData.length; i++){
      stepperData[i].isCurrentStep = false;
    }
    if(currentIndex < (stepperData.length - 1)){
      stepperData[currentIndex + 1].isCurrentStep = true;
    }
    notifyListeners();
  }

  goToSelectedStepperIndex(int index){
    for(int i = 0; i< stepperData.length; i++){
      stepperData[i].isCurrentStep = false;
    }
    stepperData[index].isCurrentStep = true;
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


}
