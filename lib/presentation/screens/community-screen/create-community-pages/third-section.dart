import 'dart:io';
import 'package:aquae_florentis/data/firestore.dart';
import 'package:aquae_florentis/domain/models/community-model.dart';
import 'package:aquae_florentis/domain/models/user.dart';
import 'package:aquae_florentis/presentation/providers/user-provider.dart';
import 'package:aquae_florentis/presentation/screens/community-screen/community-screen.dart';
import 'package:aquae_florentis/presentation/utilities/snackbar.dart';
import 'package:path/path.dart' as Path;
import 'package:aquae_florentis/app/storage-manager.dart';
import 'package:aquae_florentis/presentation/providers/button-provider.dart';
import 'package:aquae_florentis/presentation/providers/community-provider.dart';
import 'package:aquae_florentis/presentation/providers/pageview-provider.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/widgets/button-widget.dart';
import 'package:aquae_florentis/presentation/widgets/header-text.dart';
import 'package:aquae_florentis/presentation/widgets/color-pallete.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../resources/font-manager.dart';

class ThirdSection extends ConsumerStatefulWidget {
  const ThirdSection({super.key});

  @override
  ConsumerState<ThirdSection> createState() => _ThirdSectionState();
}

class _ThirdSectionState extends ConsumerState<ThirdSection> {
  final Key key = const Key("next-button");
  var selectedColor = MockCommunityData.theme ?? ColorManager.colorSet[0];

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
              "Pick community theme..",
              headerTextStyle: HeaderTextStyle.subheader,
              fontSize: FontSizeManager.medium * 1.1,
            ),
            extraLargeSpacer(),
            SizedBox(
                height: 300,
                child: ColorPallete(
                  selectedIndex: ColorManager.colorSet.indexOf(selectedColor),
                  onSelect: (clickedColor) {
                    setState(() {
                      selectedColor = clickedColor;
                    });
                  },
                )),
            largeSpacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SizeManager.large,
              ),
              child: Button(
                  key: key,
                  buttonColor: ColorManager.primaryColor,
                  isLoadable: true,
                  label: "Create",
                  onTap: uploadImage),
            ),
            largeSpacer(),
            NavText("back", textColor: ColorManager.primaryColor,
                onPressed: () {
              if (ButtonProvider.loadingValue(buttonKey: key, ref: ref)) {
                return;
              }
              controller.previousPage(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.ease);
            })
          ],
        ),
      ),
    );
  }

  Future<void> uploadImage() async {
    MockCommunityData.theme = selectedColor;
    ButtonProvider.startLoading(buttonKey: key, ref: ref);
    MockCommunityData.key = FirebaseDatabase.instance.ref().push().key;
    await AppCloudStorage.uploadFile(
      file: File(MockCommunityData.profile!),
      reference: FirebaseStorage.instance
          .ref()
          .child("communities")
          .child("profiles")
          .child(MockCommunityData.key!)
          .child(
              "${Path.basenameWithoutExtension(MockCommunityData.profile!)}.IMG"),
      onComplete: (url) {
        if (url == null) {
          AppSnackbar(context: context).showSnackBar(
              text:
                  "Problem occurred when publishing community. Check Connectivity");
          ButtonProvider.stopLoading(buttonKey: key, ref: ref);
          return;
        }
        MockCommunityData.profile = url;
        createCommunity();
      },
    );
  }

  Future<void> createCommunity() async {
    final String founderId = ref.read(UserProvider.userProvider)!.id;
    final DateTime currentDate = DateTime.now();
    final Map<dynamic, dynamic> communityJson = {
      "id": MockCommunityData.key!,
      "name": MockCommunityData.name,
      "city": MockCommunityData.city,
      "state": MockCommunityData.state,
      "country": MockCommunityData.country,
      "profile": MockCommunityData.profile,
      "date created": currentDate.toIso8601String(),
      "rating":1.5,
      "rated count":1,
      "role":
          TaskTypeConverter.convertToString(taskType: MockCommunityData.role!),
      "founder id": founderId,
      "about": MockCommunityData.about,
      "primary color":
          ColorManager.colorToHex(MockCommunityData.theme!["primary"]!),
      "accent color":
          ColorManager.colorToHex(MockCommunityData.theme!["accent"]!),
    };
    final community = Community.fromJson(json: communityJson);
    final userJson = ref.read(UserProvider.userProvider)!.toJson();
    userJson["community id"] = MockCommunityData.key;
    final user = User.fromJson(json: userJson);

    // To update a user as one that belongs to a community.
    await AppFireStore.addUser(user: user).onError((error, stackTrace) {
      AppSnackbar(context: context).showSnackBar(
          text:
              "Problem occurred when publishing community. Check Connectivity");
      ButtonProvider.stopLoading(buttonKey: key, ref: ref);
    });

    // TO create the community
    await AppFireStore.addCommunity(community: community)
        .onError((error, stackTrace) {
      AppSnackbar(context: context).showSnackBar(
          text:
              "Problem occurred when publishing community. Check Connectivity");
      ButtonProvider.stopLoading(buttonKey: key, ref: ref);
    });

    // TO add the user as a member of that already-existing community

    await AppFireStore.addMember(community: community, user: user)
        .whenComplete(() {
          ref.read(UserProvider.userProvider.notifier).state = user;
          ref.read(communityProvider.notifier).state = community;

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CommunityScreen(community: community),
          ));
    });
  }
}
