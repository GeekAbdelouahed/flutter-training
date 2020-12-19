import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String lable;
  final TextInputAction inputAction;

  const PasswordField({
    Key key,
    @required this.controller,
    this.lable = 'Password',
    this.inputAction = TextInputAction.next,
  }) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isShowPassword = true;

  @override
  Widget build(BuildContext context) => TextFormField(
        validator: (text) {
          if (text.length < 5) return 'password is too short';
          return null;
        },
        controller: widget.controller,
        textInputAction: widget.inputAction,
        obscureText: _isShowPassword,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
        ),
        decoration: InputDecoration(
          labelText: widget.lable,
          labelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                _isShowPassword = !_isShowPassword;
              });
            },
            child: Icon(
              _isShowPassword
                  ? Icons.remove_red_eye_sharp
                  : Icons.flip_camera_ios,
              size: 18,
            ),
          ),
        ),
      );
}
