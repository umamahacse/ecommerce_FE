import 'dart:async';

import 'package:flutter/material.dart';

class TimerProvider with ChangeNotifier {
  int _secondsRemaining = 0;
  Timer? _timer;

  int get secondsRemaining => _secondsRemaining;

  void startTimer(int initialDuration) {
    _secondsRemaining = initialDuration;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        notifyListeners();
      } else {
        _timer?.cancel();
        notifyListeners();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    notifyListeners();
  }
}