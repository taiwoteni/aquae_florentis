import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/utilities/responsive.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/font-manager.dart';
import 'lottie-widget.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key, this.label, this.bgColor});
  final Color? bgColor;
  final String? label;

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    return Expanded(
        child: Container(
      width: double.maxFinite,
      color: widget.bgColor,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LottieIcon(
              "loading-water",
              size: 160,
              color: Colors.blue,
              repeat: true,
              fit: BoxFit.cover,
            ),
            if (widget.label != null) ...[
              mediumSpacer(),
              Text(
                widget.label!,
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
    ));
  }
}
