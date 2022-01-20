class Symptom {
  String _name;
  bool isSelected = false;

  Symptom(this._name);

  // Possibility to add more info to this.
  // If none is needed change "List<Symptoms>" in DiaryEnty to "List<String>"

  static List<Symptom> getAllSymptoms() {
    List<Symptom> symptoms = [
      new Symptom("Headache"),
      new Symptom("Nausea"),
      new Symptom("Stomach ache"),
      new Symptom("Chills"),
      new Symptom("Chest pain"),
      new Symptom("Hallucination")
    ];
    return symptoms;
  }

  @override
  String toString() {
    return _name;
  }
}