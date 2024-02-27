import 'package:flutter/material.dart';

class OnboardingModel{
  final Color primary;
  final Color secondary;
  final String lottie;
  final String text;
  final String id;
  const OnboardingModel({required this.id, required this.lottie, required this.text, required this.primary, required this.secondary});
}