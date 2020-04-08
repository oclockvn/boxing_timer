import 'dart:math';
import "package:rxdart/rxdart.dart";

class TrainingViewModel {
  final Duration _delta = Duration(seconds: 5);
  final Duration _maxRestTime = Duration(minutes: 3);
  final Duration _minRestTime = Duration(seconds: 10);
  final Duration _maxRoundTime = Duration(minutes: 30);

  final BehaviorSubject<int> _round$ = BehaviorSubject.seeded(3);
  final BehaviorSubject<Duration> _roundTime$ = BehaviorSubject.seeded(Duration(minutes: 3));
  final BehaviorSubject<Duration> _restTime$ = BehaviorSubject.seeded(Duration(minutes: 1));
  final BehaviorSubject<Duration> _trainingLength$ =
      BehaviorSubject.seeded(Duration(minutes: 11)); // 3 rounds / 3min each round + 2 rest

  // public
  Stream<int> get round$ => _round$.stream;
  Stream<Duration> get roundTime$ => _roundTime$.stream;
  Stream<Duration> get restTime$ => _restTime$.stream;
  Stream<Duration> get trainingLength$ => _trainingLength$.stream;

  TrainingViewModel() {
    _round$.listen((_) {
      _updateTrainingLength();
    });

    _roundTime$.listen((_) {
      _updateTrainingLength();
    });

    _restTime$.listen((_) {
      _updateTrainingLength();
    });
  }

  void _updateTrainingLength(/*int round, Duration length, Duration rest*/) {
    var total = Duration();
    var round = _round$.value;
    var length = _roundTime$.value;
    var rest = _restTime$.value;

    for (var i = 0; i < round; i++) {
      total = total + length;
    }

    // rest in middle of 2 rounds
    for (var i = 0; i < round - 1; i++) {
      total = total + rest;
    }

    _trainingLength$.add(total);
  }

  void incRound() {
    _round$.add(min(11, _round$.value + 1));
  }

  void decRound() {
    _round$.add(max(1, _round$.value - 1));
  }

  void incRestTime() {
    _restTime$.add(_validateRestTime(_restTime$.value + _delta));
  }

  void decRestTime() {
    _restTime$.add(_validateRestTime(_restTime$.value - _delta));
  }

  void incRoundTime() {
    _roundTime$.add(_validateRoundTime(_roundTime$.value + _delta));
  }

  void decRoundTime() {
    _roundTime$.add(_validateRoundTime(_roundTime$.value - _delta));
  }

  Duration _validateRestTime(Duration input) {
    if (input < _minRestTime) {
      return _minRestTime;
    }

    if (input > _maxRestTime) {
      return _maxRestTime;
    }

    return input;
  }

  Duration _validateRoundTime(Duration input) {
    if (input < _minRestTime) {
      return _minRestTime;
    }

    if (input > _maxRoundTime) {
      return _maxRoundTime;
    }

    return input;
  }

  void dispose() {
    _restTime$.close();
    _roundTime$.close();
    _round$.close();
    _trainingLength$.close();
  }
}
