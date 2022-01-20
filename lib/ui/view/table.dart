import 'package:flutter/material.dart';
import 'package:myflutterapp/datasource/MeetingDataSource.dart';
import 'package:myflutterapp/dialog/appointment_creator.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TableView extends StatefulWidget {
  TableView({Key key, this.title}) : super(key: key);

  final String title;

  @override

  _TableViewState createState() => _TableViewState();
}

class _TableViewState extends State<TableView>
{
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Data Page"),
      ),
    );
  }
}