import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hello/services/network.dart';

import '../../constants.dart';
import '../../models/article.dart';
import '../../models/category.dart';
import '../components/article.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Category _selectedCategory;

  AppNetwork _appNetwork = AppNetwork();

  Future<List<Category>> _getCategories() async {
    String url = '${AppConstants.HOST}public/categories';
    final Map<String, dynamic> data = await _appNetwork.get(url);
    List listData = data['data']['categories'];
    return listData.map((e) => Category.fromJson(e)).toList();
  }

  Future<List<Article>> _getArticles() async {
    String url;
    if (_selectedCategory != null) {
      url =
          '${AppConstants.HOST}public/articles?category=${_selectedCategory.id}';
    } else
      url = '${AppConstants.HOST}public/articles';
    final Map<String, dynamic> data = await _appNetwork.get(url);
    List listData = data['data']['articles'];
    return listData.map((e) => Article.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime dateTime = DateTime.now();

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
                    dateTime.hour > 18 ? 'Good Night!' : 'Good Morning!',
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
              child: FutureBuilder<List<Category>>(
                  future: _getCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text('Server error');
                    }

                    if (snapshot.hasData)
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          Category category = snapshot.data[index];
                          bool isCategorySelected =
                              _selectedCategory?.id == category.id;
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (isCategorySelected)
                                  _selectedCategory = null;
                                else
                                  _selectedCategory = category;
                              });
                            },
                            child: Chip(
                              backgroundColor: isCategorySelected
                                  ? Colors.blue
                                  : Colors.grey.shade300,
                              label: Text(
                                category.name,
                                style: TextStyle(
                                  color: isCategorySelected
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          width: 10,
                        ),
                      );

                    return SizedBox();
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder<List<Article>>(
              future: _getArticles(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
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
                }

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
