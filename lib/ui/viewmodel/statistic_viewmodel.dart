import 'package:feelin/locator.dart';
import 'package:feelin/services/local_storage_service.dart';
import 'package:feelin/ui/viewmodel/base_viewmodel.dart';

class StatisticViewModel extends BaseViewModel {
  static final String daysTracked = 'days tracked';

  final LocalStorageService _localStorageService = locator<LocalStorageService>();

  String _totalDaysRegistered = '0/31\n$daysTracked';

  String get totalDaysRegistered => _totalDaysRegistered;

  double calculateDaysRegistered() {
    var today = DateTime.now();
    var totalDaysThisMonth = _daysInMonth(today.month, today.year);
    var totalRegisteredEntries = 0;

    for (var key in _localStorageService.getAllKeys()) {
      var entryDate = DateTime.parse(key);

      if (entryDate.month == today.month) {
        totalRegisteredEntries++;
      }
    }

    _totalDaysRegistered = '$totalRegisteredEntries / $totalDaysThisMonth\n$daysTracked';

    return totalRegisteredEntries / totalDaysThisMonth;
  }

  String calculateAverageMood() {
    var today = DateTime.now();
    var totalRegisteredEntries = 0;
    var totalRegisteredMood = 0;

    for (var key in _localStorageService.getAllKeys()) {
      var entryDate = DateTime.parse(key);

      if (entryDate.month == today.month) {
        var diaryEntry = _localStorageService.getSpecificDiaryEntry(key);
        if (diaryEntry != null) {
          totalRegisteredEntries++;
          totalRegisteredMood += diaryEntry.generalFeeling;
        }
      }
    }
    var averageMood = (totalRegisteredMood / totalRegisteredEntries).toStringAsFixed(1);

    return '$averageMood / 5';
  }

  String calculateMostCommonlyUsedSymptom() {
    var today = DateTime.now();
    Map<String, int> commonlyUsedSymptom = Map();

    for (var key in _localStorageService.getAllKeys()) {
      var entryDate = DateTime.parse(key);

      if (entryDate.month == today.month) {
        var diaryEntry = _localStorageService.getSpecificDiaryEntry(key);
        if (diaryEntry != null) {
          for (String symptom in diaryEntry.symptoms) {
            if (commonlyUsedSymptom.containsKey(symptom)) {
              commonlyUsedSymptom.update(symptom, (value) => ++value);
            } else {
              commonlyUsedSymptom.putIfAbsent(symptom, () => 1);
            }
          }
        }
      }
    }

    var sortedCommonlyUsedSymptom = Map.fromEntries(commonlyUsedSymptom.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value)));

    return sortedCommonlyUsedSymptom.keys.first;
  }

  int _daysInMonth(final int monthNum, final int year) {
    List<int> monthLength = List.filled(12, 0);

    monthLength[0] = 31;
    monthLength[2] = 31;
    monthLength[4] = 31;
    monthLength[6] = 31;
    monthLength[7] = 31;
    monthLength[9] = 31;
    monthLength[11] = 31;
    monthLength[3] = 30;
    monthLength[8] = 30;
    monthLength[5] = 30;
    monthLength[10] = 30;

    if (_isLeapYear(year))
      monthLength[1] = 29;
    else
      monthLength[1] = 28;

    return monthLength[monthNum - 1];
  }

  bool _isLeapYear(int year) {
    bool leapYear = false;

    bool leap = ((year % 100 == 0) && (year % 400 != 0));
    if (leap == true)
      leapYear = false;
    else if (year % 4 == 0) leapYear = true;

    return leapYear;
  }
}
