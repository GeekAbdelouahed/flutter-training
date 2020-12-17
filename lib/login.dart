import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hello/password_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  GlobalKey<FormState> _formKey = GlobalKey();

  void _checkLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String accessToken = preferences.getString('accessToken');

    bool isLoggedUser = accessToken != null;

    if (isLoggedUser) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => HomeScreen(),
        ),
      );
    }
  }

  void _saveData(http.Response response) async {
    String body = response.body;
    Map<String, dynamic> data = json.decode(body);

    String accessToken = data['data']['accessToken'];
    String refreshToekn = data['data']['refreshToken'];

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('accessToken', accessToken);
    await preferences.setString('refreshToekn', refreshToekn);

    await showDialog(
      context: context,
      child: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Welcome'),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => HomeScreen(),
      ),
    );
  }

  void _login(
    String email,
    String password,
  ) async {
    showDialog(
      context: context,
      child: AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(
              width: 10,
            ),
            Text(
              'Please wait...',
            )
          ],
        ),
      ),
    );

    String url = 'http://192.168.0.167:3000/auth/login';

    final data = {
      'email': email,
      'password': password,
    };

    http.Response response = await http.post(url, body: data);

    Navigator.pop(context);

    if (response.statusCode == 201) {
      _saveData(response);
    } else {
      print('server error');
    }
  }

  void _validInputs() {
    bool isValid = _formKey.currentState.validate();
    if (!isValid) return;

    String password = _passwordController.text;
    String email = _emailController.text;

    _login(email, password);
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _checkLogin();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(20),
            children: [
              Text(
                'Login',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                validator: (text) {
                  if (text.isEmpty)
                    return 'email is empty';
                  else if (text.length < 5)
                    return 'email is too short';
                  else
                    return null;
                },
                controller: _emailController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              PasswordField(
                controller: _passwordController,
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: InkWell(
                  onTap: _validInputs,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 5),
                        ),
                      ],
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff6682EC),
                          Color(0xff64B3FE),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Log in',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w300,
                      fontSize: 12.5,
                    ),
                    text: 'Don\'t have an account?  ',
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
