import 'package:flutter/material.dart';
import 'package:formvalidation/data/Company.dart';

class DropDownDemo extends StatefulWidget {
  @override
  DropDownDemoState createState() => DropDownDemoState();
}

class DropDownDemoState extends State<DropDownDemo> {
  List<Company> _companies;
  List<DropdownMenuItem<Company>> _dropdownMenuitems;
  Company _selectedCompany;

  @override
  void initState() {
    _companies = Company.getCompany();
    _dropdownMenuitems = buildDropDownMenuItems(_companies);
    _selectedCompany = _dropdownMenuitems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Company>> buildDropDownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = List();
    for (Company company in companies) {
      items.add(DropdownMenuItem(
        value: company,
        child: Text(company.name),
      ));
    }
    return items;
  }

  onDropDownItemChanged(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Dropdown Demo"),
        ),
        body: Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Select Company"),
                SizedBox(
                  height: 20.0,
                ),
                DropdownButton(
                  value: _selectedCompany,
                  items: _dropdownMenuitems,
                  onChanged: onDropDownItemChanged,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text("Selected: ${_selectedCompany.name}"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
