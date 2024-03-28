extension ValidateInteger on int? {
  bool isNull() => this == null;

  bool isNotNull() => this != null;

  bool isNotNullOrZero() => this != null && this != 0;
}
