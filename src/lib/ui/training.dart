import 'dart:async';
import 'package:flutter/material.dart';
import 'package:src/app_const.dart';
import 'package:src/core/extensions/duration_extension.dart';

class TrainingPage extends StatefulWidget {
  final int round;
  final Duration roundTime;
  final Duration restTime;

  TrainingPage(this.round, this.roundTime, this.restTime);

  @override
  State<StatefulWidget> createState() => _TrainingState();
}

class _TrainingState extends State<TrainingPage> {
  Timer _timer;
  Timer _roundTimer;
  Timer _restTimer;
  double _learnedPercentage = 0;
  int _currentRound = 0;
  String _activity = "Get Ready";
  Duration _counter;

  @override
  initState() {
    _counter = widget.roundTime;
    super.initState();
    // _startTraining();
    _gettingReady();
  }

  void _gettingReady() {
    _counter = Duration(seconds: 5);
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick > 5) {
        _cancelTimer(timer);
        _startTraining();
      } else {
        setState(() {
          _counter = _counter - Duration(seconds: 1);
        });
      }
    });
  }

  void _startTraining() {
    var total = Duration();
    var round = widget.round;
    var length = widget.roundTime;
    var rest = widget.restTime;

    for (var i = 0; i < round; i++) {
      total = total + length;
    }

    // rest in middle of 2 rounds
    for (var i = 0; i < round - 1; i++) {
      total = total + rest;
    }

    var padding = round + (round - 2); // round + relax
    total = total + Duration(seconds: padding);

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick > total.inSeconds) {
        Navigator.of(context).pop();
      } else {
        setState(() {
          _learnedPercentage = timer.tick / total.inSeconds;
          _counter = _counter - Duration(seconds: 1);
        });
      }
    });

    _nextRound();
  }

  void _cancelTimer(Timer timer) {
    if (timer == null || !timer.isActive) {
      return;
    }

    timer.cancel();
  }

  void _startingRound() {
    setState(() {
      _activity = "Training";
    });

    _counter = widget.roundTime;
    // padding 1 second for next state
    _roundTimer = Timer.periodic(widget.roundTime + Duration(seconds: 1), (timer) {
      _cancelTimer(timer);
      _startingRelax();
    });
  }

  void _startingRelax() {
    setState(() {
      _activity = "Relaxing";
    });

    _counter = widget.restTime;
    // padding 1 second for next state
    _restTimer = Timer.periodic(widget.restTime + Duration(seconds: 1), (timer) {
      _cancelTimer(timer);
      _nextRound();
    });
  }

  void _nextRound() {
    _startingRound();
    setState(() {
      _currentRound++;
    });
  }

  Widget _appBar() {
    return AppBar(
      title: const Text('Fight'),
      automaticallyImplyLeading: false,
    );
  }

  Widget _roundWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          _activity,
          style: TextStyle(fontSize: 32),
        ),
        Text(
          'Round $_currentRound/${widget.round}',
          style: TextStyle(fontSize: 32),
        )
      ],
    );
  }

  Widget _buttonsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.pause_circle_filled),
          onPressed: () {
            _timer.cancel();
          },
          iconSize: SIZES.iconButtonSize,
        ),
        const SizedBox(
          width: 64,
        ),
        IconButton(
          icon: Icon(Icons.play_circle_filled),
          onPressed: () {},
          iconSize: SIZES.iconButtonSize,
        ),
      ],
    );
  }

  Widget _clockWidget(context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Text(
          _counter.print(),
          style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
        ),
        AspectRatio(
          aspectRatio: 1 / 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
                value: _learnedPercentage,
                strokeWidth: 16,
                backgroundColor: Color(COLORS.textWhite),
                valueColor: AlwaysStoppedAnimation<Color>(Color(COLORS.mainColor))),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _roundWidget(),
            Expanded(
              child: _clockWidget(context),
            ),
            _buttonsWidget(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cancelTimer(_timer);
    _cancelTimer(_roundTimer);
    _cancelTimer(_restTimer);
    super.dispose();
  }
}
