enum OptKey {
  usePatternAsLockMethod,
  useFingerprintAsLockMethod,
}

extension ParseToString on OptKey {
  String toShortString() {
    return toString().split('.').last;
  }
}
