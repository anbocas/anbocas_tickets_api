enum AnbocasCompanyStatus {
  active('ACTIVE');

  final String value;

  const AnbocasCompanyStatus(this.value);

  factory AnbocasCompanyStatus.fromValue(value) {
    return values.firstWhere(
      (element) => element.value == value,
    );
  }
}
