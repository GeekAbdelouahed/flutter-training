import 'dart:ui';

import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models/article.dart';
import '../pages/article.dart';

class ArticleWidget extends StatelessWidget {
  final Article article;

  const ArticleWidget({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ArticleScreen(article: article),
          ),
        );
      },
      child: Card(
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
                    child: Image.network(
                      '${AppConstants.HOST}public/users/${article.author.image?.imageName}',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Image.asset(
                        'assets/images/avatar.jpg',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
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
                  child: Image.network(
                    '${AppConstants.HOST}public/articles/${article.cover?.imageName}',
                    errorBuilder: (_, __, ___) =>
                        Image.asset('assets/images/placeholder-image.png'),
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
      ),
    );
  }
}
