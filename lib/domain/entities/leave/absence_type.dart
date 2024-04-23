enum AbsenceType {
  sickness,
  vacation,
}
mixin AbsenceTypeHelper {
  static List<String> getStrings() {
    return AbsenceType.values.map((e) => e.name.toUpperCase()).toList();
  }
}