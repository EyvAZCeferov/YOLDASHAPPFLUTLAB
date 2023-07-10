import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yoldash/Constants/IconButtonElement.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Controllers/MessagesController.dart';
import 'package:yoldash/Theme/ThemeService.dart';
import 'package:yoldash/Views/Tabs/Messages/MessageBubble.dart';

class MessagesShow extends StatelessWidget {
  final MessagesController _controller = Get.find<MessagesController>();

  final index = int.parse(Get.parameters['index'] ?? '');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bodycolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: whitecolor,
            bottomOpacity: 0,
            brightness: Brightness.light,
            centerTitle: true,
            elevation: 0,
            leadingWidth: 42,
            toolbarHeight: 50,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            toolbarOpacity: 1,
            actions: [
              SizedBox(
                width: 50,
                child: ElevatedButton(
                  onPressed: () => print("Pressed Call"),
                  style: ElevatedButton.styleFrom(
                    primary: primarycolor,
                    onPrimary: whitecolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Icon(FeatherIcons.phoneCall,
                      color: whitecolor, size: normaltextSize),
                ),
              ),
              SizedBox(width: 3),
              SizedBox(
                width: 50,
                child: ElevatedButton(
                  onPressed: () => print("Pressed Video"),
                  style: ElevatedButton.styleFrom(
                    primary: primarycolor,
                    onPrimary: whitecolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Icon(FeatherIcons.video,
                      color: whitecolor, size: normaltextSize),
                ),
              ),
            ],
            leading: Container(
              width: 40,
              height: buttontextSize,
              decoration: BoxDecoration(
                  color: whitecolor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: iconcolor, width: 1, style: BorderStyle.solid)),
              child: IconButtonElement(
                  icon: FeatherIcons.chevronLeft,
                  color: Colors.black,
                  size: buttontextSize,
                  onPressed: () => Get.back()),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: primarycolor,
                  foregroundColor: whitecolor,
                  radius: 20,
                  backgroundImage: NetworkImage(
                      "https://wallpapers.com/images/hd/cool-profile-picture-87h46gcobjl5e4xu.jpg"),
                ),
                SizedBox(width: 5),
                StaticText(
                    align: TextAlign.center,
                    color: darkcolor,
                    size: smalltextSize,
                    text: "Eyvaz Ceferov",
                    weight: FontWeight.w500),
              ],
            )),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _controller.showattachmenu.value == true
                      ? Container(
                          width: 60,
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: whitecolor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: IconButton(
                                  alignment: Alignment.center,
                                  icon: Icon(FeatherIcons.image,
                                      color: iconcolor, size: buttontextSize),
                                  onPressed: () {
                                    _controller.pickImage();
                                  },
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: whitecolor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: IconButton(
                                  alignment: Alignment.center,
                                  icon: Icon(FeatherIcons.mapPin,
                                      color: iconcolor, size: buttontextSize),
                                  onPressed: () {
                                    _controller.showmap(context);
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      : SizedBox(),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    children: [
                      GestureDetector(
                        onTap: () => print("Hi"),
                        child: Chip(
                          backgroundColor: whitecolor,
                          labelPadding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 9),
                          elevation: 5,
                          label: StaticText(
                              color: darkcolor,
                              size: normaltextSize,
                              weight: FontWeight.w400,
                              align: TextAlign.center,
                              text: "Hi"),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => print("How are you?"),
                        child: Chip(
                          backgroundColor: whitecolor,
                          labelPadding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 9),
                          elevation: 5,
                          label: StaticText(
                              color: darkcolor,
                              size: normaltextSize,
                              weight: FontWeight.w400,
                              align: TextAlign.center,
                              text: "How Area you?"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  MessageBubble(
                    message: "Hello",
                    isMine: false,
                  ),
                  MessageBubble(
                    message: "I'm good, thanks!",
                    isMine: false,
                  ),
                  MessageBubble(
                    message: "Hey!",
                    isMine: true,
                  ),
                  MessageBubble(
                    message: "I'm fine. How about you?",
                    isMine: true,
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                margin: EdgeInsets.symmetric(vertical: 5),
                width: width - 40,
                decoration: BoxDecoration(
                    color: whitecolor, borderRadius: BorderRadius.circular(25)),
                child: Row(
                  children: [
                    IconButton(
                      alignment: Alignment.center,
                      icon: Icon(FeatherIcons.paperclip,
                          color: iconcolor, size: subHeadingSize),
                      onPressed: () {
                        _controller.toggleattachmenu();
                      },
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                          hintText: "Type your message...",
                        ),
                        onSubmitted: (value) {
                          print(value);
                        },
                      ),
                    ),
                    IconButton(
                      alignment: Alignment.center,
                      icon: Icon(FeatherIcons.send,
                          color: iconcolor, size: subHeadingSize),
                      onPressed: () {
                        print("Attach button pressed");
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
