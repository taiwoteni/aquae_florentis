// ignore_for_file: use_build_context_synchronously, unused_local_variable
import 'package:aquae_florentis/data/auth.dart';
import 'package:aquae_florentis/data/firestore.dart';
import 'package:aquae_florentis/presentation/providers/button-provider.dart';
import 'package:aquae_florentis/presentation/providers/user-provider.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/app/platform.dart';
import 'package:aquae_florentis/app/routes-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/utilities/snackbar.dart';
import 'package:aquae_florentis/presentation/widgets/button-widget.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:aquae_florentis/presentation/widgets/text-input-field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/logo-widget.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Key buttonKey = const Key("login-button");

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
    }

    return Scaffold(
      backgroundColor: ColorManager.background,
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LogoWidget(
                size: 80,
              ),
              largeSpacer(),
              Text(
                'Login',
                style: GoogleFonts.merriweather(
                    fontSize: FontSizeManager.extralarge,
                    fontWeight: FontWeightManager.extrabold,
                    color: ColorManager.primary),
              ),
              extraLargeSpacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SizeManager.large,
                ),
                child: InputTextField(
                    controller: emailController,
                    hint: 'email',
                    prefixIcon: CupertinoIcons.at,
                    textInputType: TextInputType.emailAddress,
                    textFieldStyle: TextFieldStyle.normal),
              ),
              mediumSpacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SizeManager.large,
                ),
                child: InputTextField(
                    controller: passwordController,
                    hint: 'password',
                    prefixIcon: CupertinoIcons.padlock,
                    textInputType: TextInputType.name,
                    isPassword: true,
                    textFieldStyle: TextFieldStyle.normal),
              ),
              largeSpacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SizeManager.large,
                ),
                child: Button(
                  key: buttonKey,
                  isLoadable: true,
                  buttonColor: ColorManager.primaryColor,
                  label: "Login",
                  onTap: login,
                ),
              ),
              largeSpacer(),
              NavText("Don't have an account?",
                  textColor: ColorManager.primaryColor, onPressed: () {
                Navigator.pushNamed(
                    context,
                    AppPlatform.isMobile
                        ? Routes.registerRoute
                        : Routes.registerDesktopRoute);
              })
            ],
          ),
        ),
      ),
    );
  }

  

  Future<void> login() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      AppSnackbar(context: context).showSnackBar(text: "Fill in all Details");
      return;
    }
    ButtonProvider.startLoading(buttonKey: buttonKey, ref: ref);
    final authUser = await AppAuth.signIn(
        email: emailController.text, password: passwordController.text);
    if (authUser == null) {
      ButtonProvider.stopLoading(buttonKey: buttonKey, ref: ref);
      return;
    }
    final users = await AppFireStore.allUsers();
    final currentUser = users.firstWhere((user) => user.id == authUser.uid);
    UserProvider.saveUserData(ref: ref, json: currentUser.toJson());

    ButtonProvider.stopLoading(buttonKey: buttonKey, ref: ref);
    Navigator.pushReplacementNamed(context, Routes.dashboardRoute);
  }
}
