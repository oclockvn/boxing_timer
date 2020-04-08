import 'package:flutter/material.dart';
import 'package:src/app_const.dart';

class TrainingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TrainingState();
}

class _TrainingState extends State<TrainingPage> {
  Widget _appBar() {
    return AppBar(
      title: const Text('Fight'),
      // automaticallyImplyLeading: false,
    );
  }

  Widget _roundWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Round',
          style: TextStyle(fontSize: 32),
        ),
        Text(
          '1/3',
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
          onPressed: () {},
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
          '01:49',
          style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
        ),
        AspectRatio(
          aspectRatio: 1 / 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
                value: 0.9,
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
}
