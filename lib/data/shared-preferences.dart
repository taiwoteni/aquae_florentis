import 'dart:convert';

import 'package:aquae_florentis/app/strings-manager.dart';
import 'package:aquae_florentis/domain/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static SharedPreferences? _pref;
  static final Future<SharedPreferences> _pref2 =
      SharedPreferences.getInstance();

  static Future<void> initialize() async {
    _pref = await _pref2;
  }
  // Make sure This method is called in the main method in main.dart!!
  // This is to landscape the pref and initialize it before use.

  static Future<void> saveUser({required final User user}) async {
    await _pref!
        .setString(StringManager.USER_STORAGE_KEY, jsonEncode(user.toJson()));
  }
  static Future<void> deleteUser() async {
    await _pref!
        .remove(StringManager.USER_STORAGE_KEY);
  }

  static User? getUser() {
    if(!_pref!.containsKey(StringManager.USER_STORAGE_KEY)){
      return null;
    }
    final jsonString = _pref!.getString(StringManager.USER_STORAGE_KEY)!;
    final user = User.fromJson(json: jsonDecode(jsonString));
    return user;
  }
}
