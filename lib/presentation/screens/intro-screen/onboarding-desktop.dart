import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'onboarding-item.dart';

class OnBoardingPageDesktop extends StatefulWidget {
  final bool isLogin;
  const OnBoardingPageDesktop({super.key, this.isLogin = true});

  @override
  State<OnBoardingPageDesktop> createState() => _OnBoardingPageDesktopState();
}

class _OnBoardingPageDesktopState extends State<OnBoardingPageDesktop> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: !widget.isLogin
          ? OnBoardingDesktopClipperLeft()
          : OnBoardingDesktopClipperRight(),
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: ColorManager.tertiary,
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.only(
              right: widget.isLogin ? SizeManager.extralarge * 2 : 0,
              left: !widget.isLogin ? SizeManager.extralarge * 2 : 0),
          padding:
              const EdgeInsets.symmetric(horizontal: SizeManager.extralarge),
          child: CarouselSlider.builder(
              itemCount: onboardingModels.length,
              disableGesture: true,
              itemBuilder: (context, index, realIndex) {
                return Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: OnboardingItemPage(model: onboardingModels[index]),
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: true,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                enlargeCenterPage: true,
                viewportFraction: 0.31,
                height: 500,
                autoPlayInterval: const Duration(seconds: 6),
              )),
        ),
      ),
    );
  }
}

class OnBoardingDesktopClipperRight extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    final double w = size.width;
    final double h = size.height;
    final double startPointX = w * 0.8;
    final double startPointY = h;
    path.lineTo(0, h);
    path.lineTo(startPointX, startPointY);
    path.quadraticBezierTo(w * 1.2025, h * 0.5, startPointX, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class OnBoardingDesktopClipperLeft extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    final double w = size.width;
    final double h = size.height;
    final double neg = -(w * 0.2025);

    final double startPointX = w * 0.2;
    final double startPointY = h;
    path.lineTo(w, 0);
    path.lineTo(w, h);
    path.lineTo(startPointX, startPointY);
    path.quadraticBezierTo(neg, h * 0.5, startPointX, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
