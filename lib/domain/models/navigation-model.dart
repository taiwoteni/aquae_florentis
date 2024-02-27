import 'package:flutter/material.dart';
class NavigationItemModel{
  final String icon;
  final String label;
  final Widget page;
  const NavigationItemModel({required this.icon, required this.label, required this.page});
}