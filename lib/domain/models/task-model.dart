import 'package:aquae_florentis/domain/models/community-model.dart';
import 'package:flutter/material.dart';

class Task{
  final Map<dynamic,dynamic> _json;
  const Task({required final Map<dynamic,dynamic> json}):_json=json;

  TaskType get taskType => TaskTypeConverter.convertToType(taskType: _json["task type"]);
  Color get taskColor => TaskTypeConverter.convertToColor(taskType: taskType);

  String get formattedAddress => _json["formatted address"];
  String get image => _json["image"];
  double get long => _json["longitude"];
  double get lat => _json["latitude"];
  double get review => _json["review"];
  DateTime get time => _json["time"];
  String get locationImageUrl => _json["location image"];
  String get id => _json["id"];
  String get posterId => _json["poster id"];
  String get remark => _json["remark"];
  String? get acceptedCommunityId => _json["accepted community id"];

  Future<void> accept({required final Community community})async{

  }
  Future<void> unAccept({required final Community community})async{

  }
  Future<void> remove()async{

  }

  Future<void> complete({required final String image})async{

  }







}
