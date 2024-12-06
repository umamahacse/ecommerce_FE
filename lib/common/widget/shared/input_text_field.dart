import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_ecommerce/common/styles/font_style.dart';
import 'package:frontend_ecommerce/constants/color_constants.dart';

class InputTextField extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String hintText;
  final String labelText;
  final bool isObscureText;
  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool? isEnabled;
  final String? errorText;
  final FormFieldValidator<String>? onVaildate;
  final Function(String)? onTextChange;
  final List<TextInputFormatter>? inputFormatters;
  final Color cursorColor;
  final Color focusedBorderColor;
  final Color textColor;
  final Color inactiveBorderColor;

  const InputTextField(
      {super.key,
      required this.formKey,
      this.hintText = "",
      this.labelText = "",
      this.isObscureText = false,
      required this.controller,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.isEnabled = true,
      this.onTextChange,
      this.errorText,
      this.onVaildate,
      this.inputFormatters,
      this.cursorColor = AppColors.focusedBorder,
      this.focusedBorderColor = AppColors.focusedBorder,
      this.inactiveBorderColor = AppColors.inActiveBorder,
      this.textColor = AppColors.primaryTextColor});

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool _isHovered = false;
  bool isPasswordVisible = false;
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
  }

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            key: widget.formKey,
            controller: widget.controller,
            cursorColor: widget.cursorColor,
            style: FontStyles.labelMedium.copyWith(color: widget.textColor),
            obscureText: widget.isObscureText ? obscureText : false,
            decoration: InputDecoration(
              labelText: widget.labelText,
              hintText: widget.hintText,
              labelStyle: FontStyles.labelMedium,
              hintStyle: FontStyles.labelMedium,
              floatingLabelStyle: FontStyles.labelMedium,
              errorText: null,
              suffixIcon: widget.isObscureText
                    ? InkWell(
                      onTap: () => changeVisiblity(),
                      child: Container(
                        padding: const EdgeInsets.only(right: 20),
                        child: isPasswordVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                      ),
                    )
                  : const SizedBox.shrink(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: _isHovered
                      ? widget.focusedBorderColor // Hover border color
                      : widget.inactiveBorderColor, // Default border color
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      (widget.errorText != null && widget.errorText!.isNotEmpty)
                          ? Colors.red
                          : widget.focusedBorderColor, // Active border color
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.inactiveBorderColor, // Disabled border color
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.errorBorder, // Focused error border color
                ),
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: widget.onTextChange,
          ),
          Visibility(
            visible: (widget.errorText != null && widget.errorText!.isNotEmpty),
            replacement: const SizedBox(height: 22),
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                (widget.errorText != null && widget.errorText!.isNotEmpty)
                    ? widget.errorText!
                    : "",
                style: FontStyles.labelSmall
                    .copyWith(color: AppColors.errorTextColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

 changeVisiblity(){
  setState(() {
    isPasswordVisible = !isPasswordVisible;
    obscureText = !obscureText;
  });
 }

}
