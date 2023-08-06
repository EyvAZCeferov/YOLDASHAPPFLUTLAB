import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/BaseAppBar.dart';
import 'package:yoldash/Constants/LoaderScreen.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Controllers/AuthController.dart';
import 'package:yoldash/Controllers/MessagesController.dart';
import 'package:yoldash/Functions/helpers.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class MessagesIndex extends StatelessWidget {
  late MessagesController _controller = Get.put(MessagesController());
  late AuthController _authcontroller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    _controller.getMessages(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bodycolor,
      appBar: BaseAppBar(
          backbutton: false,
          changeprof: false,
          title: "chat".tr,
          titlebg: false,
          bgcolorheader: whitecolor),
      body: Obx(() => _controller.refreshpage.value == true
          ? LoaderScreen()
          : _controller.data.length > 0
              ? RefreshIndicator(
                  onRefresh: () => _controller.getMessages(context),
                  color: secondarycolor,
                  strokeWidth: 2,
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                  backgroundColor: whitecolor,
                  child: ListView.builder(
                    itemCount: _controller.data.length,
                    itemBuilder: (context, index) {
                      var item = _controller.data[index];

                      return GestureDetector(
                        onTap: () {
                          _controller.selectedMessageGroup = item;
                          Get.toNamed('/messages/${item.id}', arguments: item);
                        },
                        child: Center(
                            child: Container(
                          width: width - 40,
                          height: 75,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          margin: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border(
                                  bottom: BorderSide(
                                      color: iconcolor,
                                      style: BorderStyle.solid,
                                      width: 1))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: _authcontroller.authType ==
                                            'rider'
                                        ? imageurl +
                                            (item.receiverImage ??
                                                'users/noprofilepicture.webp')
                                        : imageurl +
                                            (item.senderImage ??
                                                'users/noprofilepicture.webp'),
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    imageBuilder: (context, imageProvider) =>
                                        CircleAvatar(
                                      backgroundColor: primarycolor,
                                      foregroundColor: whitecolor,
                                      radius: 25,
                                      backgroundImage: imageProvider,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      StaticText(
                                          text: _authcontroller.authType ==
                                                  'rider'
                                              ? item.receiverName.toString()
                                              : item.senderName.toString(),
                                          weight: FontWeight.w500,
                                          size: normaltextSize,
                                          color: darkcolor,
                                          align: TextAlign.left),
                                      StaticText(
                                          text: (item.messages != null &&
                                                  item.messages!.isNotEmpty)
                                              ? item.messages![0].message!
                                                      .substring(0, 8) +
                                                  '...'
                                              : '',
                                          weight: FontWeight.w500,
                                          size: smalltextSize,
                                          color: iconcolor,
                                          align: TextAlign.left),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    item.count != null && item.count! > 0
                                        ? Container(
                                            width: 35,
                                            height: 20,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: errorcolor,
                                            ),
                                            child: StaticText(
                                              color: whitecolor,
                                              size: smalltextSize,
                                              text: item.count!.toString(),
                                              weight: FontWeight.w500,
                                              align: TextAlign.center,
                                            ),
                                          )
                                        : SizedBox(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        item.count != 0
                                            ? SizedBox()
                                            : Icon(FontAwesomeIcons.checkDouble,
                                                color: secondarycolor,
                                                size: buttontextSize),
                                        SizedBox(width: 10),
                                        StaticText(
                                          text: formatDateTime(DateTime.parse(
                                              item.messagegroupCreatedAt
                                                  as String)),
                                          weight: FontWeight.w400,
                                          size: smalltextSize,
                                          color: iconcolor,
                                          align: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ]),
                            ],
                          ),
                        )),
                      );
                    },
                  ))
              : Center(
                  child: StaticText(
                    color: errorcolor,
                    size: buttontextSize,
                    weight: FontWeight.w500,
                    align: TextAlign.center,
                    text: "nohasdata".tr,
                  ),
                )),
    );
  }
}
