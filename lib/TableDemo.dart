import 'package:flutter/material.dart';
import 'package:formvalidation/data/User.dart';
import 'package:formvalidation/data/UserTable.dart';

class TableDemo extends StatefulWidget {
  @override
  TableDemoState createState() => TableDemoState();
}

class TableDemoState extends State<TableDemo> {
  List<UserTable> users;
  List<UserTable> selectedUsers;
  bool sort;

  @override
  void initState() {
    sort = false;
    users = UserTable.getUsers();
    selectedUsers = [];
    super.initState();
  }

  onSortColumn(int columnIndex, bool ascending) {
    setState(() {
      if (columnIndex == 0) {
        if (ascending) {
          users.sort((a, b) => a.firstName.compareTo(b.firstName));
        } else {
          users.sort((a, b) => b.firstName.compareTo(a.firstName));
        }
      }
    });
  }

  onSelectedRow(bool selected, UserTable user) async {
    setState(() {
      if (selected) {
        selectedUsers.add(user);
      } else {
        selectedUsers.remove(user);
      }
    });
  }

  deleteSelected() async {
    setState(() {
      if (selectedUsers.isNotEmpty) {
        List<UserTable> temp = [];
        temp.addAll(selectedUsers);
        for (UserTable user in temp) {
          users.remove(user);
          selectedUsers.remove(user);
        }
      }
    });
  }

  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      child: DataTable(
        sortAscending: sort,
        sortColumnIndex: 0,
        columns: [
          DataColumn(
              label: Text("First Name"),
              numeric: false,
              tooltip: "This is the first name",
              onSort: (columnIndex, ascending) {
                setState(() {
                  sort != sort;
                });
                onSortColumn(columnIndex, ascending);
              }),
          DataColumn(
              label: Text("Last Name"),
              numeric: false,
              tooltip: "This is the Last name"),
        ],
        rows: users
            .map(
              (user) => DataRow(
                  selected: selectedUsers.contains(user),
                  onSelectChanged: (b) {
                    print("selected");
                    onSelectedRow(b, user);
                  },
                  cells: [
                    DataCell(Text(user.firstName), onTap: () {
                      print("You selected ${user.firstName}");
                    }),
                    DataCell(
                      Text(user.lastName),
                    )
                  ]),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Table Demo"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Expanded(
            child: Center(
              child: dataBody(),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: OutlineButton(
                  child: Text("SELECTED ${selectedUsers.length}"),
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: OutlineButton(
                  child: Text("DELETE SELECTED ${selectedUsers.length}"),
                  onPressed: selectedUsers.isEmpty
                      ? null
                      : () {
                          deleteSelected();
                        },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
