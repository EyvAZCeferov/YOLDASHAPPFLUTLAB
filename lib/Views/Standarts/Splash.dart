import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants/Devider.dart';
import '../../Constants/ImageClass.dart';
import '../../Constants/StaticText.dart';
import '../../Controllers/MainController.dart';
import '../../Functions/helpers.dart';
import '../../Theme/ThemeService.dart';

class Splash extends StatelessWidget {
  final MainController _maincontroller = Get.put(MainController());

  Splash() {
    init();
  }

  Future<void> init() async {
    var token = await _maincontroller.getstoragedat('token');
    await Future.delayed(Duration(seconds: 3));
    if (token != null) {
      if (token.isNotEmpty) {
        Get.offAllNamed('/mainscreen');
      } else {
        Get.offAllNamed('/login');
      }
    } else {
      Get.offAllNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: primarycolor,
        resizeToAvoidBottomInset: true,
        body: Container(
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          children: [
            Devider(),
            Column(
              children: [
                Devider(),
                Center(
                  child: SizedBox(
                    width: width - 20,
                    height: width / 2,
                    child: ImageClass(
                      type: false,
                      boxfit: BoxFit.contain,
                      url: "assets/images/yoldash_bg_green.png",
                    ),
                  ),
                ),
                Center(
                  child: StaticText(
                    color: whitecolor,
                    text: "Made in Azerbaijan",
                    weight: FontWeight.w600,
                    size: buttontextSize,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StaticText(
                    text: "developedby".tr,
                    weight: FontWeight.w500,
                    size: normaltextSize,
                    color: whitecolor),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () => launchUrlTOSITE('https://globalmart.az'),
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: ImageClass(
                      type: false,
                      boxfit: BoxFit.contain,
                      url: "assets/images/globalmartlogo.png",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ))));
  }
}
