import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerPageViewProvider = StateProvider<PageController>((ref) {
  final PageController controller = PageController();
  return controller;
});

final createCommunityPageViewProvider = StateProvider<PageController>((ref) {
  final PageController controller = PageController();
  return controller;
});
