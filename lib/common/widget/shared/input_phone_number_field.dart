import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/color_constants.dart';
import '../../../utils/utils.dart';

class InputPhoneNumberField<T> extends StatefulWidget {
  const InputPhoneNumberField({super.key,this.onPhoneNumberChanged,this.phoneNumberController,this.onDialCodeChanged,this.initialDialCode});

  final Function(String?)? onDialCodeChanged;
  final Function(String?)? onPhoneNumberChanged;
  final String? initialDialCode;
  final TextEditingController? phoneNumberController;

  @override
  State<InputPhoneNumberField> createState() => _InputPhoneNumberFieldState();
}

class _InputPhoneNumberFieldState extends State<InputPhoneNumberField> {

  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: Row(
        children: [
          Container(
            color: AppColors.inActiveBorder,
            child: DropdownButton<String>(
                value: widget.initialDialCode,
                dropdownColor: AppColors.white,
                padding: const EdgeInsetsDirectional.only(start: 3, end: 3),
                underline: const SizedBox(),
                alignment: Alignment.center,
                items: Utils.getDialCodes().map((String dialCode) {
                  return DropdownMenuItem<String>(
                    value: dialCode,
                    child: Text(dialCode),
                  );
                }).toList(), onChanged: (value){
              widget.onDialCodeChanged?.call(value);
            }),
          ),
          const SizedBox(width: 20,),
          Flexible(
            child: TextField(
              controller: widget.phoneNumberController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value){
                widget.onPhoneNumberChanged?.call(value);
              },
              cursorColor: AppColors.darkBorder,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isHovered
                        ? AppColors.focusedBorder // Hover border color
                        : AppColors.inActiveBorder, // Default border color
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.focusedBorder, // Active border color
                  ),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.inActiveBorder, // Disabled border color
                  ),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.errorBorder, // Focused error border color
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
