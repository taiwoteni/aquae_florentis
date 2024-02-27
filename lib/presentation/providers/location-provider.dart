import 'package:aquae_florentis/domain/models/location-model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

final locationDataProvider = StateProvider<LocationData?>((ref) => null);
final locationProvider = StateProvider<LocationModel?>((ref) => null);
