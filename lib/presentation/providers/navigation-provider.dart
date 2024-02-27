// ignore_for_file: non_constant_identifier_names

import 'package:aquae_florentis/domain/models/navigation-model.dart';
import 'package:aquae_florentis/presentation/screens/work-screen/work-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/community-screen/community-page.dart';
import '../screens/home-screen/home-page.dart';

final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
const navigationItems = <NavigationItemModel>[
  NavigationItemModel(icon: "home", label: "Home", page: HomePage()),
  NavigationItemModel(icon: "group", label: "Community", page: CommunityPage()),
  NavigationItemModel(icon: "work", label: "Work", page: WorkPage()),
  NavigationItemModel(icon: "note", label: "Education", page: SizedBox()),
  NavigationItemModel(icon: "more", label: "Others", page: SizedBox()),
];

final navigationProvider = StateProvider<int>((ref) => 0);
