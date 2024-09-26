import 'package:flutter/material.dart';
import 'package:frontend_ecommerce/common/widget/header_before_login.dart';
import 'package:frontend_ecommerce/constants/color_constants.dart';


class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            HeaderBeforeLogin()
          ],
        ),
      ),
    );
  }
}