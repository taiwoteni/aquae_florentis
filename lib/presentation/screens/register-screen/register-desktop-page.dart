import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/screens/intro-screen/onboarding-desktop.dart';
import 'package:aquae_florentis/presentation/utilities/responsive.dart';
import 'package:flutter/material.dart';

import '../../resources/value-manager.dart';
import 'register-screen.dart';

class RegisterDesktopPage extends StatefulWidget {
  const RegisterDesktopPage({super.key});

  @override
  State<RegisterDesktopPage> createState() => _RegisterDesktopPageState();
}

class _RegisterDesktopPageState extends State<RegisterDesktopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              const Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.all(SizeManager.extralarge * 3),
                    child: RegisterPage(),
                  )),
              if (!Responsive.isMobile(context))
                const Expanded(
                    flex: 7,
                    child: OnBoardingPageDesktop(
                      isLogin: false,
                    )),
            ],
          )),
    );
  }
}
