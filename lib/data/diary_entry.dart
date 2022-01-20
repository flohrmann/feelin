import 'symptom.dart';

class DiaryEntry {
  int _id;
  int _generalFeeling;
  bool _sleepQuality;
  bool _hasEaten;
  List<Symptom> _symptoms;

  DiaryEntry(
      this._generalFeeling, this._sleepQuality, this._hasEaten, this._symptoms);

  int get generalFeeling => _generalFeeling;

  bool get sleepQuality => _sleepQuality;

  bool get hasEaten => _hasEaten;

  List<Symptom> get symptoms => _symptoms;

  @override
  String toString() {
    return 'DiaryEntry{\n'
        '_generalFeeling: $_generalFeeling,\n'
        '_sleepQuality: $_sleepQuality,\n'
        '_hasEaten: $_hasEaten,\n'
        '_symptoms: $_symptoms}';
  }
}