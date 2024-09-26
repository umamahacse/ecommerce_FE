import 'package:flutter/material.dart';
import 'package:frontend_ecommerce/constants/screen_size_constants.dart';

class ResponsiveWidget {

  static bool isSmallScreen(BuildContext context){
    return ((MediaQuery.of(context).size.width < ScreenSizeConstants.mobileBreakPoint) ||
    (ScreenSizeConstants.isMobile));
  }

  static bool isDesktop(BuildContext context){
    return ((MediaQuery.of(context).size.width > ScreenSizeConstants.desktopBreakPoint) ||
    !(ScreenSizeConstants.isMobile));
  }

  static double getWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }

}