// ignore_for_file: constant_identifier_names

import 'package:aquae_florentis/data/firestore.dart';
import 'package:aquae_florentis/domain/models/rating.dart';
import 'package:flutter/material.dart';
import 'user.dart';

enum TaskType {
  Pollution,
  HumanExploitation,
  HabitatDestruction,
  DiseaseOutbreak
}

class Community {
  final Map<dynamic, dynamic> _json;
  const Community.fromJson({required final Map<dynamic, dynamic> json})
      : _json = json;

  // Getters
  String get id => _json["id"];
  String get profile => _json["profile"] ?? "";
  String get name => _json["name"] ?? "";
  String get city => _json["city"] ?? "";
  String get country => _json["country"] ?? "";
  String get state => _json["state"] ?? "";
  String get accountNo => _json["account no"] ?? "";
  bool get verified => _json["verified"] ?? false;
  double get rating => _json["rating"] ?? 1.5;
  String get founderId => _json["founder id"] ?? "";
  String get about => _json["about"] ?? "";
  int get _ratedCount => _json["rated count"];

  String get addressFormat {
    return "$city, $state, $country";
  }

  // This is customarily assigned during querying from firestore database
  int get communitySize => _json["community size"] ?? 0;

  Color get primaryColor {
    // Say the color would be in hex string i.e (#------)
    final String hexValue =
        _json["primary color"].toString().replaceAll("#", "");

    // Parse the hex string into individual color components
    int value = int.parse(hexValue, radix: 16);

    // Create and return the Color object
    return Color(value);
  }

  Color get accentColor {
    // Say the color would be in hex string i.e (#------)
    final String hexValue =
        _json["accent color"].toString().replaceAll("#", "");

    // Parse the hex string into individual color components
    int value = int.parse(hexValue, radix: 16);

    // Create and return the Color object
    return Color(value);
  }

  TaskType get role =>
      TaskTypeConverter.convertToType(taskType: _json["role"] ?? "");
  DateTime get dateCreated => DateTime.parse(_json["date created"] ?? "");

  Map<dynamic, dynamic> toJson() {
    return _json;
  }

  Future<double> rate({required double rating, required User user}) async {
    double total = this.rating * _ratedCount;
    // First we have to know if user has rated before.
    bool rated = await hasBeenRatedBy(user: user);
    if (rated) {
      final double oldRating = (await getUserRating(user: user))!.rating;
      total -= oldRating;
      // subtract that old rating from the ratings
    }
    final newRating = (total + rating) / (_ratedCount);
    int newRatedCount = _ratedCount;
    if (!rated) {
      newRatedCount++;
    }
    await AppFireStore.addRating(
        community: this,
        rating: Rating(id: user.id, rating: rating),
        newRating: newRating,
        newRatedCount: newRatedCount);
    return newRating;
  }

  Future<Rating?> getUserRating({required User user}) async {
    final ratings = await getRatingsList();
    Rating? userRating;

    for (final Rating rating in ratings) {
      if (rating.id == user.id) {
        userRating = rating;
      }
    }
    return userRating;
  }

  Future<bool> hasBeenRatedBy({required User user}) async {
    final ratings = await getRatingsList();
    bool _hasRated = false;

    for (final Rating rating in ratings) {
      if (rating.id == user.id) {
        _hasRated = true;
      }
    }

    return _hasRated;
  }

  Future<List<Rating>> getRatingsList() async {
    final ratings = await AppFireStore.allRatings(community: this);
    return ratings;
  }

  Future<User> getFounder() async {
    // Members have the tendency to leave..
    final allMembers = await AppFireStore.allMembers(community: this);
    return allMembers.singleWhere((member) => member.id == founderId);
  }

  Future<void> addMember({required final User user}) async {
    await AppFireStore.addMember(community: this, user: user);
  }
}

class TaskTypeConverter {
  static String convertToString({required TaskType taskType}) {
    switch (taskType) {
      case TaskType.Pollution:
        return "Pollution";
      case TaskType.HumanExploitation:
        return "Human Exploitation";
      case TaskType.HabitatDestruction:
        return "Habitat Destruction";
      default:
        return "Disease Outbreaks";
    }
  }

  static String convertToSVGIcon({required TaskType taskType}) {
    switch (taskType) {
      case TaskType.Pollution:
        return "pollution";
      case TaskType.HumanExploitation:
        return "human-exploitation";
      case TaskType.HabitatDestruction:
        return "habitat-destruction";
      default:
        return "disease-outbreak";
    }
  }

  static TaskType convertToType({required String taskType}) {
    switch (taskType.toLowerCase().trim()) {
      case "pollution":
        return TaskType.Pollution;
      case "water pollution":
        return TaskType.Pollution;
      case "human exploitation":
        return TaskType.HumanExploitation;
      case "habitat destruction":
        return TaskType.HabitatDestruction;
      default:
        return TaskType.DiseaseOutbreak;
    }
  }

  static Color convertToColor({required TaskType taskType}) {
    switch (taskType) {
      case TaskType.Pollution:
        return Colors.blue;
      case TaskType.HabitatDestruction:
        return Colors.orange;
      case TaskType.HumanExploitation:
        return Colors.green;
      default:
        return Colors.red;
    }
  }
}
