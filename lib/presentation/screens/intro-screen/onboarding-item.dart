import 'package:aquae_florentis/domain/models/onboarding-models.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/widgets/lottie-widget.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingItemPage extends StatefulWidget {
  final OnboardingModel model;
  const OnboardingItemPage({super.key, required this.model});

  @override
  State<OnboardingItemPage> createState() => _OnboardingItemPageState();
}

class _OnboardingItemPageState extends State<OnboardingItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.model.primary,
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Container(
              width: double.maxFinite,
              height: double.maxFinite,
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieIcon(
                    widget.model.lottie,
                    size: 170,
                    fit: BoxFit.fitWidth,
                    repeat: true,
                  ),
                  largeSpacer(),
                  Text(
                    widget.model.text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                        color: ColorManager.primaryDark,
                        fontSize: FontSizeManager.regular,
                        fontWeight: FontWeightManager.medium),
                  )
                ],
              ),
            ),
            SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Column(
                  children: [
                    ClipPath(
                      clipper: CustomBezierClipper(),
                      child: Container(
                        width: double.maxFinite,
                        height: 200,
                        color: widget.model.secondary,
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class CustomBezierClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    Offset controlOffset1 = Offset(size.width * 0.1, size.height * 0.9);
    Offset endOffset1 = Offset(size.width * 0.325, size.height * 0.7);

    Offset controlOffset2 = Offset(size.width * 0.6, size.height * 0.4);
    Offset endOffset2 = Offset(size.width * 0.7, size.height * 0.575);

    Offset controlOffset3 = Offset(size.width * 0.85, size.height * 0.8);
    Offset endOffset3 = Offset(size.width, size.height * 0.4);

    path.lineTo(0, size.height * 0.7);
    path.quadraticBezierTo(
        controlOffset1.dx, controlOffset1.dy, endOffset1.dx, endOffset1.dy);
    path.quadraticBezierTo(
        controlOffset2.dx, controlOffset2.dy, endOffset2.dx, endOffset2.dy);
    path.quadraticBezierTo(
        controlOffset3.dx, controlOffset3.dy, endOffset3.dx, endOffset3.dy);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
