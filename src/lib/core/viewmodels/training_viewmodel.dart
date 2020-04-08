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

  // public
  Stream<int> get round$ => _round$.stream;
  Stream<Duration> get roundTime$ => _roundTime$.stream;
  Stream<Duration> get restTime$ => _restTime$.stream;

  TrainingViewModel() {}

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
}
