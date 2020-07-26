import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import "package:rxdart/rxdart.dart";

import 'package:src/app_const.dart';
import 'package:src/core/stream_observer.dart';
import 'package:src/core/viewmodels/setup_viewmodel.dart';
import 'package:src/core/extensions/duration_extension.dart';
import 'package:src/ui/about.dart';
import 'package:src/ui/training.dart';

class SetupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SetupState();
}

class _SetupState extends State<SetupPage> {
  static const double _iconWidth = 50;
  static const double _itemPadding = 16;
  final _viewmodel = SetupViewModel();
  Duration _picker = Duration.zero;

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Boxing Timer'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.info),
          onPressed: () {
            print('info');
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => AboutPage()));
          },
        )
      ],
    );
  }

  Widget _buildLeadingIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Icon(icon, size: 64, color: Color(COLORS.redColor)),
    );
  }

  Widget _showTimerPickerPopup(Duration initialDuration) {
    return AlertDialog(
      actions: <Widget>[
        FlatButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop(_picker);
          },
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.ms,
            onTimerDurationChanged: (Duration d) {
              if (d.inSeconds >= 10) {
                _picker = d;
              }
            },
            minuteInterval: 1,
            secondInterval: 1,
            initialTimerDuration: initialDuration,
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }

  Widget _roundLengthWidget() {
    return GestureDetector(
      onTap: () async {
        _viewmodel.roundTime$.take(1).listen((Duration roundTime) {
          showDialog(
            context: context,
            builder: (_) => _showTimerPickerPopup(roundTime),
            barrierDismissible: false,
          ).then((pick) {
            if (pick != null) {
              _viewmodel.setRoundTime(pick);
            }
          });
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildLeadingIcon(Icons.timelapse),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                StreamObserver<Duration>(
                  stream: _viewmodel.roundTime$,
                  onSuccess: (_, Duration data) => Text(
                    data.print(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Color(COLORS.redColor)),
                  ),
                ),
                Text('ROUND LENGTH'),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.remove),
                iconSize: _iconWidth,
                onPressed: _viewmodel.decRoundTime,
              ),
              IconButton(
                icon: const Icon(Icons.add),
                iconSize: _iconWidth,
                onPressed: _viewmodel.incRoundTime,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _restTimeWidget() {
    return GestureDetector(
      onTap: () async {
        _viewmodel.restTime$.take(1).listen((Duration duration) {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (_) => _showTimerPickerPopup(duration),
          ).then((pick) {
            if (pick != null) {
              _viewmodel.setRestTime(pick);
            }
          });
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildLeadingIcon(Icons.hourglass_empty),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                StreamObserver<Duration>(
                  stream: _viewmodel.restTime$,
                  onSuccess: (_, Duration data) => Text(
                    data.print(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Color(COLORS.redColor)),
                  ),
                ),
                Text('REST TIME'),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.remove),
                iconSize: _iconWidth,
                onPressed: _viewmodel.decRestTime,
              ),
              IconButton(
                icon: const Icon(Icons.add),
                iconSize: _iconWidth,
                onPressed: _viewmodel.incRestTime,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _roundWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildLeadingIcon(Icons.alarm),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StreamObserver<int>(
                stream: _viewmodel.round$,
                onSuccess: (_, int data) => Text(
                  data.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Color(COLORS.redColor)),
                ),
              ),
              Text('ROUNDs'),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.remove),
              iconSize: _iconWidth,
              onPressed: _viewmodel.decRound,
            ),
            IconButton(
              icon: const Icon(Icons.add),
              iconSize: _iconWidth,
              onPressed: _viewmodel.incRound,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSeparator() {
    return Container(
      child: const SizedBox.shrink(),
      margin: EdgeInsets.symmetric(horizontal: _itemPadding),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black26, style: BorderStyle.solid, width: 1),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      margin: const EdgeInsets.all(8),
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.black, style: BorderStyle.solid, width: 1),
      // ),
      child: ListView(
        // padding: EdgeInsets.all(8),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: _itemPadding),
            child: _roundLengthWidget(),
          ),
          _buildSeparator(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: _itemPadding),
            child: _restTimeWidget(),
          ),
          _buildSeparator(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: _itemPadding),
            child: _roundWidget(),
          ),
        ],
      ),
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        onPressed: () {
          CombineLatestStream.combine3(
            _viewmodel.round$,
            _viewmodel.roundTime$,
            _viewmodel.restTime$,
            (int round, Duration time, Duration rest) => {"round": round, "time": time, "rest": rest},
          ).take(1).listen((map) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => TrainingPage(
                  map["round"] as int,
                  map["time"] as Duration,
                  map["rest"] as Duration,
                ),
              ),
            );
          });
        },
        child: Text(
          'Ready',
          style: const TextStyle(fontSize: 24, color: Color(COLORS.textWhite)),
        ),
        padding: const EdgeInsets.all(24),
        color: const Color(COLORS.mainColor),
        shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
      ),
    );
  }

  Widget _totalWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('TOTAL', style: TextStyle(fontSize: 16)),
        StreamObserver(
          stream: _viewmodel.trainingLength$,
          onSuccess: (_, Duration length) => Text(
            length.print(),
            style: const TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
              color: Color(COLORS.mainColor),
            ),
          ),
        ),
        const Text('minutes', style: TextStyle(fontSize: 16)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(child: _buildContent()),
          Expanded(
            child: Center(child: _totalWidget()),
          ),
          _buildStartButton(context),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _viewmodel.dispose();
    super.dispose();
  }
}
