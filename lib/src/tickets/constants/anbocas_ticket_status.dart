enum AnbocasTicketStatus {
  available('AVAILABLE'),
  unavailable('UNAVAILABLE'),
  outOfStock('OUT_OF_STOCK');

  final String value;

  const AnbocasTicketStatus(this.value);

  factory AnbocasTicketStatus.fromValue(value) {
    return values.firstWhere(
      (element) => element.value == value,
    );
  }
}
