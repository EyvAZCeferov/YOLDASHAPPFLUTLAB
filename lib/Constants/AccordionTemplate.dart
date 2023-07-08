import 'package:flutter/material.dart';

class AccordionTemplate extends StatefulWidget {
  @override
  _AccordionTemplateState createState() => _AccordionTemplateState();
}

class _AccordionTemplateState extends State<AccordionTemplate> {
  List<ExpansionPanelItem> _expansionPanelItems = [
    ExpansionPanelItem(
      headerText: 'Başlık 1',
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Text('İçerik 1'),
      ),
    ),
    ExpansionPanelItem(
      headerText: 'Başlık 2',
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Text('İçerik 2'),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      elevation: 1,
      expandedHeaderPadding: EdgeInsets.all(0),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _expansionPanelItems[index].isExpanded = !isExpanded;
        });
      },
      children:
          _expansionPanelItems.map<ExpansionPanel>((ExpansionPanelItem item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerText),
            );
          },
          body: item.body,
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

class ExpansionPanelItem {
  final String headerText;
  final Widget body;
  bool isExpanded;

  ExpansionPanelItem({
    required this.headerText,
    required this.body,
    this.isExpanded = false,
  });
}
