
import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme(){
  return ThemeData.light().copyWith(
    primaryColor: ColorManager.primaryColor,
    primaryColorDark: ColorManager.primary,
    primaryColorLight: ColorManager.secondary,
    disabledColor: ColorManager.tertiary,
  );
}