// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers
import 'package:aquae_florentis/app/platform.dart';
import 'package:aquae_florentis/app/routes-manager.dart';
import 'package:aquae_florentis/data/firestore.dart';
import 'package:aquae_florentis/presentation/providers/community-provider.dart';
import 'package:aquae_florentis/presentation/providers/user-provider.dart';
import 'package:aquae_florentis/presentation/widgets/logo-widget.dart';
import 'package:aquae_florentis/presentation/widgets/lottie-widget.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

final kUiOverlayStyle = SystemUiOverlayStyle.light.copyWith(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.light,
    );

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  bool animate = false;
  bool load = false;
  @override
  void initState() {
    super.initState();
    // Waits 4 seconds, then shows loader.
    // Waits another 10 seconds then switches to into page.
    // Meaning 14 seconds all together
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      loadingVoid();
    });
  }

  Future<void> loadingVoid() async {
    final user = ref.read(UserProvider.userProvider);
    SystemChrome.setSystemUIOverlayStyle(kUiOverlayStyle);
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      load = true;
    });
    if (user != null) {
      final allUsers = await AppFireStore.allUsers();
      final currentUser = allUsers.firstWhere((_user) => _user.id == user.id);
      UserProvider.saveUserData(ref: ref, json: currentUser.toJson());
      var community = await ref.read(UserProvider.userProvider)!.getCommunity();
      if (mounted) {
        ref.read(communityProvider.notifier).state = community;
      }
      // Saved latest user data
    } else {
      await Future.delayed(const Duration(seconds: 4));
    }
    setState(() {
      animate = true;
    });
    await Future.delayed(
        const Duration(seconds: ValuesManager.splashAnimationDuration));
    // Switch to intro page.
    if (user != null) {
      Navigator.pushReplacementNamed(context, Routes.dashboardRoute);
      return;
    }
    Navigator.pushReplacementNamed(context,
        AppPlatform.isMobile ? Routes.introRoute : Routes.loginDesktopRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LogoWidget(),
                    mediumSpacer(),
                    AnimatedCrossFade(
                        firstChild: Text(
                          load ? "" : ValuesManager.APP_NAME,
                          style: GoogleFonts.quicksand(
                              color: ColorManager.primary,
                              fontSize: FontSizeManager.large,
                              fontWeight: FontWeightManager.medium),
                        ),
                        secondChild: const LottieIcon('loading',
                            repeat: true, size: 60, fit: BoxFit.cover),
                        crossFadeState: load
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        firstCurve: Curves.ease,
                        alignment: Alignment.center,
                        sizeCurve: Curves.ease,
                        duration: const Duration(seconds: 2))
                  ]),
            ),
            Visibility(
                visible: animate,
                child: LottieIcon(
                  'loading-full',
                  size: double.maxFinite,
                  repeat: animate,
                ))
          ],
        ),
      ),
    );
  }
}
