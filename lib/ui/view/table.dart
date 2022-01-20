import 'package:flutter/material.dart';
import 'package:myflutterapp/datasource/MeetingDataSource.dart';
import 'package:myflutterapp/dialog/appointment_creator.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SettingsView extends StatefulWidget {
  SettingsView({Key key, this.title}) : super(key: key);

  final String title;

  @override

  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView>
{
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text("Settings"),
            actions: [
              PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("Home"),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: Text("Settings"),
                      value: 2,
                    )
                  ]
              )
            ],
          ),
        )
    );
  }
}