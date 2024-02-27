// ignore_for_file: use_build_context_synchronously

import 'package:aquae_florentis/app/routes-manager.dart';
import 'package:aquae_florentis/data/auth.dart';
import 'package:aquae_florentis/data/firestore.dart';
import 'package:aquae_florentis/domain/models/user.dart';
import 'package:aquae_florentis/presentation/providers/button-provider.dart';
import 'package:aquae_florentis/presentation/providers/user-provider.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/utilities/snackbar.dart';
import 'package:aquae_florentis/presentation/widgets/button-widget.dart';
import 'package:aquae_florentis/presentation/widgets/header-text.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:aquae_florentis/presentation/widgets/text-input-field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../providers/pageview-provider.dart';

class ThirdSection extends ConsumerStatefulWidget {
  const ThirdSection({super.key});

  @override
  ConsumerState<ThirdSection> createState() => _SecondSectionState();
}

class _SecondSectionState extends ConsumerState<ThirdSection> {
  final Key buttonKey = const Key("create-button");
  final TextEditingController cityController =
      TextEditingController(text: MockUserData.city);
  final TextEditingController stateController =
      TextEditingController(text: MockUserData.state);
  final TextEditingController countryController =
      TextEditingController(text: MockUserData.country);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = ref.read(registerPageViewProvider);
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
                '...And Finally',
                textAlign: TextAlign.center,
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
                    controller: cityController,
                    hint: 'city',
                    prefixIcon: Icons.location_city_rounded,
                    textInputType: TextInputType.text,
                    textFieldStyle: TextFieldStyle.normal),
              ),
              mediumSpacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SizeManager.large,
                ),
                child: InputTextField(
                    controller: stateController,
                    hint: 'state',
                    prefixIcon: CupertinoIcons.location_solid,
                    textInputType: TextInputType.text,
                    textFieldStyle: TextFieldStyle.normal),
              ),
              mediumSpacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SizeManager.large,
                ),
                child: InputTextField(
                    controller: countryController,
                    hint: 'country',
                    prefixIcon: CupertinoIcons.flag_fill,
                    textInputType: TextInputType.text,
                    textFieldStyle: TextFieldStyle.normal),
              ),
              if (MockUserData.country != null) mediumSpacer(),
              if (MockUserData.country != null)
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: SizeManager.large),
                    child: HeaderText(
                      "* check automatic locations properly",
                      headerTextStyle: HeaderTextStyle.subheader,
                      fontSize: FontSizeManager.small,
                      color: ColorManager.primaryColor,
                    ),
                  ),
                ),
              largeSpacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SizeManager.large,
                ),
                child: Button(
                  key: buttonKey,
                  buttonColor: ColorManager.primaryColor,
                  isLoadable: true,
                  label: "Create",
                  onTap: checkDetails,
                ),
              ),
              largeSpacer(),
              NavText("back", textColor: ColorManager.primaryColor,
                  onPressed: () {
                    if(ButtonProvider.loadingValue(buttonKey: buttonKey, ref: ref)){
                      return;
                    }
                controller.previousPage(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.ease);
              })
            ],
          ),
        ),
      ),
    );
  }

  void checkDetails() {
    if (cityController.text.trim().isEmpty ||
        stateController.text.trim().isEmpty ||
        countryController.text.trim().isEmpty) {
      AppSnackbar(context: context)
          .showSnackBar(text: "Fill in all required details above");
      return;
    }
    MockUserData.city = cityController.text.trim();
    MockUserData.state = stateController.text.trim();
    MockUserData.country = countryController.text.trim();
    addUser();
  }

  Future<void> addUser() async {
    ButtonProvider.startLoading(buttonKey: buttonKey, ref: ref);
    final user = await AppAuth.createUser(
        email: MockUserData.email!.trim(),
        password: MockUserData.password!.trim());
    if (user == null) {
      // ...Logic to show failed auth
      ButtonProvider.stopLoading(buttonKey: buttonKey, ref: ref);
      return;
    }
    final Map<dynamic, dynamic> userJson = {
      "email": MockUserData.email!,
      "id": user.uid,
      "profile": MockUserData.profile,
      "first name": MockUserData.firstName!,
      "last name": MockUserData.lastName!,
      "role": MockUserData.userType!.name,
      "city": MockUserData.city!,
      "state": MockUserData.state!,
      "country": MockUserData.country!,
    };
    await AppFireStore.addUser(user: User.fromJson(json: userJson));
    UserProvider.saveUserData(ref: ref, json: userJson);
    ButtonProvider.stopLoading(buttonKey: buttonKey, ref: ref);
    MockUserData.clear();
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.dashboardRoute, (route) => false);
  }

  UserType getUserType(String type) {
    switch (type.trim()) {
      case 'individual':
        return UserType.Individual;
      default:
        return UserType.NGO;
    }
  }
}
