// ignore_for_file: constant_identifier_names

import 'package:aquae_florentis/data/firestore.dart';

import 'community-model.dart';

enum UserType { Individual, NGO }

class User {
  final Map<dynamic, dynamic> _json;
  const User.fromJson({required Map<dynamic, dynamic> json}) : _json = json;

  // A user would have communityId to the community he belongs

  String get _communityId => _json["community id"] ?? "";
  String get firstName => _json['first name'] ?? "";
  String get lastName => _json['last name'] ?? "";
  String get city => _json['city'] ?? "";
  String get state => _json['state'] ?? "";
  String get country => _json['country'] ?? "";
  String get profile => _json['profile'] ?? "";
  String get email => _json['email'] ?? "";
  String get id => _json['id'] ?? "";
  UserType get userType {
    switch (_json['role'].toString().trim()) {
      case 'individual':
        return UserType.Individual;
      default:
        return UserType.NGO;
    }
  }

  Map<dynamic, dynamic> toJson() {
    return _json;
  }

  Future<Community?> getCommunity() async {
    if (_communityId == "") {
      return null;
    }
    final allComunities = await AppFireStore.allCommunities();
    final community =
        allComunities.firstWhere((community) => community.id == _communityId);
    return community;
  }
}

class Organization extends User {
  Organization.fromJson({required super.json}) : super.fromJson();
}
