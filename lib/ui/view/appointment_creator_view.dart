import 'package:feelin/ui/enums/diary_data.dart';
import 'package:feelin/ui/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';

class AppointmentCreatorView {
  static Future<void> showAppointmentDialog(BuildContext context, HomeViewModel model) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Enter Mood Details"),
              content: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(children: [
                      Column(children: [
                        Text("General feelings"),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                          IconButton(
                              onPressed: () => setState(() => model.collectDiaryData(DiaryData.GENERAL_FEELING, 1)),
                              icon: Icon(
                                Icons.adjust,
                                color: model.retrieveSpecificDiaryData(DiaryData.GENERAL_FEELING, null) == 1 ? Colors.red : Colors.grey,
                              )),
                          IconButton(
                              onPressed: () => setState(() => model.collectDiaryData(DiaryData.GENERAL_FEELING, 2)),
                              icon: Icon(
                                Icons.adjust,
                                color: model.retrieveSpecificDiaryData(DiaryData.GENERAL_FEELING, null) == 2 ? Colors.amber : Colors.grey,
                              )),
                          IconButton(
                              onPressed: () => setState(() => model.collectDiaryData(DiaryData.GENERAL_FEELING, 3)),
                              icon: Icon(
                                Icons.adjust,
                                color: model.retrieveSpecificDiaryData(DiaryData.GENERAL_FEELING, null) == 3 ? Colors.yellow : Colors.grey,
                              )),
                          IconButton(
                              onPressed: () => setState(() => model.collectDiaryData(DiaryData.GENERAL_FEELING, 4)),
                              icon: Icon(
                                Icons.adjust,
                                color: model.retrieveSpecificDiaryData(DiaryData.GENERAL_FEELING, null) == 4 ? Colors.lightGreen : Colors.grey,
                              )),
                          IconButton(
                              onPressed: () => setState(() => model.collectDiaryData(DiaryData.GENERAL_FEELING, 5)),
                              icon: Icon(
                                Icons.adjust,
                                color: model.retrieveSpecificDiaryData(DiaryData.GENERAL_FEELING, null) == 5 ? Colors.green : Colors.grey,
                              )),
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
                                    onPressed: () => setState(() => model.collectDiaryData(DiaryData.SLEEP_QUALITY, false)),
                                    icon: Icon(
                                      Icons.warning_amber_outlined,
                                      color: !model.retrieveSpecificDiaryData(DiaryData.SLEEP_QUALITY, null) ? Colors.red : Colors.grey,
                                    )),
                                IconButton(
                                    onPressed: () => setState(() => model.collectDiaryData(DiaryData.SLEEP_QUALITY, true)),
                                    icon: Icon(
                                      Icons.check,
                                      color: model.retrieveSpecificDiaryData(DiaryData.SLEEP_QUALITY, null) ? Colors.green : Colors.grey,
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
                                    onPressed: () => setState(() => model.collectDiaryData(DiaryData.HAS_EATEN, false)),
                                    icon: Icon(
                                      Icons.warning_amber_outlined,
                                      color: !model.retrieveSpecificDiaryData(DiaryData.HAS_EATEN, null) ? Colors.red : Colors.grey,
                                    )),
                                IconButton(
                                    onPressed: () => setState(() => model.collectDiaryData(DiaryData.HAS_EATEN, true)),
                                    icon: Icon(
                                      Icons.check,
                                      color: model.retrieveSpecificDiaryData(DiaryData.HAS_EATEN, null) ? Colors.green : Colors.grey,
                                    )),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    Column(
                        children: List.generate(model.symptoms.length, (index) {
                      return ChoiceChip(
                          label: Text(model.symptoms[index].toString()),
                          selected: model.symptoms[index].isSelected,
                          onSelected: (bool newValue) =>
                            setState(() =>
                              model.symptoms[index].isSelected = newValue
                            )
                          );
                    })),
                    ElevatedButton(
                      onPressed: () {
                        model.createOrUpdateDiaryEntry();
                        Navigator.pop(context);
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
