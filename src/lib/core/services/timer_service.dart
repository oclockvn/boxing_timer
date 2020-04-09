import "dart:async";

import 'package:flutter/material.dart';

class TimerService extends ChangeNotifier {
  static const Duration _period = Duration(seconds: 1);

  Stopwatch _watch;
  Timer _timer;
  Duration total = Duration.zero;
  Duration _currentDuration = Duration.zero;
  double _percentage = 0;

  // Duration get currentDuration => _currentDuration;
  Duration get countdownDuration => total == Duration.zero ? Duration.zero : total - _currentDuration;
  double get percentage => _percentage;
  bool get isRunning => _timer != null;

  VoidCallback onFinish;

  TimerService({@required this.total, @required this.onFinish}) {
    _watch = Stopwatch();
  }

  void _onTick(Timer timer) {
    print('tick ${timer.tick}, elapsed ${_watch.elapsed.inSeconds} / ${total.inSeconds}');
    _percentage = _watch.elapsed.inSeconds / total.inSeconds;
    _currentDuration = _watch.elapsed - _period;
    notifyListeners();

    if (_watch.elapsed >= total) {
      stop();

      // emit finish event to UI
      Timer(_period, onFinish);
    }
  }

  void start() {
    if (_timer != null) {
      return;
    }

    _timer = Timer.periodic(_period, _onTick);
    _watch.start();

    // notifyListeners();
  }

  void stop() {
    _timer?.cancel();
    _timer = null;

    _watch.stop();
    _currentDuration = _watch.elapsed;

    _percentage = _watch.elapsed.inSeconds / total.inSeconds;
    print('$_percentage%');

    notifyListeners();
  }
}
