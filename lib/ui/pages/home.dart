import 'dart:ui';
import 'package:hello/services/network.dart';

import '../../data.dart';
import '../components/article.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../models/article.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Article>> _getData() async {
    String url = '${AppConstants.HOST}public/articles';

    AppNetwork appNetwork = AppNetwork();
    final Map<String, dynamic> data = await appNetwork.get(url);
    List artilcesData = data['data']['articles'];

    return artilcesData.map((e) => Article.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          Expanded(
            child: FutureBuilder<List<Article>>(
                future: _getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return Text('Server Error');
                  if (snapshot.hasData)
                    return ListView.separated(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) => ArticleWidget(
                        article: snapshot.data[index],
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                    );

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
