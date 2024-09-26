import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_ecommerce/common/widget/app_logo.dart';
import 'package:frontend_ecommerce/common/widget/header_text_before_login.dart';
import 'package:frontend_ecommerce/constants/color_constants.dart';
import 'package:frontend_ecommerce/constants/dimen_constant.dart';
import 'package:frontend_ecommerce/utils/responsive_layout.dart';

class HeaderBeforeLogin extends StatelessWidget {

  final bool isLoginShown;
  
  const HeaderBeforeLogin({super.key, this.isLoginShown = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveWidget.getWidth(context),
      height: ResponsiveWidget.isDesktop(context) ? 100.h : 20.h,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primaryColor, 
            Colors.white30,
            Colors.white60,
            AppColors.white,
          ],
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: DimenConstant.defaultPadding),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [const AppLogo(), 
          isLoginShown ? const HeaderTextBeforeLogin() : const SizedBox.shrink()],
        ),
      ),
    );
  }
}
