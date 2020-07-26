import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Boxing Timer v.1.0'),
              contentPadding: const EdgeInsets.all(0),
            ),
            const ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Quang Phan'),
              subtitle: const Text('oclockvn@gmail.com'),
              contentPadding: const EdgeInsets.all(0),
            ),
            // ListTile(
            //   leading: Icon(Icons.link),
            //   title: Text('https://github.com/oclockvn/boxing_timer'),
            //   contentPadding: EdgeInsets.all(0),
            // )
          ],
        ),
      ),
    );
  }
}
