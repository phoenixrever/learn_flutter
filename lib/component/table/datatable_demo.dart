import 'package:flutter/material.dart';
import 'package:learn_flutter/model/user.dart';

class DataTableDemo extends StatefulWidget {
  const DataTableDemo({Key? key}) : super(key: key);

  @override
  _DataTableDemoState createState() => _DataTableDemoState();
}

class _DataTableDemoState extends State<DataTableDemo> {
  int _sortColumnIndex = 0;
  bool _asc = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DataTable(
          ///必须和onSort配合使用
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _asc,
            columnSpacing: 10,

            ///默认为true
            // showCheckboxColumn: true,
            // headingRowColor: MaterialStateProperty.all(Colors.red),
            // dataRowColor:
            //     MaterialStateProperty.all(Color(0x31FF1111)),
            columns: [
              DataColumn(
                label: Text("avatar"),
              ),
              DataColumn(
                  label: Text("title"),
                  onSort: (int columnIndex, bool ascending) {
                    setState(() {
                      _sortColumnIndex = columnIndex;
                      _asc = ascending;
                      if (ascending) {
                        ///sort 为list的方法
                        users.sort(
                                (a, b) => a.title.compareTo(b.title));
                      } else {
                        users.sort(
                                (a, b) => b.title.compareTo(a.title));
                      }
                    });
                  }),
              DataColumn(
                  label: Text("author"),
                  onSort: (int columnIndex, bool ascending) {
                    setState(() {
                      _sortColumnIndex = columnIndex;
                      _asc = ascending;
                      if (ascending) {
                        ///sort 为list的方法
                        users.sort(
                                (a, b) => a.title.compareTo(b.title));
                      } else {
                        users.sort(
                                (a, b) => b.title.compareTo(a.title));
                      }
                    });
                  }),
            ],
            rows: users
                .map((e) => DataRow(
                selected: e.isSelected,

                ///开启checkbox
                onSelectChanged: (value) {
                  print(value);
                  setState(() {
                    e.isSelected = value!;
                  });
                },
                cells: [
                  DataCell(
                    CircleAvatar(
                        backgroundImage:
                        NetworkImage(e.avatar)),
                  ),
                  DataCell(Text(e.title)),
                  DataCell(Text(e.title)),
                ]))
                .toList())
      ],
    );
  }
}
