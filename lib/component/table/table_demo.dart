import 'package:flutter/material.dart';
import 'package:learn_flutter/model/user.dart';

import 'datatable_demo.dart';

class TableDemo extends StatefulWidget {
  const TableDemo({Key? key}) : super(key: key);

  @override
  _TableDemoState createState() => _TableDemoState();
}

class _TableDemoState extends State<TableDemo> {
  int _selectedIndex = 0;
  int _sortColumnIndex = 0;
  bool _asc = false;
  _CustomDataSource _customDataSource=_CustomDataSource();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("table")),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            labelType: NavigationRailLabelType.all,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.favorite),
                label: Text('Datatable'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bookmark_border),
                selectedIcon: Icon(Icons.book),
                label: Text('paginated'),
              ),
            ],
          ),
          VerticalDivider(thickness: 1, width: 1),
          Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  DataTableDemo(),
                  ListView(
                      children: [
                        PaginatedDataTable(
                            header: Text("paginated table"),
                            source: _customDataSource,
                            rowsPerPage: 5,
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
                                      //分页排序要对_CustomDataSource source 构造排序算
                                      _customDataSource.sort(_customDataSource._users,ascending);
                                    });
                                  }),
                              DataColumn(
                                  label: Text("author"),
                                  onSort: (int columnIndex, bool ascending) {
                                    setState(() {
                                      _sortColumnIndex = columnIndex;
                                      _asc = ascending;
                                      _customDataSource.sort(_customDataSource._users,ascending);
                                    });
                                  }),
                            ]),
                      ]
                  ),

                ],
              ))
        ],
      ),
    );
  }
}

///abstract class DataTableSource extends ChangeNotifier
///DataTableSource 是发布者publish
class _CustomDataSource extends DataTableSource {
  List<User> _users = users;
  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    final _user = _users[index];
    return DataRow.byIndex(
        index: index,
        selected:_users[index].isSelected ,
        onSelectChanged: (value){

        },
        cells: [
      DataCell(
        CircleAvatar(
            backgroundImage:
            NetworkImage(_user.avatar)),
      ),
      DataCell(Text(_user.title)),
      DataCell(Text(_user.title)),
    ]);
    throw UnimplementedError();
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _users.length;

  @override
  int get selectedRowCount => _selectedCount;

  void sort(List<User> users, bool ascending) {
    if(ascending){
      users.sort((a,b)=>a.title.compareTo(b.title));
    }else{
      users.sort((a,b)=>b.title.compareTo(a.title));
    }
    ///发布消息
    notifyListeners();
  }
}
