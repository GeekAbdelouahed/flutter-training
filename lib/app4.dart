import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello/app5.dart';

class App4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (_) => App5(),
              ),
            );
          },
          child: Text('Click me'),
        ),
      ),
    );
  }
}
