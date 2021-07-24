import 'package:flutter/material.dart';

import '../title_divider.dart';

class CheckBoxRadio extends StatefulWidget {
  const CheckBoxRadio({
    Key? key,
  }) : super(key: key);

  @override
  _CheckBoxRadioState createState() => _CheckBoxRadioState();
}

class _CheckBoxRadioState extends State<CheckBoxRadio> {
  bool _checkBox1 = false;
  int _radioGroup = 0;
  bool _switchValue = true;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: _checkBox1,
          onChanged: (value) {
            setState(() {
              this._checkBox1 = !_checkBox1;
            });
          },
          activeColor: Colors.red,
        ),
        CheckboxListTile(
            title: Text("checkBox"),
            subtitle: Text("subtitle"),
            secondary: Icon(Icons.bookmark),
            // shape: Border.all(color: Colors.yellowAccent),

            selected: _checkBox1,
            selectedTileColor: Colors.amber,
            value: _checkBox1,
            onChanged: (value) {
              setState(() {
                this._checkBox1 = !_checkBox1;
              });
            }),
        TitleDivider(
          title: "radio",
        ),
        Row(
          children: [
            //value =  _radioGroup值 的才会被  选中
            Radio(
                value: 0,
                groupValue: _radioGroup,
                onChanged: (value) {
                  setState(() {
                    _radioGroup = value as int;
                  });
                }),
            Radio(
                value: 1,
                groupValue: _radioGroup,
                onChanged: (value) {
                  setState(() {
                    _radioGroup = value as int;
                  });
                }),
          ],
        ),
        RadioListTile(
            title: Text("RadioListTile"),
            secondary: Icon(Icons.arrow_forward_ios),
            // selectedTileColor: Colors.amber,
            selected: _radioGroup == 0 ? true : false,
            subtitle: Text("subtitle"),
            value: 0,
            groupValue: _radioGroup,
            onChanged: (value) {
              setState(() {
                _radioGroup = value as int;
              });
            }),
        RadioListTile(
            title: Text("RadioListTile"),
            secondary: Icon(Icons.arrow_forward_ios),
            // selectedTileColor: Colors.amber,
            selected: _radioGroup == 1 ? true : false,
            subtitle: Text("subtitle"),
            value: 1,
            groupValue: _radioGroup,
            onChanged: (value) {
              setState(() {
                _radioGroup = value as int;
              });
            }),
        Row(
          children: [
            Text(_switchValue ? '😊' : '😢'),
            Switch(
              value: _switchValue,
              onChanged: (bool value) {
                setState(() {
                  _switchValue = value;
                });
              },
            )
          ],
        ),
        SwitchListTile(
            title: Text("SwitchListTile"),
            secondary: _switchValue?Icon(Icons.wifi):Icon(Icons.wifi_off),
            // subtitle: Text("subtitle"),
            selected:_switchValue ,
            value: _switchValue,
            onChanged: (value) {
              setState(() {
                _switchValue = value;
              });
            }),

      ],
    );
  }
}