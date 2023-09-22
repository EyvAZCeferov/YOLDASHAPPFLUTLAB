import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yoldashapp/Constants/StaticText.dart';
import 'package:yoldashapp/Theme/ThemeService.dart';
import 'package:yoldashapp/models/searchionglocations.dart';

import '../Controllers/GoingController.dart';

class SearchedLocationItems extends StatefulWidget {
  final SearchingLocations searchedlocation;
  const SearchedLocationItems({Key? key, required this.searchedlocation})
      : super(key: key);

  @override
  _SearchedLocationItemsState createState() => _SearchedLocationItemsState();
}

class _SearchedLocationItemsState extends State<SearchedLocationItems> {
  final GoingController goingcontroller = Get.put(GoingController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        goingcontroller.selectsearchedloc(
            widget.searchedlocation.place_id as String, context);
      },
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          border: Border.all(
              color: primarycolor, style: BorderStyle.solid, width: 1),
          color: whitecolor,
          shape: BoxShape.rectangle,
        ),
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              FeatherIcons.mapPin,
              color: secondarycolor,
              size: 24,
            ),
            SizedBox(
              width: 14,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StaticText(
                  color: darkcolor,
                  size: smalltextSize + 2,
                  weight: FontWeight.w600,
                  text: widget.searchedlocation.main_text.toString().length>35 ? widget.searchedlocation.main_text.toString().substring(0,35)+'...' : widget.searchedlocation.main_text.toString(),
                  align: TextAlign.left,
                  textOverflow: TextOverflow.clip,
                  maxline: 3,
                ),
                StaticText(
                  color: secondarycolor,
                  size: smalltextSize - 1,
                  weight: FontWeight.w400,
                  text:
                      widget.searchedlocation.secondary_text.toString().length >
                              40
                          ? widget.searchedlocation.secondary_text
                              .toString()
                              .substring(0, 40) + '...'
                          : widget.searchedlocation.secondary_text.toString(),
                  align: TextAlign.left,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
