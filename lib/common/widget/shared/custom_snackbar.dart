import 'package:flutter/material.dart';
import 'package:frontend_ecommerce/constants/color_constants.dart';
import 'package:frontend_ecommerce/utils/responsive_layout.dart';

class CustomSnackbar{

  BuildContext context;
  String message;
  Duration timeToShow;

  CustomSnackbar({required this.context, required this.message, this.timeToShow = const Duration(seconds: 5)});

  OverlayEntry? _overlayEntry;

  void showSnackbar() {
    _overlayEntry = _createOverlayEntry();

    Overlay.of(context).insert(_overlayEntry!);

    // Remove the snackbar after 2 seconds
    Future.delayed(timeToShow, () {
      hideSnackbar();
    });
  }

   OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: ResponsiveWidget.isSmallScreen(context) ? null : 50,
        right: ResponsiveWidget.isSmallScreen(context) ? 20 : 70,
        left: ResponsiveWidget.isSmallScreen(context) ? 20 : null,
        bottom: ResponsiveWidget.isSmallScreen(context) ? 20 : null,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.snackbarBgColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.primaryColor)
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  message,
                  style: const TextStyle(color: AppColors.secondaryTextColor),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: hideSnackbar,
                  child: const Icon(
                    Icons.close,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void hideSnackbar() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}