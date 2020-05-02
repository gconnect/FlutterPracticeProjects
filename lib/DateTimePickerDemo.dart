import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataTimeDemo extends StatefulWidget {
  @override
  DataTimeDemoState createState() => DataTimeDemoState();
}

class DataTimeDemoState extends State<DataTimeDemo> {
  DateTime _currentDate = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();

  Future<Null> _selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _currentDate,
        firstDate: DateTime(2016),
        lastDate: DateTime(2022),
        builder: (context, child) {
          return SingleChildScrollView(child: child);
        });

    if (picked != null && picked != _currentDate) {
      print("Date selected: ${_currentDate.toString()}");
      setState(() {
        _currentDate = picked;
      });
    }
  }

  Future iosDateTimePicker(BuildContext context) async {
    return CupertinoDatePicker(
      initialDateTime: _currentDate,
      onDateTimeChanged: (dateTime) {
        print(dateTime);
        setState(() {
          _currentDate = dateTime;
        });
      },
    );
  }

  Future<Null> selectTime(BuildContext context) async {
    TimeOfDay selectedTime =
        await showTimePicker(context: context, initialTime: timeOfDay);
    if (selectedTime != null && selectedTime != timeOfDay) {
      setState(() {
        timeOfDay = selectedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String _formattedDate = DateFormat.yMMMd().format(_currentDate);
    return Scaffold(
      appBar: AppBar(
        title: Text("Date and Time Picker"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                _selectedDate(context);
              },
              icon: Icon(Icons.calendar_today))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text("Date selected ${_formattedDate.toString()}"),
            Text("Time selected ${timeOfDay}"),
            RaisedButton(
              onPressed: () {
                selectTime(context);
              },
              child: Text("Select Date"),
            ),
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                initialDateTime: _currentDate,
                onDateTimeChanged: (dateTime) {
                  print(dateTime);
                  setState(() {
                    _currentDate = dateTime;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
