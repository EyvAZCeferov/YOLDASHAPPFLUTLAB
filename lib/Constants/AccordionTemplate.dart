import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yoldashapp/Controllers/AutomobilsController.dart';
import 'package:yoldashapp/Functions/helpers.dart';

import '../Theme/ThemeService.dart';
import '../models/automobils.dart';
import 'Devider.dart';
import 'ImageClass.dart';
import 'StaticText.dart';

class AccordionTemplate extends StatefulWidget {
  final String title;
  final String type;
  final List? data;

  const AccordionTemplate({
    required this.title,
    this.type = "model",
    this.data,
  });

  @override
  _AccordionTemplateState createState() => _AccordionTemplateState();
}

class _AccordionTemplateState extends State<AccordionTemplate> {
  bool expanding = false;
  int selected = -1;
  final AutomobilsController automobilscontroller =
      Get.put(AutomobilsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Container(
          width: Get.width - 40,
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          margin: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
              color: whitecolor,
              borderRadius: BorderRadius.circular(15),
              shape: BoxShape.rectangle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  blurStyle: BlurStyle.solid,
                  color: Colors.black38,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StaticText(
                      text: widget.title,
                      weight: FontWeight.w500,
                      align: TextAlign.left,
                      size: normaltextSize,
                      color: darkcolor),
                ],
              ),
              Container(
                width: 50,
                height: 100,
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: () => setState(() {
                          expanding = !expanding;
                        }),
                    style: ElevatedButton.styleFrom(
                      primary: whitecolor,
                      onPrimary: whitecolor,
                      alignment: Alignment.center,
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: whitecolor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ).merge(ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(double.infinity, 55)),
                    )),
                    child: Icon(
                      expanding == true
                          ? FontAwesomeIcons.chevronUp
                          : FontAwesomeIcons.chevronDown,
                      color: darkcolor,
                      size: normaltextSize,
                    )),
              )
            ],
          ),
        )),
        expanding == true
            ? Center(
                child: Container(
                width: Get.width - 40,
                height: 100,
                color: whitecolor,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.type == "types" ? widget.data?.length : 5,
                  itemBuilder: (context, index) {
                    var dat = widget.data?[index];
                    return GestureDetector(
                      onTap: () => setState(() {
                        selected = index;
                        if (widget.type == "types") {
                          automobilscontroller.selectedAutotype.value = dat;
                        } else if (widget.type == "images") {
                          if (dat == '' || dat == ' ')
                            automobilscontroller.pickImage(
                                "types_$index", context);
                        }
                      }),
                      child: Center(
                        child: Container(
                            width: 100,
                            height: 90,
                            margin: EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                                color: whitecolor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: selected == index
                                        ? primarycolor
                                        : iconcolor,
                                    width: 1,
                                    style: BorderStyle.solid)),
                            child: _buildColumnContent(widget.type, dat)),
                      ),
                    );
                  },
                ),
              ))
            : SizedBox()
      ],
    );
  }
}

_buildColumnContent(type, data) {
  if (data != null) {
    if (type == "types") {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: [
          SizedBox(
            height: 60,
            child: CachedNetworkImage(
              imageUrl: getimageurl(type, 'automobils/types', data.icon),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              imageBuilder: (context, imageProvider) => CircleAvatar(
                backgroundColor: primarycolor,
                foregroundColor: whitecolor,
                radius: 35,
                backgroundImage: imageProvider,
              ),
            ),
          ),
          Devider(
            size: 5,
          ),
          StaticText(
              text: getLocalizedValue(data.name as Name, 'name').toString(),
              weight: FontWeight.w400,
              size: smalltextSize,
              color: iconcolor)
        ],
      );
    } else if (type == "images") {
      return Container(
        width: 50,
        height: 100,
        decoration: BoxDecoration(
            color: whitecolor,
            borderRadius: BorderRadius.circular(15),
            shape: BoxShape.rectangle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurStyle: BlurStyle.solid,
                color: Colors.black38,
                blurRadius: 10,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ]),
        alignment: Alignment.center,
        child: data != ' ' && data != '' && data.length > 1
            ? Icon(
                FeatherIcons.check,
                color: secondarycolor,
                size: buttontextSize,
              )
            : Icon(
                FeatherIcons.upload,
                color: secondarycolor,
                size: normaltextSize,
              ),
      );
    }
  }
}
