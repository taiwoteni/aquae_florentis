import 'package:aquae_florentis/domain/models/community-model.dart';
import 'package:aquae_florentis/presentation/providers/button-provider.dart';
import 'package:aquae_florentis/presentation/providers/community-provider.dart';
import 'package:aquae_florentis/presentation/providers/pageview-provider.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/utilities/snackbar.dart';
import 'package:aquae_florentis/presentation/widgets/add-profile-widget.dart';
import 'package:aquae_florentis/presentation/widgets/button-widget.dart';
import 'package:aquae_florentis/presentation/widgets/dropdown-widget.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:aquae_florentis/presentation/widgets/text-input-field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirstSection extends ConsumerStatefulWidget {
  const FirstSection({super.key});

  @override
  ConsumerState<FirstSection> createState() => _FirstSectionState();
}

class _FirstSectionState extends ConsumerState<FirstSection> {
  final Key key = const Key("next-button");
  String profile = MockCommunityData.profile ?? "";
  final nameController = TextEditingController(text: MockCommunityData.name);
  final aboutController = TextEditingController(text: MockCommunityData.about);
  TaskType? role = MockCommunityData.role;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AddProfileWidget(
              mockProfile: MockCommunityData.profile,
              onProfileAdded: (profilePath) {
                if (profilePath != null) {
                  setState((){
                    profile =  profilePath.path;
                  });
                  // .....
                }
              },
            ),
            extraLargeSpacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: SizeManager.large * 0.8),
              child: InputTextField(
                  controller: nameController,
                  hint: "name",
                  prefixIcon: CupertinoIcons.person_3_fill,
                  textInputType: TextInputType.emailAddress,
                  textFieldStyle: TextFieldStyle.normal),
            ),
            mediumSpacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: SizeManager.large * 0.8),
              child: DropdownWidget(
                'Role',
                items: TaskType.values
                    .map((e) => TaskTypeConverter.convertToString(taskType: e))
                    .toList(),
                prefixIcon: CupertinoIcons.person_3,
                value: role == null
                    ? ""
                    : TaskTypeConverter.convertToString(taskType: role!),
                onChanged: (value) => setState(() => role =
                    TaskTypeConverter.convertToType(
                        taskType: value.toString())),
              ),
            ),
            mediumSpacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: SizeManager.large * 0.8),
              child: InputTextField(
                  controller: aboutController,
                  hint: "Write about your community...",
                  maxLines: 6,
                  prefixIcon: CupertinoIcons.doc_append,
                  textInputType: TextInputType.text,
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
                  onTap: checkDetails),
            ),
            
          ],
        ),
      ),
    );
  }

  Future<void> checkDetails()async{
    if(nameController.text.trim().isEmpty || aboutController.text.trim().isEmpty || role == null || profile.trim() == ""){
      AppSnackbar(context: context)
          .showSnackBar(text: "Enter all the above details");
      return;
    }
    MockCommunityData.name = nameController.text.trim();
    MockCommunityData.profile = profile;
    MockCommunityData.role = role;
    MockCommunityData.about = aboutController.text.trim();

    ButtonProvider.startLoading(buttonKey: key, ref: ref);
    await Future.delayed(const Duration(seconds: 5));
    ButtonProvider.stopLoading(buttonKey: key, ref: ref);
    ref.read(createCommunityPageViewProvider).nextPage(duration: const Duration(milliseconds: 800), curve: Curves.ease);
  }
  
}
