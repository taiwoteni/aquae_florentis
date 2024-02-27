import 'package:aquae_florentis/presentation/providers/community-provider.dart';
import 'package:aquae_florentis/presentation/providers/pageview-provider.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/font-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/widgets/button-widget.dart';
import 'package:aquae_florentis/presentation/widgets/header-text.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:aquae_florentis/presentation/widgets/text-input-field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecondSection extends ConsumerStatefulWidget {
  const SecondSection({super.key});

  @override
  ConsumerState<SecondSection> createState() => _SecondSectionState();
}

class _SecondSectionState extends ConsumerState<SecondSection> {
  final Key key = const Key("next-button");
  final cityController = TextEditingController(text: MockCommunityData.city);
  final stateController = TextEditingController(text: MockCommunityData.state);
  final countryController =
      TextEditingController(text: MockCommunityData.country);

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(createCommunityPageViewProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const HeaderText(
              "Enter Community Location..",
              headerTextStyle: HeaderTextStyle.subheader,
              fontSize: FontSizeManager.medium * 1.1,
            ),
            extraLargeSpacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: SizeManager.large * 0.8),
              child: InputTextField(
                  controller: cityController,
                  hint: "city",
                  prefixIcon: CupertinoIcons.building_2_fill,
                  textInputType: TextInputType.streetAddress,
                  textFieldStyle: TextFieldStyle.normal),
            ),
            mediumSpacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: SizeManager.large * 0.8),
              child: InputTextField(
                  controller: stateController,
                  hint: "state",
                  prefixIcon: CupertinoIcons.location_solid,
                  textInputType: TextInputType.streetAddress,
                  textFieldStyle: TextFieldStyle.normal),
            ),
            mediumSpacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: SizeManager.large * 0.8),
              child: InputTextField(
                  controller: countryController,
                  hint: "country",
                  prefixIcon: CupertinoIcons.flag_fill,
                  textInputType: TextInputType.streetAddress,
                  textFieldStyle: TextFieldStyle.normal),
            ),
            if (MockCommunityData.country != null) mediumSpacer(),
            if (MockCommunityData.country != null)
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
                  key: key,
                  buttonColor: ColorManager.primaryColor,
                  isLoadable: true,
                  label: "Next",
                  onTap: () => controller.nextPage(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.ease)),
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
    );
  }
}
