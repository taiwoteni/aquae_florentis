import 'package:aquae_florentis/app/platform.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resources/color-manager.dart';

class AppSnackbar {
  final BuildContext context;
  AppSnackbar({required this.context});

  Widget _actionButton(
      {required final String label, void Function()? onPressed, Color? color}) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: GoogleFonts.quicksand(
            fontSize: FontSizeManager.medium,
            color: color ?? ColorManager.background,
            fontWeight: FontWeight.w700,
          ),
        ));
  }

  void showSnackBar({
    final Duration? duration,
    final DecorationImage? profile,
    final bool? showAtTop,
    final Color? textColor,
    final Color? bgColor,
    final String? okLabel,
    final String? cancelLabel,
    required final String text,
    final void Function()? onOk,
    final void Function()? onCancel,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: ColorManager.primaryColor,
      duration: duration ?? const Duration(seconds: 3),
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), side: BorderSide.none),
      behavior: SnackBarBehavior.floating,
      margin: AppPlatform.isMobile
          ? const EdgeInsets.symmetric(
              vertical: SizeManager.large, horizontal: SizeManager.large)
          : null,
      width: AppPlatform.isDesktop ? MediaQuery.of(context).size.width / 2 : null,
      padding: const EdgeInsets.symmetric(
          vertical: SizeManager.large, horizontal: SizeManager.large),
      content: Text(
        text,
        style: GoogleFonts.quicksand(
            color: ColorManager.background,
            fontSize: FontSizeManager.medium,
            fontWeight: FontWeightManager.medium),
      ),
    ));
  }
}
