import 'dart:developer';
import 'package:aquae_florentis/data/location.dart';
import 'package:aquae_florentis/presentation/providers/pageview-provider.dart';
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/screens/register-screen/second-section.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../providers/location-provider.dart';
import '../../providers/user-provider.dart';
import 'first-section.dart';
import 'third-section.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final List<Widget> pages = [
    const FirstSection(),
    const SecondSection(),
    const ThirdSection()
  ];
  @override
  void initState() {
    super.initState();
    preloadCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: ref.read(registerPageViewProvider),
          children: pages,
        ),
      ),
    );
  }

  Future<void> preloadCurrentLocation() async {
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
          MockUserData.city = locationModel.city();
          MockUserData.state = locationModel.state();
          MockUserData.country = locationModel.country();
          // log(response.body);
        }
      });
    } on Exception catch (e) {
      print(e);
    }
  }
}
