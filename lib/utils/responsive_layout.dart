import 'package:flutter/material.dart';
import 'package:frontend_ecommerce/constants/screen_size_constants.dart';

class ResponsiveWidget {

  static bool isSmallScreen(BuildContext context){
    return ((MediaQuery.of(context).size.width < ScreenSizeConstants.mobileBreakPoint));
  }

  static bool isTablet(BuildContext context){
    return ((MediaQuery.of(context).size.width >= ScreenSizeConstants.mobileBreakPoint) && (MediaQuery.of(context).size.width < ScreenSizeConstants.tabletBreakPoint));
  }

  static bool isDesktop(BuildContext context){
    return ((MediaQuery.of(context).size.width >= ScreenSizeConstants.tabletBreakPoint) && (MediaQuery.of(context).size.width < ScreenSizeConstants.desktopBreakPoint));
  }

  static double getWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }


  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).size.height > MediaQuery.of(context).size.width;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;
  }

  static bool isSquareOrAlmostSquare(BuildContext context, [double tolerance = 0.1]) {
    double aspectRatio = MediaQuery.of(context).size.width / MediaQuery.of(context).size.height;
    return (aspectRatio - 1).abs() <= tolerance;
  }

}