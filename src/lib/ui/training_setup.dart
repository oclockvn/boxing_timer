import 'package:flutter/material.dart';
import 'package:src/app_const.dart';
import 'package:src/ui/about.dart';

class TrainingSetupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TrainingSetupState();
}

class _TrainingSetupState extends State<TrainingSetupPage> {
  static const double _iconWidth = 50;
  static const double _itemPadding = 16;

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

  Widget _buildHeaderText(String text) {
    return Text(
      text,
      style: TextStyle(color: Color(COLORS.textWhite), fontSize: 20),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.only(top: 8, left: 8, right: 8),
      child: Material(
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
        elevation: 8,
        color: Color(COLORS.mainColor),
        child: ListTile(
          leading: _buildHeaderText('TRAINING LENGTH'),
          trailing: _buildHeaderText('11:00'),
        ),
      ),
    );
  }

  Widget _buildLeadingIcon(IconData icon) {
    return Padding(
      padding: EdgeInsets.only(right: 16),
      child: Icon(
        icon,
        size: 64,
        color: Color(COLORS.redColor),
      ),
    );
  }

  Widget _buildTitle(String title, String sub) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Color(COLORS.redColor)),
          ),
          Text(sub),
        ],
      ),
    );
  }

  Widget _buildSeparator() {
    return Container(
      child: SizedBox.shrink(),
      margin: EdgeInsets.symmetric(horizontal: _itemPadding),
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26, style: BorderStyle.solid, width: 1))),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildLeadingIcon(Icons.timelapse),
                _buildTitle('03:00', 'ROUND LENGTH'),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.remove_circle_outline,
                      ),
                      iconSize: _iconWidth,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add_circle_outline,
                      ),
                      iconSize: _iconWidth,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildSeparator(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: _itemPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildLeadingIcon(Icons.hourglass_empty),
                _buildTitle('01:00', 'REST TIME'),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.remove_circle_outline,
                      ),
                      iconSize: _iconWidth,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add_circle_outline,
                      ),
                      iconSize: _iconWidth,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildSeparator(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: _itemPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildLeadingIcon(Icons.alarm),
                _buildTitle('3', 'ROUNDs'),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.remove_circle_outline,
                      ),
                      iconSize: _iconWidth,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add_circle_outline,
                      ),
                      iconSize: _iconWidth,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        onPressed: () {
          print('start');
        },
        icon: Icon(
          Icons.play_circle_filled,
        ),
        padding: EdgeInsets.symmetric(vertical: 8),
        color: Color(COLORS.mainColor),
        iconSize: 90,
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
          _buildHeader(),
          Expanded(
            child: _buildContent(),
          ),
          _buildStartButton(),
        ],
      ),
    );
  }
}
