/// Represents the types of absences.
enum AbsenceType {
  sickness,
  vacation,
}

/// A mixin providing helper methods related to [AbsenceType].
mixin AbsenceTypeHelper {
  /// Returns a list of string representations of [AbsenceType].
  static List<String> getStrings() {
    return AbsenceType.values.map((e) => e.name.toUpperCase()).toList();
  }
}
