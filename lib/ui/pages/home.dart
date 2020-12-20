import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hello/services/network.dart';

import '../../constants.dart';
import '../../data.dart';
import '../../models/article.dart';
import '../components/article.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Article>> _getData() async {
    String url = '${AppConstants.HOST}public/articles';
    AppNetwork appNetwork = AppNetwork();
    final Map<String, dynamic> data = await appNetwork.get(url);
    List articlesData = data['data']['articles'];
    return articlesData.map((e) => Article.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'Good Morning!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/avatar.jpg',
                      height: 40,
                      width: 40,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Categories',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemCount: Data.getCategories().length,
                itemBuilder: (context, index) {
                  String category = Data.getCategories()[index];
                  return Chip(
                    label: Text(category),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  width: 10,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder<List<Article>>(
              future: _getData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text('unknown error!');
                }
                if (snapshot.hasData)
                  return Column(
                    children: snapshot.data
                        .map((article) => ArticleWidget(
                              article: article,
                            ))
                        .toList(),
                  );
                /*return ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) => ArticleWidget(
                      article: snapshot.data[index],
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                  );*/

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
