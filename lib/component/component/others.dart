import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learn_flutter/Component/title_divider.dart';

class Others extends StatefulWidget {
  const Others({
    Key? key,
  }) : super(key: key);

  @override
  _OthersState createState() => _OthersState();
}

class _OthersState extends State<Others> {
  double _slider = 0.0;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  List<ExpansionPanelItem> expansionPanelItems = [];

  Future _selectTime(BuildContext context) async {
    final TimeOfDay? time =
        await showTimePicker(context: context, initialTime: selectedTime);
    setState(() {
      selectedTime = time!;
    });
  }

  Future _selectDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1980),
        lastDate: DateTime(2050));
    setState(() {
      selectedDate = date!;
    });
  }

  @override
  void initState() {
    super.initState();
    expansionPanelItems = <ExpansionPanelItem>[
      ExpansionPanelItem(
          isExpanded: false,
          headerText: "panel A",
          body: Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            child: Text("content for panle A"),
          )),
      ExpansionPanelItem(
          isExpanded: false,
          headerText: "panel B",
          body: Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            child: Text("content for panle A"),
          )),
      ExpansionPanelItem(
          isExpanded: false,
          headerText: "panel C",
          body: Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            child: Text("content for panle A"),
          )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Slider(
              // label: "divisions",
              // divisions: 10,
              activeColor: Colors.deepOrange,
              inactiveColor: Colors.deepOrange.withOpacity(0.3),
              value: _slider,
              onChanged: (double value) {
                setState(() {
                  _slider = value;
                });
              },
            ),
            Text("${(_slider * 100).toStringAsFixed(0)}%"),
          ],
        ),
        SizedBox(
          height: 50,
        ),
        InkWell(
          onTap: () {
            _selectDate(context);
          },
          child: Row(
            children: [
              Text(DateFormat.yMMMd().format(selectedDate)),
              Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
        SizedBox(
          height: 50,
        ),
        InkWell(
          onTap: () {
            _selectTime(context);
          },
          child: Row(
            children: [
              Text(selectedTime.format(context)),
              Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
        TitleDivider(title: "ExpansionPanelList"),
        ExpansionPanelList(
            // dividerColor: Colors.red,
            expandedHeaderPadding: EdgeInsets.zero,
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                expansionPanelItems[panelIndex].isExpanded = !isExpanded;
              });
            },

            ///注意map返回的是一个Iterable 需要转成list
            children: expansionPanelItems
                .map((e) => ExpansionPanel(
                    isExpanded: e.isExpanded,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Container(
                          padding: EdgeInsets.all(16),
                          child: Text(e.headerText));
                    },
                    body: e.body))
                .toList()),
        SizedBox(
          height: 30,
        ),
        ExpansionTile(
          title: Text("ExpansionTile"),
          leading: Icon(Icons.pause_circle_outline),
          trailing: Icon(Icons.settings),
          children: [Text("ExpansionTile1"), Text("ExpansionTile2")],
        )
      ],
    );
  }
}

class ExpansionPanelItem {
  bool isExpanded;
  Widget body;
  String headerText;

  ExpansionPanelItem(
      {required this.isExpanded, required this.body, required this.headerText});
}
