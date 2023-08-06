import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/IconButtonElement.dart';
import 'package:yoldash/Constants/LoaderScreen.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Controllers/AuthController.dart';
import 'package:yoldash/Controllers/MainController.dart';
import 'package:yoldash/Controllers/MessagesController.dart';
import 'package:yoldash/Functions/helpers.dart';
import 'package:yoldash/Theme/ThemeService.dart';
import 'package:yoldash/Views/Tabs/Messages/MessageBubble.dart';

class MessagesShow extends StatelessWidget {
  late MessagesController _controller = Get.put(MessagesController());
  late AuthController _authcontroller = Get.put(AuthController());
  late MainController _maincontroller = Get.put(MainController());

  Future<int> getAuthId() async {
    var data = await _maincontroller.getstoragedat('auth_id');
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return FutureBuilder<int>(
      future: getAuthId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoaderScreen();
        } else if (snapshot.hasData) {
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
                        onPressed: () =>
                            _controller.callpageredirect('call', context),
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
                        onPressed: () =>
                            _controller.callpageredirect('video', context),
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
                            color: iconcolor,
                            width: 1,
                            style: BorderStyle.solid)),
                    child: IconButtonElement(
                        icon: FeatherIcons.chevronLeft,
                        color: Colors.black,
                        size: buttontextSize,
                        onPressed: () {
                          _controller.selectedMessageGroup.value = null;
                          Get.back();
                        }),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: _authcontroller.authType == 'rider'
                            ? imageurl +
                                (_controller.selectedMessageGroup.value!
                                        .receiverImage ??
                                    'users/noprofilepicture.webp')
                            : imageurl +
                                (_controller.selectedMessageGroup.value!
                                        .senderImage ??
                                    'users/noprofilepicture.webp'),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          backgroundColor: primarycolor,
                          foregroundColor: whitecolor,
                          radius: 20,
                          backgroundImage: imageProvider,
                        ),
                      ),
                      SizedBox(width: 5),
                      StaticText(
                          align: TextAlign.center,
                          color: darkcolor,
                          size: smalltextSize,
                          text: _authcontroller.authType.value == 'rider'
                              ? _controller.selectedMessageGroup.value!
                                          .receiverName
                                          .toString()
                                          .length >
                                      15
                                  ? _controller
                                      .selectedMessageGroup.value!.receiverName
                                      .toString()
                                      .substring(0, 15)
                                  : _controller
                                      .selectedMessageGroup.value!.receiverName
                                      .toString()
                              : _controller.selectedMessageGroup.value!
                                          .senderName
                                          .toString()
                                          .length >
                                      15
                                  ? _controller
                                      .selectedMessageGroup.value!.senderName
                                      .toString()
                                      .substring(0, 15)
                                  : _controller
                                      .selectedMessageGroup.value!.senderName
                                      .toString(),
                          weight: FontWeight.w500),
                    ],
                  )),
            ),
            body: Obx(() {
              final selectedgroup = _controller.selectedMessageGroup.value;
              if (selectedgroup == null) {
                return LoaderScreen();
              } else {
                return _controller.refreshpage.value == true
                    ? LoaderScreen()
                    : Column(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      reverse: true,
                                      shrinkWrap: true,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      itemCount: selectedgroup.messages!.length,
                                      itemBuilder: (context, index) {
                                        var item =
                                            selectedgroup.messages![index];
                                        return MessageBubble(
                                          message: item.message.toString(),
                                          isMine: snapshot.data == item.userId!
                                              ? true
                                              : false,
                                        );
                                      }),
                                ),
                                SizedBox(height: 10),
                                Center(
                                  child: Container(
                                    width: width - 50,
                                    height: 50,
                                    child: ListView.builder(
                                      itemCount:
                                          _controller.quickreplies.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        var item =
                                            _controller.quickreplies[index];
                                        return Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                _controller
                                                    .messagetextcontroller
                                                    .value
                                                    .text = item;
                                                _controller
                                                    .sendtextmessage(context);
                                              },
                                              child: Chip(
                                                backgroundColor: whitecolor,
                                                labelPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 4,
                                                        horizontal: 9),
                                                elevation: 5,
                                                label: StaticText(
                                                    color: darkcolor,
                                                    size: normaltextSize,
                                                    weight: FontWeight.w400,
                                                    align: TextAlign.center,
                                                    text: item),
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                _controller.showattachmenu.value == true
                                    ? Container(
                                        width: 60,
                                        height: 100,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: whitecolor,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: IconButton(
                                                alignment: Alignment.center,
                                                icon: Icon(FeatherIcons.image,
                                                    color: iconcolor,
                                                    size: buttontextSize),
                                                onPressed: () {
                                                  _controller
                                                      .pickImage(context);
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: whitecolor,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: IconButton(
                                                alignment: Alignment.center,
                                                icon: Icon(FeatherIcons.mapPin,
                                                    color: iconcolor,
                                                    size: buttontextSize),
                                                onPressed: () {
                                                  _controller.showmap(context);
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                          Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              margin: EdgeInsets.symmetric(vertical: 5),
                              width: width - 40,
                              decoration: BoxDecoration(
                                  color: whitecolor,
                                  borderRadius: BorderRadius.circular(25)),
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
                                      controller: _controller
                                          .messagetextcontroller.value,
                                      decoration: InputDecoration.collapsed(
                                        hintText: "message".tr + '...',
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
                                      _controller.sendtextmessage(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
              }
            }),
          );
        } else if (snapshot.hasError) {
          return LoaderScreen();
        } else {
          return LoaderScreen();
        }
      },
    );
  }
}
