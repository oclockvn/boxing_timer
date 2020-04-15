import 'dart:async';

import 'package:flutter/material.dart';
import 'package:src/core/data/stack.dart';

enum RoundState { Preparing, Training, Relax }

class _Round {
  final RoundState state;
  final Duration duration;

  _Round(this.state, this.duration);
}

class TrainingViewModel extends ChangeNotifier {
  static const Duration _second = const Duration(seconds: 1);
  final VoidCallback onFinish;
  Stopwatch _watch = Stopwatch();
  StackOf<_Round> _jobs = StackOf<_Round>();
  Timer _timer;
  _Round _current;
  int _round = 0;

  Duration get remaining {
    return _current == null ? Duration.zero : Duration(seconds: _current.duration.inSeconds - _watch.elapsed.inSeconds);
  }

  bool get isRunning => _watch.isRunning;
  RoundState get state => _current == null ? null : _current.state;
  int get round => _round;

  TrainingViewModel(int round, Duration training, Duration relax, this.onFinish) {
    for (var i = 0; i < round; i++) {
      _jobs.push(_Round(RoundState.Training, training));

      if (i < round - 1) {
        _jobs.push(_Round(RoundState.Relax, relax));
      }
    }

    // preparing time
    _jobs.push(_Round(RoundState.Preparing, Duration(seconds: 6)));
  }

  void start() {
    if (_current != null) {
      _resume();
    } else {
      next();
    }
  }

  void _resume() {
    _timer = Timer.periodic(_second, _tick);
    _watch.start();
  }

  void next() {
    if (_jobs.isNotEmpty) {
      _current = _jobs.pop();
      if (_current.state == RoundState.Training) {
        _round++;
      }
      _resume();
      _watch.reset();
      // _watch.start();
    } else {
      stop();
      onFinish();
    }
  }

  void stop() {
    _timer?.cancel();
    _timer = null;

    _watch.stop();
    notifyListeners();
  }

  void _tick(_) {
    if (_watch.elapsed > _current.duration + _second) {
      stop();
      next();
    }

    notifyListeners();
  }
}
