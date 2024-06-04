import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/providers/user_providers.dart';
import 'package:instagram/utils/colors.dart';
import 'package:provider/provider.dart';
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
    fetchUserData();
  }

  void fetchUserData() async {
    await Provider.of<UserProvider>(context, listen: false).refreshUser();
    setState(() {}); // to rebuild the widget after fetching user data
  }

  void onTapped(int page) {
    setState(() {
      _page = page;
    });
    pageController.jumpToPage(page);
  }

  void onChangedPage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserProvider>(context).getUser;

    if (_userModel == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

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
            backgroundColor: primaryColor,
          ),
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
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: _page == 3 ? Colors.redAccent : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundImage: _userModel.photoURl != null && _userModel.photoURl.isNotEmpty
                  ? NetworkImage(_userModel.photoURl)
                  : const AssetImage('assets/placeholder_image.png') as ImageProvider,
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
        children: homeScreenItems,
      ),
    );
  }
}
