

import 'package:flutter/material.dart';

import '../../../shared/model/stepper_data.dart';

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
    stepperData.add(StepperData(headerTitle: 'Personal Information',isCurrentStep: false, stepCompleted: true));
    stepperData.add(StepperData(headerTitle: 'GST Verification',isCurrentStep: true, stepCompleted: false));
    stepperData.add(StepperData(headerTitle: 'Store Details',isCurrentStep: false, stepCompleted: false));
    stepperData.add(StepperData(headerTitle: 'Tax and Account Information',isCurrentStep: false, stepCompleted: false));
    stepperData.add(StepperData(headerTitle: 'Shipping Information',isCurrentStep: false, stepCompleted: false));
    notifyListeners();
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


  bool checkBasicDetails(){

    // TODO:
    // logic to check all the fields is yet to be implemented.
    return false;
  }


}
