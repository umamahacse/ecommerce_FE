import 'package:flutter/material.dart';
import 'package:frontend_ecommerce/constants/color_constants.dart';
import 'package:frontend_ecommerce/features/seller/authentication/view/seller_register_form.dart';
import 'package:frontend_ecommerce/utils/responsive_layout.dart';

class SellerRegister extends StatelessWidget {
  const SellerRegister({super.key});

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
              ResponsiveWidget.isSmallScreen(context) ? Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SellerRegisterForm()
                    ],
                  ),
                ),
              )
                  : Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: AppColors.inActiveBorder,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset('asset/images/seller.jpeg',
                          fit: BoxFit.cover,),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SellerRegisterForm()
                          ],
                        ),
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
