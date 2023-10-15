import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../../../Constants/BaseAppBar.dart';
import '../../../../Constants/Devider.dart';
import '../../../../Constants/ImageClass.dart';
import '../../../../Constants/LoaderScreen.dart';
import '../../../../Constants/StaticText.dart';
import '../../../../Controllers/HistoryController.dart';
import '../../../../Functions/helpers.dart';
import '../../../../Theme/ThemeService.dart';
import '../../../../models/rides.dart';

class HistoryIndex extends StatefulWidget {
  @override
  State<HistoryIndex> createState() => _HistoryIndexState();
}

class _HistoryIndexState extends State<HistoryIndex> {
  final HistoryController _controller = Get.find<HistoryController>();

  Color getstatcolor(String? type) {
    if (type == "waiting" || type == "changed") {
      return Color(0xffffcc00);
    } else if (type == "completed") {
      return Color(0xff339900);
    } else if (type == "notcompleted" || type == "cancelled") {
      return Color(0xffcc3300);
    } else if (type == "ontheway") {
      return Color(0xffff9966);
    } else {
      return Color(0xffffcc00);
    }
  }

  List<Widget> getaddress(ride) {
    if (ride.coordinates != null) {
      List<Widget> elements = [];
      for (var address in ride.coordinates!) {
        elements.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StaticText(
              color: secondarycolor,
              size: smalltextSize,
              text: address.address as String,
              weight: FontWeight.bold,
            ),
            Devider(),
          ],
        ));
      }

      return elements;
    } else {
      List<Widget> elements = [];
      return elements;
    }
  }

  Queries? getQuery(List<Queries>? queries) {
    if (queries != null && queries.length > 0) {
      for (var i = 0; i < queries.length; i++) {
        var query = queries[i];
        if (query.userId == _controller.auth_id.value) {
          return query;
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _controller.getRides(context, null,true);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: bodycolor,
        appBar: BaseAppBar(
          backbutton: true,
          title: "history".tr,
          changeprof: false,
          titlebg: false,
        ),
        body: Obx(() => _controller.refreshpage.value == true
            ? LoaderScreen()
            : _controller.data.length > 0
                ? RefreshIndicator(
                    onRefresh: () => _controller.getRides(context, null),
                    color: secondarycolor,
                    strokeWidth: 2,
                    triggerMode: RefreshIndicatorTriggerMode.anywhere,
                    backgroundColor: whitecolor,
                    child: ListView.builder(
                      itemCount: _controller.data.length,
                      itemBuilder: (context, index) {
                        Rides ride = _controller.data[index]!;

                        Queries? query = getQuery(ride.queries);
                        return GestureDetector(
                          onTap: () {
                            _controller.selectedRide.value = ride;
                            _controller.getRides(context, ride.id);
                            Get.toNamed('/history/${ride.id}');
                          },
                          child: Center(
                              child: Container(
                            width: width - 40,
                            height: 300,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            margin: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                                color: whitecolor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    blurStyle: BlurStyle.solid,
                                    color: Colors.black38,
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                  )
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Devider(size: 3),
                                Container(
                                  alignment: Alignment.center,
                                  width: 120,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: ride?.userId == _controller.auth_id
                                        ? getstatcolor(ride?.status)
                                        : getstatcolor(query?.status),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: StaticText(
                                    color: whitecolor,
                                    size: smalltextSize,
                                    weight: FontWeight.w500,
                                    align: TextAlign.center,
                                    text: ride?.userId == _controller.auth_id
                                        ? "ride_${ride?.status}".tr
                                        : "ride_${query?.status}".tr,
                                  ),
                                ),
                                Devider(size: 3),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 44,
                                      height: 110,
                                      child: ImageClass(
                                          url:
                                              "assets/images/destinationicon.png",
                                          type: false),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children:
                                            ride?.userId == _controller.auth_id
                                                ? getaddress(ride)
                                                : getaddress(query),
                                      ),
                                    ),
                                  ],
                                ),
                                Devider(size: 3),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(FeatherIcons.user,
                                              color: primarycolor,
                                              size: buttontextSize),
                                          SizedBox(width: 5),
                                          StaticText(
                                            color: darkcolor,
                                            size: smalltextSize,
                                            align: TextAlign.left,
                                            weight: FontWeight.w400,
                                            text: () {
                                              if (ride?.userId ==
                                                  _controller.auth_id) {
                                                final places = ride?.automobil
                                                        ?.autotype?.places
                                                        ?.toString() ??
                                                    '4';
                                                return "yer_sayi".trParams(
                                                    {'counter': places});
                                              } else {
                                                if (query?.place != null &&
                                                    query?.place!.name !=
                                                        null) {
                                                  return getLocalizedValue(
                                                          query?.place?.name,
                                                          'name') ??
                                                      '';
                                                } else {
                                                  return 'fullreservation'.tr;
                                                }
                                              }
                                            }(),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Devider(size: 3),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    StaticText(
                                      text: ride?.userId == _controller.auth_id
                                          ? ride.priceOfWay.toString() + ' AZN'
                                          : (query?.priceEndirim ??
                                                      query?.price)
                                                  .toString() +
                                              ' AZN',
                                      weight: FontWeight.w600,
                                      size: subHeadingSize,
                                      color: primarycolor,
                                      align: TextAlign.left,
                                    ),
                                    StaticText(
                                      text: ride?.userId == _controller.auth_id
                                          ? convertStringToTime(ride.createdAt) : convertStringToTime(query?.createdAt),
                                      weight: FontWeight.w400,
                                      size: smalltextSize,
                                      color: iconcolor,
                                      align: TextAlign.right,
                                    )
                                  ],
                                ),
                                Devider(size: 3),
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
                  )));
  }
}
