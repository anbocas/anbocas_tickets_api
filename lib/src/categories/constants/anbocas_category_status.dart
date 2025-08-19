enum AnbocasCategoryStatus {
  active('ACTIVE');

  final String value;

  const AnbocasCategoryStatus(this.value);

  factory AnbocasCategoryStatus.fromValue(value) {
    return values.firstWhere(
      (element) => element.value == value,
    );
  }
}
