enum AnbocasEventStatus {
  published('PUBLISHED'),
  unpublished('UNPUBLISHED'),
  draft('DRAFT'),
  notCheckedIn('NOT_CHECKED_IN'),
  deleted('DELETED');

  final String value;

  const AnbocasEventStatus(this.value);

  factory AnbocasEventStatus.fromValue(value) {
    return values.firstWhere((element) => element.value == value);
  }
}
