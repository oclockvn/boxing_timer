import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:src/app_const.dart';
import 'package:src/core/viewmodels/training_viewmodel.dart';
import 'package:src/core/extensions/duration_extension.dart';
import 'package:wakelock/wakelock.dart';

class TrainingPage extends StatefulWidget {
  final int round;
  final Duration roundTime;
  final Duration restTime;

  TrainingPage(this.round, this.roundTime, this.restTime);

  @override
  State<StatefulWidget> createState() => _TrainingState();
}

class _TrainingState extends State<TrainingPage> {
  TrainingViewModel _viewmodel;
  static AudioCache _audio = AudioCache();
  static const String _soundPath = "start.mp3";

  @override
  initState() {
    super.initState();

    _audio.disableLog();
    _audio.load(_soundPath); // preload audio

    _viewmodel = TrainingViewModel(widget.round, widget.roundTime, widget.restTime, () {
      _playSound();
      Navigator.of(context).pop();
    }, () {
      _playSound();
    });

    _viewmodel.start();
    Wakelock.enable();
  }

  Widget _appBar() {
    return AppBar(
      title: const Text('Fight'),
      automaticallyImplyLeading: false,
    );
  }

  Widget _roundWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Round ', style: TextStyle(fontSize: 32, color: Color(COLORS.textWhite))),
        Text('${_viewmodel.round}/${widget.round}', style: const TextStyle(fontSize: 32, color: Color(COLORS.textWhite))),
      ],
    );
  }

  Widget _buttonsWidget() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        if (!_viewmodel.isRunning)
          IconButton(
            icon: const Icon(Icons.play_circle_filled, color: Colors.white),
            onPressed: _viewmodel.start,
            iconSize: SIZES.iconButtonSize,
          ),
        if (_viewmodel.isRunning)
          IconButton(
            icon: const Icon(Icons.pause_circle_filled, color: Colors.white),
            onPressed: _viewmodel.stop,
            iconSize: SIZES.iconButtonSize,
          ),
        if (!_viewmodel.isRunning)
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                icon: const Icon(Icons.skip_next, color: Color(COLORS.mainColor)),
                onPressed: _viewmodel.next,
              ),
            ),
          ),
      ],
    );
  }

  Widget _timerWidget() {
    String state;
    switch (_viewmodel.state) {
      case RoundState.Training:
        state = 'Training';
        break;
      case RoundState.Relax:
        state = 'Relaxing';
        break;
      default:
        state = 'Get Ready';
        break;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(state, style: const TextStyle(fontSize: 24, color: Color(COLORS.textWhite))),
        Text(
          _viewmodel.remaining.print(),
          style: const TextStyle(
            fontSize: 86,
            fontWeight: FontWeight.bold,
            color: Color(COLORS.textWhite),
          ),
        ),
        _roundWidget(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: AnimatedBuilder(
        animation: _viewmodel,
        builder: (_context, _widget) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          color: _viewmodel.state == RoundState.Training ? Colors.red : Colors.green,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(child: _timerWidget()),
              _buttonsWidget(),
            ],
          ),
        ),
      ),
    );
  }

  void _playSound() {
    _audio.play(_soundPath, mode: PlayerMode.LOW_LATENCY, volume: 1);
  }

  @override
  void dispose() {
    Wakelock.disable();
    super.dispose();
  }
}
