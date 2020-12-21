import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models/article.dart';
import '../../services/network.dart';
import '../components/article.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  AppNetwork _appNetwork = AppNetwork();

  String _query = '';

  Future<List<Article>> _getArticles() async {
    String url = '${AppConstants.HOST}public/articles?title=$_query';
    final Map<String, dynamic> data = await _appNetwork.get(url);
    List listData = data['data']['articles'];

    return listData.map((e) => Article.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              onChanged: (text) {
                setState(() {
                  _query = text;
                });
              },
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Search Article',
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Article>>(
              future: _getArticles(),
              builder: (_, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text('Article not found');
                }

                if (snapshot.hasData) {
                  return ListView.separated(
                    padding: EdgeInsets.all(10),
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) => ArticleWidget(
                      article: snapshot.data[index],
                    ),
                    separatorBuilder: (_, __) => SizedBox(
                      height: 10,
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
