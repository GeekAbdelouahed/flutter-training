import 'package:flutter/material.dart';

class App5 extends StatefulWidget {
  @override
  _App5State createState() => _App5State();
}

class _App5State extends State<App5> {
  int _i = 1;

  @override
  void initState() {
    super.initState();

    print('initState');
  }

  @override
  Widget build(BuildContext context) {
    print('build $_i');
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('index is $_i'),
            RaisedButton(
              onPressed: () {
                setState(() {
                  _i++;
                });
              },
              child: Text('click'),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose');
  }
}
