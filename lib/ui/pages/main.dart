import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hello/ui/pages/favorite.dart';
import 'package:hello/ui/pages/home.dart';
import 'package:hello/ui/pages/profile.dart';
import 'package:hello/ui/pages/search.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          HomeScreen(),
          SearchPage(),
          FavoritPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(color: Colors.red),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home'.toUpperCase(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'search'.toUpperCase(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'favorite'.toUpperCase(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'profile'.toUpperCase(),
          ),
        ],
      ),
    );
  }
}
