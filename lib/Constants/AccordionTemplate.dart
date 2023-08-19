import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../Theme/ThemeService.dart';
import 'Devider.dart';
import 'ImageClass.dart';
import 'StaticText.dart';

class AccordionTemplate extends StatefulWidget {
  final String title;
  final String type;

  const AccordionTemplate({
    required this.title,
    this.type = "model",
  });

  @override
  _AccordionTemplateState createState() => _AccordionTemplateState();
}

class _AccordionTemplateState extends State<AccordionTemplate> {
  bool expanding = false;
  int selected = 0;

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
                  itemCount: 4, // Öğe sayısı
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => setState(() {
                        selected = index;
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
                            child: _buildColumnContent(widget.type)),
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

_buildColumnContent(type) {
  if (type == 'model') {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      verticalDirection: VerticalDirection.down,
      children: [
        SizedBox(
          height: 60,
          child: ImageClass(
              url: "https://static.thenounproject.com/png/3914609-200.png",
              type: true),
        ),
        Devider(
          size: 5,
        ),
        StaticText(
            text: "Sedan",
            weight: FontWeight.w400,
            size: smalltextSize,
            color: iconcolor)
      ],
    );
  } else if (type == "color") {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      verticalDirection: VerticalDirection.down,
      children: [
        SizedBox(
          height: 60,
          child: ImageClass(
              url:
                  "https://htmlcolorcodes.com/assets/images/colors/red-color-solid-background-1920x1080.png",
              type: true),
        ),
        Devider(
          size: 5,
        ),
        StaticText(
            text: "Qırmızı",
            weight: FontWeight.w400,
            size: smalltextSize,
            color: iconcolor)
      ],
    );
  }
}
