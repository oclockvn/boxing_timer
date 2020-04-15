import 'package:flutter/material.dart';
import 'package:src/app_const.dart';
import 'package:src/core/viewmodels/training_viewmodel.dart';
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
  TrainingViewModel _viewmodel;
  @override
  initState() {
    super.initState();

    _viewmodel = TrainingViewModel(
      widget.round,
      widget.roundTime,
      widget.restTime,
      () {
        Navigator.of(context).pop();
      },
    );

    _viewmodel.start();
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
        Text('Round ', style: TextStyle(fontSize: 32, color: Color(COLORS.textWhite))),
        Text('${_viewmodel.round}/${widget.round}', style: TextStyle(fontSize: 32, color: Color(COLORS.textWhite))),
      ],
    );
  }

  Widget _buttonsWidget() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        if (!_viewmodel.isRunning)
          IconButton(
            icon: Icon(Icons.play_circle_filled, color: Colors.white),
            onPressed: _viewmodel.start,
            iconSize: SIZES.iconButtonSize,
          ),
        if (_viewmodel.isRunning)
          IconButton(
            icon: Icon(Icons.pause_circle_filled, color: Colors.white),
            onPressed: _viewmodel.stop,
            iconSize: SIZES.iconButtonSize,
          ),
        if (!_viewmodel.isRunning)
          Positioned(
            right: SIZES.iconButtonSize + 16,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                icon: Icon(Icons.skip_next, color: Color(COLORS.mainColor)),
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
        Text(state, style: TextStyle(fontSize: 24, color: Color(COLORS.textWhite))),
        Text(
          _viewmodel.remaining.print(),
          style: TextStyle(
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
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
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

  @override
  void dispose() {
    super.dispose();
  }
}
