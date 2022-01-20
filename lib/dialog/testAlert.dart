import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TestAlert {
// Show AlertDialog
  static showAlertDialog(BuildContext context, CalendarTapDetails details) {
    // Init
    AlertDialog dialog = AlertDialog(
      title: Text(details.date.toString()),
      actions: [
        ElevatedButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.pop(context);
            }
        ),
        ElevatedButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            }
        ),
      ],
    );

    // Show the dialog
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        }
    );
  }
}