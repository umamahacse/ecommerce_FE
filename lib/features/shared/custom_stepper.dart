import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';
import 'model/stepper_data.dart';

class CustomStepper extends StatelessWidget {
  const CustomStepper({super.key, this.data,this.onChanged});

  final List<StepperData>? data;
  final Function(int stepIndex)? onChanged;


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: stepperChildrenHeader(),
      ),
    );
  }

  List<Widget> stepperChildrenHeader(){
    List<Widget> items = [];

    for(int i =0 ; i< (data?.length ?? 0); i++){
      items.add(
          IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    InkWell(
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: (){
                        onChanged?.call(i);
                      },
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 20,end: 20),
                          child: Text(data?[i].headerTitle ?? '', style: TextStyle(color: data?[i].isCurrentStep ?? false ? AppColors.primaryColor : AppColors.secondaryTextColor),),
                        ),
                        const SizedBox(height: 10,),
                        Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    height: 1.5,
                                    color: (i <=  0)?  Colors.transparent : (data?[i-1].stepCompleted ?? false)? AppColors.primaryColor : AppColors.stepperInactiveBorder,
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    height: 1.5,
                                    color: (i < ((data?.length ?? 0) -1 )) ? (data?[i].stepCompleted ?? false)? AppColors.primaryColor : AppColors.stepperInactiveBorder : Colors.transparent,
                                  ),
                                )
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color:data?[i].isCurrentStep ?? false? AppColors.white : ( data?[i].stepCompleted ?? false)? AppColors.primaryColor : AppColors.stepperInactiveBorder,
                                  border: Border.all(color: (data?[i].isCurrentStep ?? false)? AppColors.primaryColor : Colors.transparent),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              constraints: const BoxConstraints(
                                  maxWidth: 10,
                                  maxHeight: 10
                              ),
                              padding: const EdgeInsets.all(20),
                            ),
                          ],
                        ),
                      ],),
                    )
                  ],
                )
              ],
            ),
          )
      );
    }


    return items;
  }

}
