import 'package:flutter/material.dart';
import 'package:frontend_ecommerce/common/styles/font_style.dart';

import '../../constants/color_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailsFooterSection extends StatefulWidget {
  const DetailsFooterSection({super.key});

  @override
  State<DetailsFooterSection> createState() => _DetailsFooterSectionState();
}

class _DetailsFooterSectionState extends State<DetailsFooterSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 25,end: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          const Divider(
            height: 1,
            color: AppColors.inActiveBorder,
          ),
          const SizedBox(height: 10,),
           Row(
            children: [
              const Icon(Icons.lock),
              const SizedBox(width: 5,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(top: 3),
                  child: Text(AppLocalizations.of(context).save_information_policy_msg,style: FontStyles.labelMedium,),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 0),
                child: InkWell(
                    onTap: (){},
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Text(AppLocalizations.of(context).contact_seller_support, style: FontStyles.labelMedium.copyWith(color: AppColors.primaryColor),)),
              ),
              Column(
                children: [
                  Text(AppLocalizations.of(context).copy_right_text,style: FontStyles.labelSmall,),
                  const SizedBox(height: 5,),
                  InkWell(
                    onTap: (){},
                    child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                        ),
                        padding: const EdgeInsetsDirectional.only(top: 5, bottom: 5, start: 20, end: 20),
                        child: Text(AppLocalizations.of(context).feedback_capital, style: FontStyles.labelSmall.copyWith(color: AppColors.white),)),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
