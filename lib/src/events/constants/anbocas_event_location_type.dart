enum AnbocasEventLocationType {
  virtual("VIRTUAL"),
  inPerson("IN_PERSON");

  const AnbocasEventLocationType(this.value);
  final String value;

  factory AnbocasEventLocationType.fromValue(value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => AnbocasEventLocationType.inPerson,
    );
  }
}
