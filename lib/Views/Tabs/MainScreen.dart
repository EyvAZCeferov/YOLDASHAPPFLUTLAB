import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoldash/Theme/ThemeService.dart';
import 'package:yoldash/Views/Tabs/Home/HomePage.dart';
import 'package:yoldash/Views/Tabs/Logistics/Logistics.dart';
import 'package:yoldash/Views/Tabs/Messages/MessagesIndex.dart';
import 'package:yoldash/Views/Tabs/Profile/ProfilePage.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    MessagesIndex(),
    // Logistics(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            tooltip: 'departure'.tr,
            icon: Icon(
              FontAwesomeIcons.road,
            ),
            label: 'departure'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.message),
            label: 'chat'.tr,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(FeatherIcons.package),
          //   label: 'logistic'.tr,
          // ),
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.user),
            label: 'profile'.tr,
          ),
        ],
        backgroundColor: whitecolor,
        elevation: 10,
        iconSize: subHeadingSize,
        fixedColor: iconcolor,
        selectedIconTheme: IconThemeData(
          color: primarycolor,
          opacity: 1,
        ),
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        unselectedIconTheme: IconThemeData(color: iconcolor, opacity: 1),
        selectedLabelStyle: TextStyle(
            color: primarycolor,
            backgroundColor: Colors.transparent,
            decoration: TextDecoration.none,
            decorationColor: primarycolor,
            decorationStyle: TextDecorationStyle.solid,
            decorationThickness: 0,
            fontSize: icontextSize,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            letterSpacing: 1,
            overflow: TextOverflow.ellipsis,
            wordSpacing: 5,
            textBaseline: TextBaseline.alphabetic,
            height: 1.5),
        unselectedLabelStyle: TextStyle(
            color: secondarycolor,
            backgroundColor: Colors.transparent,
            decoration: TextDecoration.none,
            decorationColor: primarycolor,
            decorationStyle: TextDecorationStyle.solid,
            decorationThickness: 0,
            fontSize: icontextSize,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            letterSpacing: 1,
            overflow: TextOverflow.ellipsis,
            wordSpacing: 1,
            textBaseline: TextBaseline.alphabetic,
            height: 1.5),
      ),
    );
  }
}
