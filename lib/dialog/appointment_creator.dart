import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentCreator {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _moodEditingController = TextEditingController();

  TimeOfDay _startTimeOfDay = TimeOfDay.now();
  TimeOfDay _endTimeOfDay = TimeOfDay.now();

  String moodValidator(String value) {
    if (value == null || value.trim() == '') {
      return 'Please add your mood';
    }

    return null;
  }

  Future<void> showAppointmentDialog(BuildContext context,
      CalendarDataSource calendarDataSource, DateTime currentDate) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Enter Mood Details"),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _moodEditingController,
                      decoration: const InputDecoration(hintText: "Enter mood"),
                      validator: moodValidator,
                    ),
                    ListTile(
                        onTap: () async {
                          var res = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(currentDate)
                          );
                          if (res != null) {
                            setState(() {
                              _startTimeOfDay = res;
                            });
                          }
                        },
                        title: const Text('Start time of mood'),
                        subtitle: Text(_startTimeOfDay?.format(context))
                    ),
                    ListTile(
                        onTap: () async {
                          var res = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(currentDate)
                          );
                          if (res != null) {
                            setState(() {
                              _endTimeOfDay = res;
                            });
                          }
                        },
                        title: const Text('End time of mood'),
                        subtitle: Text(_endTimeOfDay?.format(context))
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Appointment appointment = Appointment(
                              startTime: DateTime(
                                  currentDate.year, currentDate.month,
                                  currentDate.day, _startTimeOfDay.hour,
                                  _startTimeOfDay.minute),
                              endTime: DateTime(
                                  currentDate.year, currentDate.month,
                                  currentDate.day, _endTimeOfDay.hour,
                                  _endTimeOfDay.minute),
                              subject: _moodEditingController.text.trim(),
                              color: Colors.pinkAccent
                          );

                          calendarDataSource.appointments?.add(appointment);
                          calendarDataSource.notifyListeners(
                              CalendarDataSourceAction.add,
                              <Appointment>[appointment]
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Confirm",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}