import 'dart:developer';

import 'package:aquae_florentis/data/location.dart';
import 'package:aquae_florentis/presentation/providers/community-provider.dart';
import 'package:aquae_florentis/presentation/providers/pageview-provider.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:aquae_florentis/presentation/screens/community-screen/create-community-pages/first-section.dart';
import 'package:aquae_florentis/presentation/screens/community-screen/create-community-pages/second-section.dart';
import 'package:aquae_florentis/presentation/screens/community-screen/create-community-pages/third-section.dart';
import 'package:aquae_florentis/presentation/utilities/responsive.dart';
import 'package:aquae_florentis/presentation/widgets/page-header.dart';
import 'package:aquae_florentis/presentation/widgets/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/location-provider.dart';

class CreateCommunity extends ConsumerStatefulWidget {
  const CreateCommunity({super.key});

  @override
  ConsumerState<CreateCommunity> createState() => _CreateCommunityState();
}

class _CreateCommunityState extends ConsumerState<CreateCommunity> {
  final pages = [
    const FirstSection(),
    const SecondSection(),
    const ThirdSection()
  ];

  @override
  void initState() {
    super.initState();
    preloadCommunityLocation();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).viewPadding.top,
      ),
      child: Scaffold(
        backgroundColor: ColorManager.background,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).viewPadding.top,
            padding: EdgeInsets.only(
              left: isMobile ? SizeManager.medium : SizeManager.extralarge,
              right: isMobile ? SizeManager.medium : SizeManager.extralarge,
              top: SizeManager.large,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PageHeader(
                  text: "Create Community",
                ),
                extraLargeSpacer(),
                Expanded(
                    child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: ref.watch(createCommunityPageViewProvider),
                  scrollDirection: Axis.horizontal,
                  children: pages,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> preloadCommunityLocation() async {
    final location = await LocationService.askPermission();
    if (location == null) {
      log("location is null");
      return;
    }
    try {
      final locationData = await location.getLocation();
      final locationModel = await LocationService.getLocationModel(
          long: locationData.longitude!, lat: locationData.latitude!);

      WidgetsFlutterBinding.ensureInitialized()
          .addPostFrameCallback((timeStamp) {
        if (mounted) {
          ref.watch(locationProvider.notifier).state = locationModel;
          log(ref.read(locationProvider)!.formmattedAddress);
          MockCommunityData.city = locationModel.city();
          MockCommunityData.state = locationModel.state();
          MockCommunityData.country = locationModel.country();
        }
      });
    } on Exception catch (e) {
      print(e);
    }
  }
}
