class DiaryEntry {
  int generalFeeling;
  bool hasSleptAlright;
  bool hasEaten;
  List<dynamic> symptoms;

  DiaryEntry({required this.generalFeeling, required this.hasSleptAlright, required this.hasEaten, required this.symptoms});

  DiaryEntry.fromJson(Map<String, dynamic> json)
      : generalFeeling = json['generalFeeling'],
        hasSleptAlright = json['hasSleptAlright'],
        hasEaten = json['hasEaten'],
        symptoms = json['symptoms'];

  Map<String, dynamic> toJson() => {'generalFeeling': generalFeeling, 'hasSleptAlright': hasSleptAlright, 'hasEaten': hasEaten, 'symptoms': symptoms};

  @override
  String toString() {
    return 'DiaryEntry{\n'
        '_generalFeeling: $generalFeeling,\n'
        '_sleepQuality: $hasSleptAlright,\n'
        '_hasEaten: $hasEaten,\n'
        '_symptoms: $symptoms}';
  }
}
