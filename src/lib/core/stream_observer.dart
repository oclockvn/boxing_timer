import 'package:flutter/material.dart';

class StreamObserver<T> extends StatelessWidget {
  @required
  final Stream<T> stream;

  @required
  final Function onSuccess;

  final Function onWaiting;

  const StreamObserver({Key key, this.stream, this.onSuccess, this.onWaiting}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const defaultWaiting = Center(child: CircularProgressIndicator());

    return StreamBuilder<T>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasError) {
          return Text('Error occurred');
        }

        if (snapshot.hasData) {
          return onSuccess(context, snapshot.data);
        }

        return onWaiting != null ? onWaiting(defaultWaiting) : defaultWaiting;
      },
    );
  }
}
