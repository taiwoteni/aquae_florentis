import 'package:aquae_florentis/data/location.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aquae_florentis/app/routes-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/widgets/indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app/platform.dart';
import '../../resources/value-manager.dart';
import 'onboarding-item.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  final bool showIndicators;
  const OnboardingPage({super.key, this.showIndicators = true});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final PageController controller = PageController();
  final bool isMobile = AppPlatform.isMobile;
  int pageIndex = 0;
  int indicatorIndex = 0;
  // indicator index is made because pageIndex shifts to 0 earlier when at 1 because of carousel.
  late List<Widget> pages;

  @override
  void initState() {
    initializePage();
    super.initState();
    currentLocation();
  }

  void initializePage() {
    pages = onboardingModels
        .map((onboardingModel) => OnboardingItemPage(model: onboardingModel))
        .toList();
  }
  Future<void> currentLocation() async {
    await LocationService.askPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: PageView(
                controller: controller,
                physics: isMobile
                    ? const BouncingScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                onPageChanged: (value) {
                  if (isMobile) {
                    setState(() {
                      pageIndex = value;
                    });
                  }
                },
                children: pages,
              ),
            ),
            if(pageIndex == pages.length-1)
            Positioned(
              bottom: 20,
                right: 20,
              child: GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(context, Routes.loginRoute),
                child: Text(
                  "NEXT",
                  style: GoogleFonts.quicksand(
                    fontSize: FontSizeManager.large * 0.8,
                    fontWeight: FontWeightManager.bold,
                    color: Colors.white
                  ),
                ),
              )),
            if(widget.showIndicators)
            Positioned(
                bottom: 20,
                right: 20,
                left: 20,
                child: SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                          pages.length,
                          growable: false,
                          (index) => Indicator(active: index == pageIndex, size: 8,))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  
}
