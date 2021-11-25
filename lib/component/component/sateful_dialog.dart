import 'package:flutter/material.dart';

class StatefulDialog extends StatefulWidget {
  const StatefulDialog({
    Key? key,
  }) : super(key: key);

  @override
  _StatefulDialogState createState() => _StatefulDialogState();
}

class _StatefulDialogState extends State<StatefulDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _textEditingController = TextEditingController();

   String _popValue="?";
  changeValue(popValue){
    setState(() {
      _popValue=popValue;
    });
  }
  Future<void> showInformationDialog(BuildContext context,Function changeValue) async {
    String popValue= await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _textEditingController,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "Enter any text";
                        },
                        decoration:
                            InputDecoration(hintText: "Please Enter Text"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Choice Box"),
                          Checkbox(
                              value: isChecked,
                              onChanged: (checked) {
                                setState(() {
                                  isChecked = checked!;
                                });
                              })
                        ],
                      )
                    ],
                  )),
              title: Text('Stateful Dialog'),
              actions: <Widget>[
                InkWell(
                  child: Text('OK   '),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      Navigator.of(context).pop(_textEditingController.text);
                    }
                  },
                ),
              ],
            );
          });
        });
    changeValue(popValue);
  }

  @override
  Widget build(BuildContext context) {
    String _alertDialogRoutePopValue = "";

    return Container(
      child: Center(
        child: Column(
          children: [
            Text("函数形式alert 传回的值==>$_popValue"),
            FlatButton(
                color: Colors.deepOrange,
                onPressed: () {
                  showInformationDialog(context,changeValue);
                },
                child: Text(
                  "Stateful Dialog",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
          ],
        ),
      ),
    );
  }
}


