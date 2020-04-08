import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Boxing Timer v.1.0'),
              contentPadding: EdgeInsets.all(0),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Quang Phan'),
              subtitle: Text('oclockvn@gmail.com'),
              contentPadding: EdgeInsets.all(0),
            ),
            ListTile(
              leading: Icon(Icons.link),
              title: Text('https://github.com/oclockvn/boxing_timer'),
              contentPadding: EdgeInsets.all(0),
            )
          ],
        ),
      ),
    );
  }
}
