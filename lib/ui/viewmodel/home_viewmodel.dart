import 'package:feelin/locator.dart';
import 'package:feelin/models/diary_entry_model.dart';
import 'package:feelin/models/symptom_model.dart';
import 'package:feelin/services/local_storage_service.dart';
import 'package:feelin/ui/datasource/meeting_datasource.dart';
import 'package:feelin/ui/enums/diary_data.dart';
import 'package:feelin/ui/view/appointment_creator_view.dart';
import 'package:feelin/ui/viewmodel/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomeViewModel extends BaseViewModel {
  final LocalStorageService _localStorageService = locator<LocalStorageService>();

  // Store all possible symptoms
  late List<Symptom> _symptoms;

  List<Symptom> get symptoms => _symptoms;

  // Determine which page/view is currently shown
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  // Calendar DataSource
  late CalendarDataSource _calendarDataSource;

  CalendarDataSource get calendarDataSource => _calendarDataSource;

  // Selected Calendar Date
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  set selectedDate(DateTime dateTime) {
    _selectedDate = dateTime;
    notifyListeners();
  }

  // Diary entry data
  int _generalFeeling = 0;
  bool _hasSleptAlright = false;
  bool _hasEaten = false;

  HomeViewModel() {
    _calendarDataSource = MeetingDataSource(_getInitialAppointments());
    _symptoms = Symptom.getAllSymptoms();
  }

  void collectDiaryData(DiaryData diaryData, dynamic update) {
    switch (diaryData) {
      case DiaryData.GENERAL_FEELING:
        _generalFeeling = update;
        break;
      case DiaryData.SLEEP_QUALITY:
        _hasSleptAlright = update;
        break;
      case DiaryData.HAS_EATEN:
        _hasEaten = update;
        break;
    }

    notifyListeners();
  }

  dynamic retrieveSpecificDiaryData(DiaryData diaryData, String? symptomName) {
    switch (diaryData) {
      case DiaryData.GENERAL_FEELING:
        return _generalFeeling;
      case DiaryData.SLEEP_QUALITY:
        return _hasSleptAlright;
      case DiaryData.HAS_EATEN:
        return _hasEaten;
    }
  }

  void createOrUpdateAppointment(dynamic context) {
    var diaryEntry = _localStorageService.getSpecificDiaryEntry(DateFormat('yyyyMMdd').format(_selectedDate));
    if (diaryEntry != null) {
      _generalFeeling = diaryEntry.generalFeeling;
      _hasSleptAlright = diaryEntry.hasSleptAlright;
      _hasEaten = diaryEntry.hasEaten;
      _symptoms = Symptom.getAllSymptoms();

      for (Symptom symptom in _symptoms) {
        if (diaryEntry.symptoms.contains(symptom.name)) {
          symptom.isSelected = true;
        }
      }
    }

    AppointmentCreatorView.showAppointmentDialog(context, this);
  }

  void createOrUpdateDiaryEntry() {
    var diaryEntry = _localStorageService.getSpecificDiaryEntry(DateFormat('yyyyMMdd').format(_selectedDate));
    if (diaryEntry != null) {
      _localStorageService.removeDiaryEntry(DateFormat('yyyyMMdd').format(_selectedDate));
      Appointment? toBeRemovedAppointment;
      _calendarDataSource.appointments!.forEach((appointment) {
        if (appointment.startTime == _selectedDate) {
          toBeRemovedAppointment = appointment;
        }
      });
      _calendarDataSource.appointments?.removeAt(_calendarDataSource.appointments!.indexOf(toBeRemovedAppointment));
      _calendarDataSource.notifyListeners(CalendarDataSourceAction.remove, <Appointment>[]..add(toBeRemovedAppointment!));
    }

    final List<String> selectedSymptoms = [];
    for (var symptom in _symptoms) {
      if (symptom.isSelected) {
        selectedSymptoms.add(symptom.toString());
      }
    }

    diaryEntry =
        DiaryEntry(generalFeeling: _generalFeeling, hasSleptAlright: _hasSleptAlright, hasEaten: _hasEaten, symptoms: selectedSymptoms);

    _localStorageService.saveDiaryEntry(_selectedDate, diaryEntry);

    Appointment appointment =
        Appointment(startTime: _selectedDate, endTime: _selectedDate, isAllDay: true, subject: diaryEntry.toString(), color: Colors.pinkAccent);

    _calendarDataSource.appointments?.add(appointment);
    _calendarDataSource.notifyListeners(CalendarDataSourceAction.add, <Appointment>[appointment]);

    //Reset values
    _reset();
  }

  void deleteDiaryEntry() {
    var diaryEntry = _localStorageService.getSpecificDiaryEntry(DateFormat('yyyyMMdd').format(_selectedDate));
    if (diaryEntry != null) {
      _localStorageService.removeDiaryEntry(DateFormat('yyyyMMdd').format(_selectedDate));
      Appointment? toBeRemovedAppointment;
      _calendarDataSource.appointments!.forEach((appointment) {
        if (appointment.startTime == _selectedDate) {
          toBeRemovedAppointment = appointment;
        }
      });
      _calendarDataSource.appointments?.removeAt(_calendarDataSource.appointments!.indexOf(toBeRemovedAppointment));
      _calendarDataSource.notifyListeners(CalendarDataSourceAction.remove, <Appointment>[]..add(toBeRemovedAppointment!));
    }
  }

  List<Appointment> _getInitialAppointments() {
    var appointments = <Appointment>[];

    for (var key in _localStorageService.getAllKeys()) {
      var entry = _localStorageService.getSpecificDiaryEntry(key);
      if (entry != null) {
        appointments.add(Appointment(
            startTime: DateTime.parse(key), endTime: DateTime.parse(key), isAllDay: true, subject: entry.toString(), color: Colors.pinkAccent));
      }
    }

    return appointments;
  }

  void _reset() {
    _generalFeeling = 0;
    _hasSleptAlright = false;
    _hasEaten = false;
    _symptoms = Symptom.getAllSymptoms();
  }
}
