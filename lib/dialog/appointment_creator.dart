import 'package:flutter/material.dart';
import 'package:myflutterapp/data/diary_entry.dart';
import 'package:myflutterapp/data/symptom.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentCreator {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<Symptom> symptoms = Symptom.getAllSymptoms();
  int _feelingRating = 0;
  bool _sleepQuality = false;
  bool _hasEaten = false;

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
                    Row(children: [
                      Column(children: [
                        Text("General feelings"),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _feelingRating = 1;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.adjust,
                                    color: _feelingRating == 1
                                        ? Colors.red
                                        : Colors.grey,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _feelingRating = 2;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.adjust,
                                    color: _feelingRating == 2
                                        ? Colors.amber
                                        : Colors.grey,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _feelingRating = 3;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.adjust,
                                    color: _feelingRating == 3
                                        ? Colors.yellow
                                        : Colors.grey,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _feelingRating = 4;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.adjust,
                                    color: _feelingRating == 4
                                        ? Colors.lightGreen
                                        : Colors.grey,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _feelingRating = 5;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.adjust,
                                    color: _feelingRating == 5
                                        ? Colors.green
                                        : Colors.grey,
                                  ))
                            ])
                      ])
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text("Sleep Quality"),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _sleepQuality = false;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.warning_amber_outlined,
                                      color: _sleepQuality == false
                                          ? Colors.red
                                          : Colors.grey,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _sleepQuality = true;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.check,
                                      color: _sleepQuality == true
                                          ? Colors.green
                                          : Colors.grey,
                                    )),
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text("Food intake"),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _hasEaten = false;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.warning_amber_outlined,
                                      color: _hasEaten == false
                                          ? Colors.red
                                          : Colors.grey,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _hasEaten = true;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.check,
                                      color: _hasEaten == true
                                          ? Colors.green
                                          : Colors.grey,
                                    )),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        ChoiceChip(
                          label: Text(symptoms[0].toString()),
                          selected: symptoms[0].isSelected,
                          onSelected: (bool newValue) {
                            setState(() {
                              symptoms[0].isSelected = newValue;
                            });
                          },
                        ),
                        ChoiceChip(
                          label: Text(symptoms[1].toString()),
                          selected: symptoms[1].isSelected,
                          onSelected: (bool newValue) {
                            setState(() {
                              symptoms[1].isSelected = newValue;
                            });
                          },
                        )
                      ],
                    ),
                    Row(
                      children: [
                        ChoiceChip(
                          label: Text(symptoms[2].toString()),
                          selected: symptoms[2].isSelected,
                          onSelected: (bool newValue) {
                            setState(() {
                              symptoms[2].isSelected = newValue;
                            });
                          },
                        ),
                        ChoiceChip(
                          label: Text(symptoms[3].toString()),
                          selected: symptoms[3].isSelected,
                          onSelected: (bool newValue) {
                            setState(() {
                              symptoms[3].isSelected = newValue;
                            });
                          },
                        )
                      ],
                    ),
                    Row(
                      children: [
                        ChoiceChip(
                          label: Text(symptoms[4].toString()),
                          selected: symptoms[4].isSelected,
                          onSelected: (bool newValue) {
                            setState(() {
                              symptoms[4].isSelected = newValue;
                            });
                          },
                        ),
                        ChoiceChip(
                            label: Text(symptoms[5].toString()),
                            selected: symptoms[5].isSelected,
                            onSelected: (bool newValue) {
                              setState(() {
                                symptoms[5].isSelected = newValue;
                              });
                            })
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          symptoms
                              .removeWhere((element) => !element.isSelected);
                          DiaryEntry diaryEntry =
                          new DiaryEntry(_feelingRating, _sleepQuality, _hasEaten, symptoms);
                          Appointment appointment = Appointment(
                              startTime: currentDate,
                              isAllDay: true,
                              subject: diaryEntry.toString(),
                              color: Colors.pinkAccent);

                          calendarDataSource.appointments?.add(appointment);
                          calendarDataSource.notifyListeners(
                              CalendarDataSourceAction.add,
                              <Appointment>[appointment]);
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

  void onFeelingPressed(int feelingRating) {
    _feelingRating = feelingRating;
  }
}