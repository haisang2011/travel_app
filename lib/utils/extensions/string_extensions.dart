extension StringExtensions on String {
  String? firstWord() {
    final firstSpaceIndex = indexOf(' ');
    if (firstSpaceIndex > -1) {
      return substring(0, firstSpaceIndex);
    }
    return null;
  }
}
