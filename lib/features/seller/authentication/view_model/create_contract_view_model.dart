

import 'package:flutter/material.dart';

import '../../../shared/model/stepper_data.dart';

class CreateContractViewModel extends ChangeNotifier{

  final int? steps = 5;
  final List<StepperData> stepperData = [];

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


}
