enum AnbocasStatus {
  published('PUBLISHED'),
  unpublished('UNPUBLISHED'),
  draft('DRAFT'),
  notCheckedIn('NOT_CHECKED_IN'),
  deleted('DELETED');

  final String value;

  const AnbocasStatus(this.value);

  factory AnbocasStatus.fromValue(value) {
    return values.firstWhere((element) => element.value == value);
  }
}
