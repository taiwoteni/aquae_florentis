import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/utilities/responsive.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/font-manager.dart';
import 'lottie-widget.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key, this.lottie, this.label, this.bgColor});
  final Color? bgColor;
  final String? label, lottie;

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    return Expanded(
        child: Container(
      width: double.maxFinite,
      color: widget.bgColor,
      child: Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieIcon(
                widget.lottie ?? "error",
                size: 160,
                repeat: true,
                fit: BoxFit.cover,
              ),
              if (widget.label != null) ...[
                mediumSpacer(),
                Text(
                  widget.label!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    color: ColorManager.primary,
                    fontSize: isMobile
                        ? FontSizeManager.regular
                        : FontSizeManager.large,
                    fontWeight: FontWeightManager.medium,
                  ),
                )
              ]
            ]),
      ),
    ));
  }
}
