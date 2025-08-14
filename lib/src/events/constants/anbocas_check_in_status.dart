enum AnbocasCheckInStatus {
  checkedIn('CHECKED_IN'),
  notCheckedIn('NOT_CHECKED_IN');

  final String value;

  const AnbocasCheckInStatus(this.value);

  factory AnbocasCheckInStatus.fromValue(value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => notCheckedIn,
    );
  }
}
