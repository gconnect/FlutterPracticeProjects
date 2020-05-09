import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'employee.dart';

class DatabaseDemo extends StatefulWidget {
  @override
  _DatabaseDemoState createState() => _DatabaseDemoState();
}

class _DatabaseDemoState extends State<DatabaseDemo> {
  Future<List<Employee>> employees;
  TextEditingController controller = TextEditingController();
  String name;
  int userId;
  final formKey = GlobalKey<FormState>();
  var dbHelper;
  bool isUpdating;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    isUpdating = false;
    refreshList();
  }

  refreshList() {
    setState(() {
      employees = dbHelper.getEmployees();
    });
  }

  clearText() {
    controller.text = "";
  }

  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (isUpdating) {
        Employee employee = Employee(id: userId, name: name);
        dbHelper.update(employee);
        setState(() {
          isUpdating = false;
        });
      } else {
        Employee employee = Employee(id: null, name: name);
        dbHelper.save(employee);
      }
      clearText();
      refreshList();
    }
  }

  form() {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (val) => val.length == 0 ? "Enter name" : null,
              onSaved: (val) => name = val,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: validate,
                  child: Text(isUpdating ? "UPDATE" : "ADD"),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      isUpdating = false;
                    });
                    clearText();
                  },
                  child: Text("CANCEL"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  SingleChildScrollView dataTable(List<Employee> employees) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(label: Text('NAME')),
          DataColumn(label: Text('DELETE')),
        ],
        rows: employees.map((employee) => DataRow(cells: [
              DataCell(Text(employee.name), onTap: () {
                setState(() {
                  isUpdating = true;
                  userId = employee.id;
                });
                controller.text = employee.name;
              }),
              DataCell(IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  dbHelper.delete(employee.id);
                  setState(() {
                    refreshList();
                  });
                },
              ))
            ])),
      ),
    );
  }

  Widget _buildCarList(List<Employee> employee) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemBuilder: (BuildContext context, int index) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      InkWell(
                          onTap: () {
                            setState(() {
                              isUpdating = true;
                              userId = employee[index].id;
                            });
                            controller.text = employee[index].name;
                          },
                          child: Text(employee[index].name)),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          dbHelper.delete(employee[index].id);
                          setState(() {
                            refreshList();
                          });
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: employee.length,
      ),
    );
  }

  list() {
    return Expanded(
      child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }
          if (null == snapshot.hasData || snapshot.data.length == 0) {
            return Text("No data found");
          }
          return CircularProgressIndicator();
        },
        future: employees,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Databse Demo"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            form(),
            list(),
          ],
        ),
      ),
    );
  }
}
