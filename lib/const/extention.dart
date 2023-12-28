extension ToSymbol on String {
  String get toSymbol {
    final after = substring(4, 7);
    final befor = substring(0, 3);
    return '$befor$after';
  }
}

extension ToFirstLetter on String {
  String get toFirstLetter {
    final first = substring(0, 1);
    final after = substring(1);
    return first.toUpperCase() + after;
  }
}
