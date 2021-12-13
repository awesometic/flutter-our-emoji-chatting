enum OptKey {
  lockApplication,
  usePatternAsLockMethod,
  useFingerprintAsLockMethod,
}

extension ParseToString on OptKey {
  String toShortString() {
    return toString().split('.').last;
  }
}
