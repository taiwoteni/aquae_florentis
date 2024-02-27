import 'dart:io';
import 'package:aquae_florentis/presentation/utilities/snackbar.dart';
import 'package:path/path.dart' as Path;
import 'package:aquae_florentis/data/firestore.dart';
import 'package:aquae_florentis/app/storage-manager.dart';
import 'package:aquae_florentis/presentation/providers/button-provider.dart';
import 'package:aquae_florentis/presentation/providers/pageview-provider.dart';
import 'package:aquae_florentis/presentation/providers/user-provider.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/widgets/add-profile-widget.dart';
import 'package:aquae_florentis/presentation/widgets/button-widget.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:aquae_florentis/presentation/widgets/text-input-field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstSection extends ConsumerStatefulWidget {
  const FirstSection({super.key});

  @override
  ConsumerState<FirstSection> createState() => _FirstSectionState();
}

class _FirstSectionState extends ConsumerState<FirstSection> {
  final Key key = const Key("next-button");
  final emailController = TextEditingController(text: MockUserData.email);
  final passwordController = TextEditingController(text: MockUserData.password);
  final confirmPasswordController =
      TextEditingController(text: MockUserData.password);
  late PageController controller;

  String? profileUrl = MockUserData.profile;
  @override
  void dispose() {
    confirmPasswordController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    controller = ref.read(registerPageViewProvider);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Register',
                style: GoogleFonts.merriweather(
                    fontSize: FontSizeManager.extralarge,
                    fontWeight: FontWeightManager.extrabold,
                    color: ColorManager.primary),
              ),
              extraLargeSpacer(),
              AddProfileWidget(
                mockProfile: MockUserData.profile,
                onProfileAdded: (profilePath) {
                  if (profilePath != null) {
                    setState(() {
                      profileUrl = profilePath.path;
                    });
                  }
                },
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
                    prefixIcon: CupertinoIcons.padlock_solid,
                    textInputType: TextInputType.visiblePassword,
                    isPassword: true,
                    textFieldStyle: TextFieldStyle.normal),
              ),
              mediumSpacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SizeManager.large,
                ),
                child: InputTextField(
                    controller: confirmPasswordController,
                    hint: 'confirm password',
                    prefixIcon: CupertinoIcons.padlock_solid,
                    textInputType: TextInputType.visiblePassword,
                    isPassword: true,
                    textFieldStyle: TextFieldStyle.normal),
              ),
              largeSpacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SizeManager.large,
                ),
                child: Button(
                    key: key,
                    buttonColor: ColorManager.primaryColor,
                    isLoadable: true,
                    label: "Next",
                    onTap: checkEmail),
              ),
              largeSpacer(),
              NavText("Already have an account?",
                  textColor: ColorManager.primaryColor, onPressed: () {
                Navigator.pop(context);
              })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkEmail() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty ||
        profileUrl == null) {
      AppSnackbar(context: context)
          .showSnackBar(text: "Enter all the above details");
      return;
    }
    if (!checkConfirmPassword()) {
      AppSnackbar(context: context)
          .showSnackBar(text: "Both passwords don't match or not in 8 digits");
      return;
    }
    final bool validated =
        validateEmail(emailController.text.trim()); // ...Validate email
    if (!validated) {
      AppSnackbar(context: context)
          .showSnackBar(text: "Email is wrongly formatted");

      return;
    }
    ButtonProvider.startLoading(buttonKey: key, ref: ref);
    final bool emailExists = await checkIfEmailExists(
        emailController.text.trim()); // ...Check if email already exists
    if (emailExists) {
      AppSnackbar(context: context)
          .showSnackBar(text: "Email is already exists");
      ButtonProvider.stopLoading(buttonKey: key, ref: ref);
      return;
    }

    

    await startUploadingProfile(); // ...start uploading profile photo
  }

  bool checkConfirmPassword() {
    return passwordController.text.length >= 8 &&
        passwordController.text == confirmPasswordController.text;
  }

  bool validateEmail(String email) {
    return EmailValidator.validate(email);
  }

  Future<bool> checkIfEmailExists(String email) async {
    final users = await AppFireStore.allUsers();
    return users.map((user) => user.email).toList().contains(email);
  }

  Future<void> startUploadingProfile() async {
    if (profileUrl != null) {
      if (profileUrl!.startsWith("http")) {
        MockUserData.email = emailController.text.trim();
        MockUserData.password = confirmPasswordController.text.trim();
        moveToNextSection();
        return;
      }
      await AppCloudStorage.uploadFile(
        file: File(profileUrl!),
        reference: AppCloudStorage.profileRef
            .child(emailController.text.trim())
            .child("${Path.basenameWithoutExtension(profileUrl!)}.IMG"),
        onComplete: (url) {
          if (url != null) {
            MockUserData.email = emailController.text.trim();
            MockUserData.password = confirmPasswordController.text.trim();
            MockUserData.profile = url;
            moveToNextSection();
          } else {
            ButtonProvider.stopLoading(buttonKey: key, ref: ref);
            // ....Show error uploading file
          }
        },
      );
    }
  }

  Future<void> moveToNextSection() async {
    ButtonProvider.stopLoading(buttonKey: key, ref: ref);
    controller.nextPage(
        duration: const Duration(milliseconds: 800), curve: Curves.ease);
  }
}
