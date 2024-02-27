import 'package:aquae_florentis/domain/models/community-model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum WorkPageType { pending, completed }

final workTaskTypeProvider =
    StateProvider<WorkPageType>((ref) => WorkPageType.pending);
class MockWorkData{
  static double? long,lat,review;
  static String? key,remark,formattedAddress;
  static TaskType? taskType;

  static clear(){
    formattedAddress = null;
    long = null;
    lat = null;
    key = null;
    remark = null;
    taskType = null;
    review = null;
  }
}