import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:instagram/utils/colors.dart';

import '../utils/global_variables.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void onTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onChangedPage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CupertinoTabBar(
          onTap: onTapped,
          currentIndex: _page,
          backgroundColor: mobileBackgroundColor,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_filled,
                  color: _page == 0 ? primaryColor : secondaryColor,
                ),
                label: '',
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: _page == 1 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.plus_circle,
                  color: _page == 2 ? primaryColor : secondaryColor,
                ),
                label: '',
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  color: _page == 3 ? primaryColor : secondaryColor,
                ),
                label: '',
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.person,
                color: _page == 4 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
          ],
        ),
        body: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: onChangedPage,
            children: homeScreenItems));
  }
}
