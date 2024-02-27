import 'package:aquae_florentis/data/shared-preferences.dart';
import 'package:aquae_florentis/domain/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _userProvider = StateProvider<User?>((ref) => AppStorage.getUser());
// 
// Thank you God!!!!

class UserProvider{
  static StateProvider<User?> get userProvider =>_userProvider;
  static void saveUserData({required final WidgetRef ref, required final Map<dynamic,dynamic> json}){
    AppStorage.saveUser(user: User.fromJson(json: json));
    ref.watch(_userProvider.notifier).state = AppStorage.getUser();
  }
}
class MockUserData{
  static String? firstName,lastName ,profile;
  static String? email,city,state,country;
  static String? password;
  static UserType? userType;

  static clear(){
    firstName = null;
    lastName = null;
    profile = null;
    email = null;
    city = null;
    state = null;
    country = null;
    password = null;
    userType = null;

  }

}