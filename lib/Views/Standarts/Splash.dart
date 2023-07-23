import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/ImageClass.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Functions/CacheManager.dart';
import 'package:yoldash/Functions/GetAndPost.dart';
import 'package:yoldash/Functions/helpers.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() async {
    super.initState();
    GetAndPost.fetchData('setting', BuildContext);
    var bearerToken = await getvaluefromsharedprefences('bearertoken');
    if (bearerToken != null && bearerToken.length > 0) {
      Get.toNamed('/mainscreen');
    } else {
      Get.toNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: bodycolor,
        resizeToAvoidBottomInset: true,
        body: Container(
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          children: [
            Devider(),
            Center(
              child: SizedBox(
                width: width - 50,
                height: width / 2,
                child: ImageClass(
                  type: false,
                  boxfit: BoxFit.contain,
                  url: "assets/images/yoldash_bg_white.png",
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StaticText(
                    text: "poweredby".tr,
                    weight: FontWeight.w500,
                    size: normaltextSize,
                    color: secondarycolor),
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
