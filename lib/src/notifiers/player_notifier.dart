import 'package:flutter/material.dart';

///
/// The new State-Manager for Chewie!
/// Has to be an instance of Singleton to survive
/// over all State-Changes inside chewie
///
class PlayerNotifier extends ChangeNotifier {
  PlayerNotifier._(bool hideStuff) : _hideStuff = hideStuff;

  bool _hideStuff;

  bool get hideStuff => _hideStuff;

  set hideStuff(bool value) {
    _hideStuff = value;
    notifyListeners();
  }

  int _refreshFlag = 0;
  int get refreshFlag => _refreshFlag;
  void refresh() {
    _refreshFlag++;
    notifyListeners();
  }

  // ignore: prefer_constructors_over_static_methods
  static PlayerNotifier init() {
    return PlayerNotifier._(true);
  }
}
