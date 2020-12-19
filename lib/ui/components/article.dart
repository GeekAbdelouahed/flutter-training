import 'dart:ui';

import 'package:flutter/material.dart';

import '../../models/article.dart';

class ArticleWidget extends StatelessWidget {
  final Article article;

  const ArticleWidget({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/avatar.jpg',
                    width: 40,
                    height: 40,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.author.fullName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        height: .9,
                      ),
                    ),
                    Text(
                      article.author.email,
                    ),
                  ],
                ),
                Spacer(),
                Expanded(
                  child: Text(
                      '${DateTime.parse(article.createdAt).year}/${DateTime.parse(article.createdAt).month}${DateTime.parse(article.createdAt).day}'),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: 1.275,
                child: Image.asset(
                  'https://images.unsplash.com/photo-1608370617870-dc99b1b44a31?ixid=MXwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              article.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
