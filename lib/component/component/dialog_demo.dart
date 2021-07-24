import 'package:flutter/material.dart';

enum Option { A, B, C }

class DialogDemo extends StatefulWidget {
  const DialogDemo({
    Key? key,
  }) : super(key: key);

  @override
  _DialogDemoState createState() => _DialogDemoState();
}

class _DialogDemoState extends State<DialogDemo> {
  String _dialogOption = "";
  String _alertdialogOption = "";
  final bottomSheetScaffoldKey = GlobalKey<ScaffoldState>();
  String _modalBottomSheetValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: bottomSheetScaffoldKey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("dialog return value: $_dialogOption"),
          ElevatedButton(
              onPressed: () {
                openDialog(context);
              },
              child: Text("simple dialog")),
          SizedBox(
            height: 50,
          ),
          Text("dialog return value: $_alertdialogOption"),
          ElevatedButton(
              onPressed: () {
                openAlertDialog(context);
              },
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor),
              child: Text("alert dialog")),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                openBottomSheet(context);
              },
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor),
              child: Text("Scaffold bottom sheet")),
          SizedBox(
            height: 50,
          ),
          Text("bottom modal sheet value: $_modalBottomSheetValue"),
          ElevatedButton(
              onPressed: () {
                openModalBottomSheet(context);
              },
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor),
              child: Text("bottom modal sheet")),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                openSnackBar(context);
              },
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor),
              child: Text("snack bar")),
        ],
      ),
    );
  }

  Future openDialog(BuildContext context) async {
    final dialogOption = await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("SimpleDialog"),
            children: [
              SimpleDialogOption(
                child: Text("option A"),
                onPressed: () {
                  Navigator.pop(context, Option.A);
                },
              ),
              SimpleDialogOption(
                child: Text("option B"),
                onPressed: () {
                  Navigator.pop(context, Option.B);
                },
              ),
              SimpleDialogOption(
                child: Text("option C"),
                onPressed: () {
                  Navigator.pop(context, Option.C);
                },
              ),
            ],
          );
        });
    setState(() {
      _dialogOption = dialogOption.toString();
    });
  }

  Future openAlertDialog(BuildContext context) async {
    var alertDialog = await showDialog(
        context: context,
        //点击空白不能关闭dialog
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("AlertDialog"),
            content: Text("AlertDialog content"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, "123");
                },
                child: Text("確認"),
              ),
            ],
          );
        });
    setState(() {
      _alertdialogOption = alertDialog.toString();
    });
  }

  /// Scaffold
  openBottomSheet(BuildContext context) {
    bottomSheetScaffoldKey.currentState!
        .showBottomSheet((context) => BottomAppBar(
              child: Container(
                height: 300,
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.pause_circle_outline),
                    SizedBox(
                      width: 16,
                    ),
                    Text("01:30 / 03:30"),
                    Expanded(
                      child: Text(
                        "Fix you - Coldplay",
                        textAlign: TextAlign.right,
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  ///全局
  Future openModalBottomSheet(BuildContext context) async {
    final modalBottomSheet = await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 200.0,
            child: Column(
              children: [
                ListTile(
                  subtitle: Text("bottom modal sheet"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  selected: _modalBottomSheetValue == "ModalBottomSheet-A",
                  leading: Icon(Icons.add_alert),
                  title: Text("ModalBottomSheet-A"),
                  onTap: () {
                    Navigator.pop(context, "ModalBottomSheet-A");
                  },
                ),
                ListTile(
                  title: Text("ModalBottomSheet-B"),
                  selected: _modalBottomSheetValue == "ModalBottomSheet-B",
                  onTap: () {
                    Navigator.pop(context, "ModalBottomSheet-B");
                  },
                ),
                ListTile(
                  title: Text("ModalBottomSheet-C"),
                  selected: _modalBottomSheetValue == "ModalBottomSheet-C",
                  onTap: () {
                    Navigator.pop(context, "ModalBottomSheet-C");
                  },
                ),
              ],
            ),
          );
        });
    setState(() {
      _modalBottomSheetValue = modalBottomSheet.toString();
    });
  }

  void openSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 500),
        action: SnackBarAction(
          label: "action",
          onPressed: () {},
        ),
        content: Container(
          child: Text("snackbar"),
        )));
  }
}
