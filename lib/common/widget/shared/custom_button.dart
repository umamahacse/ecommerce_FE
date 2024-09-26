import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend_ecommerce/constants/dimen_constant.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color? backgroundColor;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final String? iconPath;

  const CustomButton({
    super.key,
    required this.buttonText,
    this.backgroundColor,
    required this.onPressed,
    this.textStyle,
    this.iconPath
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
       style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.all(DimenConstant.buttonPadding),
        textStyle: textStyle ?? const TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(DimenConstant.buttonCornerRadius))),
      ),
      onPressed: onPressed,
      icon: iconPath != null ? SvgPicture.asset(iconPath!) : const SizedBox.shrink(),
      label: Text(buttonText, style: textStyle,),
    );
  }
}