import 'package:aquae_florentis/domain/models/user.dart';
import 'package:aquae_florentis/presentation/providers/user-provider.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/utilities/snackbar.dart';
import 'package:aquae_florentis/presentation/widgets/button-widget.dart';
import 'package:aquae_florentis/presentation/widgets/dropdown-widget.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:aquae_florentis/presentation/widgets/text-input-field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../providers/pageview-provider.dart';

class SecondSection extends ConsumerStatefulWidget {
  const SecondSection({super.key});

  @override
  ConsumerState<SecondSection> createState() => _SecondSectionState();
}

class _SecondSectionState extends ConsumerState<SecondSection> {
  final TextEditingController firstNameController =
      TextEditingController(text: MockUserData.firstName);
  final TextEditingController lastNameController =
      TextEditingController(text: MockUserData.lastName);
  UserType? currentUserType = MockUserData.userType;
  late PageController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    controller = ref.read(registerPageViewProvider);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
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
                'Enter the following\n details',
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
                    controller: firstNameController,
                    hint: 'first name',
                    prefixIcon: CupertinoIcons.person_solid,
                    textInputType: TextInputType.text,
                    textFieldStyle: TextFieldStyle.normal),
              ),
              mediumSpacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SizeManager.large,
                ),
                child: InputTextField(
                    controller: lastNameController,
                    hint: 'last name',
                    prefixIcon: CupertinoIcons.person_solid,
                    textInputType: TextInputType.text,
                    textFieldStyle: TextFieldStyle.normal),
              ),
              mediumSpacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SizeManager.large,
                ),
                child: DropdownWidget(
                  'Role',
                  items:
                      UserType.values.map((e) => e.name).toList(),
                  prefixIcon: CupertinoIcons.person_alt_circle_fill,
                  value: currentUserType == null
                      ? ""
                      : currentUserType!.name,
                  onChanged: (value) =>
                      setState(() => currentUserType = getUserType(value)),
                ),
              ),
              largeSpacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SizeManager.large,
                ),
                child: Button(
                  key: const Key('first-next-button'),
                  buttonColor: ColorManager.primaryColor,
                  isLoadable: true,
                  label: "next",
                  onTap: checkDetails,
                ),
              ),
              largeSpacer(),
              NavText("back", textColor: ColorManager.primaryColor,
                  onPressed: () {
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
    if (firstNameController.text.trim().isEmpty ||
        lastNameController.text.trim().isEmpty ||
        currentUserType == null) {
      AppSnackbar(context: context)
          .showSnackBar(text: "Fill in all required details above");
      return;
    }
    MockUserData.firstName = firstNameController.text.trim();
    MockUserData.lastName = lastNameController.text.trim();
    MockUserData.userType = currentUserType;
    controller.nextPage(
        duration: const Duration(milliseconds: 800), curve: Curves.ease);
  }

  UserType getUserType(String type) {
    switch (type.toLowerCase().trim()) {
      case 'individual':
        return UserType.Individual;
      default:
        return UserType.NGO;
    }
  }
}
