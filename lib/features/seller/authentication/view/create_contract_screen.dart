import 'package:flutter/material.dart';
import 'package:frontend_ecommerce/constants/color_constants.dart';
import 'package:frontend_ecommerce/features/shared/custom_stepper.dart';
import 'package:provider/provider.dart';

import '../view_model/create_contract_view_model.dart';

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
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Consumer<CreateContractViewModel>(builder: (context, provider, child){
            return  CustomStepper(data: provider.stepperData,onChanged: (stepIndex){
              provider.goToSelectedStepperIndex(stepIndex);
            },);
            });
        }
      ),
    );
  }
}
