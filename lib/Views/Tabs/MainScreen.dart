import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants/StaticText.dart';
import '../../Controllers/MessagesController.dart';
import '../../Theme/ThemeService.dart';
import 'Home/HomePage.dart';
import 'Messages/MessagesIndex.dart';
import 'Profile/ProfilePage.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  Function? onTap;
  final MessagesController _controller = Get.put(MessagesController());

  final List<Widget> _pages = [
    HomePage(),
    MessagesIndex(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    _controller.getMessages(context,null);
    return Scaffold(
        body: _pages[currentIndex],
        bottomNavigationBar: Obx(()=>
           BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: [
              buildBottomNavigationBarItem(
                  FontAwesomeIcons.road, 'departure'.tr, 0),
              buildBottomNavigationBarItem(
                  FontAwesomeIcons.message, 'chat'.tr, 1),
              buildBottomNavigationBarItem(FeatherIcons.user, 'profile'.tr, 2),
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
        ));
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(
      IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      tooltip: label,
      icon: Stack(
        children: [
          Icon(icon),
          if (index == 1 && _controller.countunreadmessages>0)
            Positioned(
              left: 0,
              top: -6,
              child: Container(
                padding: EdgeInsets.all(3.5),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: StaticText(
                  text: _controller.countunreadmessages.toString(),
                  color: whitecolor,
                  size: 13,
                  weight: FontWeight.w500,
                  align: TextAlign.right,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
            ),
        ],
      ),
      label: label,
    );
  }
}
