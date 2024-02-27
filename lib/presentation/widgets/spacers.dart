
import 'package:aquae_florentis/presentation/resources/value-manager.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Widget smallSpacer(){
  return const Gap(SizeManager.small);
} 
Widget regularSpacer(){
  return const Gap(SizeManager.regular);
}
Widget mediumSpacer(){
  return const Gap(SizeManager.medium);
}
Widget largeSpacer(){
  return const Gap(SizeManager.large);
}
Widget extraLargeSpacer(){
  return const Gap(SizeManager.extralarge);
}