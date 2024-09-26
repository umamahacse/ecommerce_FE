import 'package:flutter/material.dart';
import 'package:frontend_ecommerce/constants/color_constants.dart';
import 'package:frontend_ecommerce/features/buyer/authentication/view/register_form.dart';
import 'package:frontend_ecommerce/utils/responsive_layout.dart';

class BuyerRegister extends StatelessWidget {
  const BuyerRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              ResponsiveWidget.isSmallScreen(context) ? const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            RegisterForm()
                        ],
                      ),
                    )
              : Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset('asset/images/register.jpeg',
                      fit: BoxFit.cover,),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            RegisterForm()
                        ],
                      ),
                    )
                ],),
              )
              
            ],
          ),
        ),
      ),
    );
  }
}
