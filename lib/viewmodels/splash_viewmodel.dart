import 'package:flutter/material.dart';

class SplashViewModel extends ChangeNotifier {
  double _progress = 0;
  double get progress => _progress;

  Future<void> startLoading(VoidCallback onComplete) async {
    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 25));
      _progress = i / 100;
      notifyListeners();
    }
    await Future.delayed(const Duration(milliseconds: 500));
    onComplete();
  }
}
