import 'package:aquae_florentis/domain/models/community-model.dart';
import 'package:aquae_florentis/presentation/screens/community-screen/activity-section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final communityPageProvider = StateProvider<Widget>((ref) => const ActivitySection());

final communityProvider = StateProvider<Community?>((ref) => null);

class MockCommunityData{
  static String? name,profile,city,state,country,about, key;
  static TaskType? role;
  static Map<String, Color>? theme;

  static void clear(){
    theme= null;
    key = null;
    name = null;
    profile = null;
    city = null;
    state = null;
    country = null;
    about = null;
    role = null;
  }
}

