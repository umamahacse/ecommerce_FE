import 'package:flutter/material.dart';
import 'package:frontend_ecommerce/constants/color_constants.dart';
import 'package:frontend_ecommerce/features/shared/custom_stepper.dart';
import 'package:provider/provider.dart';

import '../../../../constants/screen_size_constants.dart';
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
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 20),
      child: Row(
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
    );
  }

  Widget tabletLayout(BuildContext context, CreateContractViewModel provider){
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 20),
      child: Row(
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
    );
  }

  Widget desktopOrTvLayout(BuildContext context, CreateContractViewModel provider){
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 20, top: 50, end: 20),
      child: Row(
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
    );
  }


}
