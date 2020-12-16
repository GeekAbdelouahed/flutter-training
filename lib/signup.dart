import 'dart:ui';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Future<Map<String, dynamic>> _getData() async {
    String url = "https://www.themealdb.com/api/json/v1/1/random.php";
    http.Response response = await http.get(url);
    Map<String, dynamic> data = json.decode(response.body);

    return data['meals'][0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          Center(
            child: FutureBuilder(
              future: _getData(),
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  return Center(
                    child: Text('Network Failed!'),
                  );
                if (snapshot.hasData)
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        snapshot.data['strMealThumb'],
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        snapshot.data['strMeal'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        snapshot.data['strInstructions'],
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  );
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
