import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_ecommerce/common/styles/font_style.dart';
import 'package:frontend_ecommerce/constants/color_constants.dart';
import 'package:frontend_ecommerce/route/router_constant.dart';
import 'package:go_router/go_router.dart';

class HeaderTextBeforeLogin extends StatelessWidget {
  const HeaderTextBeforeLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(AppLocalizations.of(context).login, style: FontStyles.labelLarge.copyWith(color: AppColors.primaryColor)),
        SizedBox(
          width: 12.w,
        ),
        InkWell(
          onTap: () => context.go(AppPages.auth+AppPages.buyerRegister),
          child: Text(
            AppLocalizations.of(context).signup,
            style: FontStyles.labelLarge.copyWith(color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
