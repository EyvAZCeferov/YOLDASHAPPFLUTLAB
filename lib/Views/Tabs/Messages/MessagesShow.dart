import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../../Constants/IconButtonElement.dart';
import '../../../Constants/LoaderScreen.dart';
import '../../../Constants/StaticText.dart';
import '../../../Controllers/MessagesController.dart';
import '../../../Functions/helpers.dart';
import '../../../Theme/ThemeService.dart';
import 'MessageBubble.dart';

class MessagesShow extends StatelessWidget {
  late MessagesController _controller = Get.put(MessagesController());

  String getNameToShow() {
    String name = '';
    if (_controller.auth_id.value ==
        _controller.selectedMessageGroup.value?.senderId) {
      name = _controller.selectedMessageGroup.value?.receiverName ?? '';
    } else {
      name = _controller.selectedMessageGroup.value?.senderName ?? '';
    }

    if (name.length > 15) {
      return name.substring(0, 15);
    }

    return name;
  }

  @override
  void dispose() {
    _controller.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < 0) {
          _controller.dispose();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: bodycolor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: whitecolor,
              bottomOpacity: 0,
              centerTitle: true,
              elevation: 0,
              leadingWidth: 42,
              toolbarHeight: 50,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              toolbarOpacity: 1,
              actions: [
                SizedBox(
                  width: 50,
                  child: ElevatedButton(
                    onPressed: () => _controller.callpageredirect(
                        'call',
                        _controller.auth_id.value !=
                                _controller.selectedMessageGroup.value?.senderId
                            ? _controller
                                .selectedMessageGroup.value?.senderPhone
                            : _controller
                                .selectedMessageGroup.value?.receiverPhone,
                        context),
                    style: ElevatedButton.styleFrom(
                      primary: primarycolor,
                      onPrimary: whitecolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Center(
                      child: Icon(FeatherIcons.phoneCall,
                          color: whitecolor, size: normaltextSize),
                    ),
                  ),
                ),
                SizedBox(width: 3),
                // SizedBox(
                //   width: 50,
                //   child: ElevatedButton(
                //     onPressed: () =>
                //         _controller.callpageredirect('video', null, context),
                //     style: ElevatedButton.styleFrom(
                //       primary: primarycolor,
                //       onPrimary: whitecolor,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(50),
                //       ),
                //     ),
                //     child: Icon(FeatherIcons.video,
                //         color: whitecolor, size: normaltextSize),
                //   ),
                // ),
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
                    onPressed: () {
                      dispose();
                    }),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: getimageurl(
                        "user",
                        "users",
                        _controller.auth_id.value ==
                                _controller.selectedMessageGroup.value?.senderId
                            ? _controller.selectedMessageGroup.value
                                    ?.receiverImage ??
                                null
                            : _controller
                                    .selectedMessageGroup.value?.senderImage ??
                                null),
                    placeholder: (context, url) => CircularProgressIndicator(),
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
                      text: getNameToShow(),
                      weight: FontWeight.w500),
                ],
              )),
        ),
        body: Obx(() {
          final selectedgroup = _controller.selectedMessageGroup.value;
          if (selectedgroup == null) {
            return LoaderScreen();
          } else {
            return Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            reverse: false,
                            shrinkWrap: true,
                            controller: _controller.scrollController,
                            physics: const ScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            itemCount:
                                _controller.selectedMessageLists.value.length,
                            itemBuilder: (context, index) {
                              var item =
                                  _controller.selectedMessageLists.value[index];
                              if (item?.status == false &&
                                  item?.messageId != null &&
                                  item?.userId != null) {
                                _controller.readmessage(
                                    item?.messageId as int,
                                    item?.userId as int,
                                    _controller.auth_id.value as int,
                                    context as BuildContext);
                              }
                              if (item?.message != null &&
                                  item?.message != '' &&
                                  item?.message != ' ') {
                                return MessageBubble(
                                  type: item?.messageelementtype ?? 'TEXT',
                                  message: item?.message,
                                  isMine:
                                      _controller.auth_id.value == item?.userId
                                          ? true
                                          : false,
                                );
                              }
                            }),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Container(
                          width: width - 50,
                          height: 50,
                          child: ListView.builder(
                            itemCount: _controller.quickreplies.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var item = _controller.quickreplies[index];
                              return Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _controller.messagetextcontroller.value
                                          .text = item;
                                      _controller.sendtextmessage(context);
                                    },
                                    child: Chip(
                                      backgroundColor: whitecolor,
                                      labelPadding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 9),
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
                                          color: iconcolor,
                                          size: buttontextSize),
                                      onPressed: () {
                                        _controller.pickImage(context);
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
                            controller: _controller.messagetextcontroller.value,
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
      ),
    );
  }
}
