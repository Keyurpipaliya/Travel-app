
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:travelingapp/Screen/blog.dart';
import 'package:travelingapp/Screen/home.dart';
import 'package:travelingapp/Screen/profile.dart';
import 'package:travelingapp/Screen/viewcategory.dart';
import 'package:travelingapp/constants/theme_google.dart';



class BottomBar extends StatelessWidget {
  BottomBar({super.key});
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          children: const <Widget>[
            HomePage(),
            ViewCategory(),
            BlogsPage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          buttonBackgroundColor: primaryColor,
          color: primaryColor,
          height: 65,
          items: const <Widget>[
            Icon(
              Icons.home_outlined,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.category_outlined,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.chat_outlined,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.person_outline,
              size: 30,
              color: Colors.white,
            )
          ],
          onTap: (index) {
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut);
          },
        ),
      ),
    );
  }
}
