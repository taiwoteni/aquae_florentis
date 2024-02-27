import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<StateProvider<bool>> _buttonProviders = [];
List<Key> _butttonKeys = [];

final _buttonProvider = StateProvider<bool>((ref) => false);

class ButtonProvider{
  final Key key;
  ButtonProvider({required this.key}){
    checkProvider();
  }
  void checkProvider(){
    if(!_butttonKeys.contains(key)){
      _butttonKeys.add(key);
      _buttonProviders.add(_buttonProvider);
    }
  }

  static void startLoading({required final Key buttonKey, required WidgetRef ref}){
    StateProvider<bool> buttonProvider = _buttonProviders[_butttonKeys.indexOf(buttonKey)];
    ref.watch(buttonProvider.notifier).state = true;
  }
  static void stopLoading({required final Key buttonKey, required WidgetRef ref}){
    StateProvider<bool> buttonProvider = _buttonProviders[_butttonKeys.indexOf(buttonKey)];
    ref.watch(buttonProvider.notifier).state = false;
  }
  static bool loadingValue({required final Key buttonKey, required WidgetRef ref}){
    StateProvider<bool> buttonProvider = _buttonProviders[_butttonKeys.indexOf(buttonKey)];
    return ref.watch(buttonProvider);
  }
  
}