import 'dart:ui';

import 'package:flutter/material.dart';

import 'app.dart';

class App2 extends StatefulWidget {
  @override
  _App2State createState() {
    print('createState');
    return _App2State();
  }
}

class _App2State extends State<App2> {
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1607893278080-4bfa5188a58a?ixid=MXwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzNHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Image.network(
                'https://images.unsplash.com/photo-1607923432848-62f872d16daf?ixid=MXwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
                height: 100,
                width: 300,
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  hintText: 'input phone number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  hintText: 'password',
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    child: Icon(
                      showPassword ? Icons.lock_open : Icons.lock,
                    ),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AppSecond(),
                    ),
                  );
                },
                child: Text('Sign in'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
