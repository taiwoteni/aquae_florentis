import 'package:flutter/material.dart';

import '../../domain/models/onboarding-models.dart';

class SizeManager {
  static const double small = 4.0;
  static const double regular = 8.0;
  static const double medium = 16.0;
  static const double large = 20.0;
  static const double extralarge = 32;
}

class IconSizeManager {
  static const double small = 16.0;
  static const double regular = 20.0;
  static const double medium = 30.0;
  static const double large = 50.0;
  static const double extralarge = 65;
}

const double defaultSize = SizeManager.medium;

class ValuesManager {
  static const String APP_NAME = "Aquae Florentis";
  static const List<String> members = ["Teninlanimi Taiwo", "Fahd Adebayo"];
  static const int splashAnimationDuration = 4; // Seconds
  static const double bottomBarHeight = 65.0;
  static const MAP_API_KEY = "AIzaSyCqYrgieAnwjJsnTIdwYSlNQJLbzXbLHSU";
  static const GROUP_SUGG_KEY = "group suggestion";
}
// For the onboarding screen
List<OnboardingModel> onboardingModels = [
  const OnboardingModel(
    id: "protect-animals",
    lottie: "fishes",
    text: "Help protect Creatures\nliving in the ocean",
    primary: Colors.deepOrange,
    secondary: Colors.orangeAccent,
  ),
  OnboardingModel(
    id: "water-pollution",
    lottie: "water-pollution",
    text: "Help reduce marine pollution\n on earth",
    primary: Colors.purple.shade300,
    secondary: Colors.purpleAccent,
  ),
  OnboardingModel(
    id: "pure-ocean",
    lottie: "pure-ocean",
    text: "Help make the ocean\nmore conducive and pure on earth",
    primary: Colors.blue.shade700,
    secondary: Colors.blueAccent,
  ),
];
