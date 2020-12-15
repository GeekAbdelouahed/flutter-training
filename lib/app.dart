import 'dart:ui';

import 'package:flutter/material.dart';

class AppSecond extends StatefulWidget {
  @override
  _AppSecondState createState() {
    print('createState');
    return _AppSecondState();
  }
}

class _AppSecondState extends State<AppSecond> {
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    print('initState');
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text('second screen'),
        ));
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }
}
