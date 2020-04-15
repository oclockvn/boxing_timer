import 'package:flutter/material.dart';
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

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Boxing Timer'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.info),
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
      padding: EdgeInsets.only(right: 16),
      child: Icon(icon, size: 64, color: Color(COLORS.redColor)),
    );
  }

  Widget _roundLengthWidget() {
    return Row(
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
              icon: Icon(Icons.remove_circle_outline),
              iconSize: _iconWidth,
              onPressed: _viewmodel.decRoundTime,
            ),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              iconSize: _iconWidth,
              onPressed: _viewmodel.incRoundTime,
            ),
          ],
        ),
      ],
    );
  }

  Widget _restTimeWidget() {
    return Row(
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
              icon: Icon(Icons.remove_circle_outline),
              iconSize: _iconWidth,
              onPressed: _viewmodel.decRestTime,
            ),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              iconSize: _iconWidth,
              onPressed: _viewmodel.incRestTime,
            ),
          ],
        ),
      ],
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
              icon: Icon(Icons.remove_circle_outline),
              iconSize: _iconWidth,
              onPressed: _viewmodel.decRound,
            ),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
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
      child: SizedBox.shrink(),
      margin: EdgeInsets.symmetric(horizontal: _itemPadding),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black26, style: BorderStyle.solid, width: 1),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      margin: EdgeInsets.all(8),
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
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => TrainingPage(2, Duration(seconds: 5), Duration(seconds: 2))));
          // _viewmodel.startTraining();
        },
        child: Text(
          'Ready',
          style: TextStyle(fontSize: 24, color: Color(COLORS.textWhite)),
        ),
        padding: EdgeInsets.all(24),
        color: Color(COLORS.mainColor),
        // iconSize: SIZES.iconButtonSize,
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
      ),
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
            child: Center(
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('TOTAL', style: TextStyle(fontSize: 16)),
                  Text(
                    '11:00',
                    style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: Color(COLORS.mainColor)),
                  ),
                  Text('minutes', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
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
