import 'package:flutter/material.dart';

class TrainingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TrainingState();
}

class _TrainingState extends State<TrainingPage> {
  Widget _buildAppBar() {
    return AppBar(
      title: const Text('Fight'),
      // automaticallyImplyLeading: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        child: Text('Fight'),
      ),
    );
  }
}
