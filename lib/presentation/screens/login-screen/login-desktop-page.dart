import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/screens/login-screen/login-screen.dart';
import 'package:aquae_florentis/presentation/screens/intro-screen/onboarding-desktop.dart';
import 'package:aquae_florentis/presentation/utilities/responsive.dart';
import 'package:flutter/material.dart';

import '../../resources/value-manager.dart';

class LoginDesktopPage extends StatefulWidget {
  const LoginDesktopPage({super.key});

  @override
  State<LoginDesktopPage> createState() => _LoginDesktopPageState();
}

class _LoginDesktopPageState extends State<LoginDesktopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              if(!Responsive.isMobile(context))
              const Expanded(flex: 7, child: OnBoardingPageDesktop()),
              const Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.all(SizeManager.extralarge * 3),
                    child: LoginPage(),
                  ))
            ],
          )),
    );
  }
}
