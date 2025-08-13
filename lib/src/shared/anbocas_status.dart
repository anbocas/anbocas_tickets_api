enum AnbocasStatus {
  published('PUBLISHED'),
  unpublished('UNPUBLISHED'),
  draft('DRAFT'),
  deleted('DELETED');

  final String value;

  const AnbocasStatus(this.value);
}
