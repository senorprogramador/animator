///Provides ways to convert between different string casing.
class StringCaseFormatter {
  static final RegExp _upperAlphaRegex = RegExp(r'[A-Z]');
  static final RegExp _symbolRegex = RegExp(r'[ ./_\-]');

  ///Returns [pascalCase] for classNames.
  static String className(String text) {
    return pascalCase(text);
  }

  ///Returns a pascal cased version of the input String.
  static String pascalCase(String text, {String separator = ''}) {
    return _pascalCase(groupIntoWords(text), separator: separator);
  }

  ///Returns a snake cased version of the input String.
  static String snakeCase(String text, {String separator = '_'}) {
    return _snakeCase(groupIntoWords(text), separator: separator);
  }

  ///Returns a camel cased version of the input String.
  static String camelCase(String text, {String separator = ''}) {
    return _camelCase(groupIntoWords(text), separator: separator);
  }

  ///Returns a constant cased version of the input String.
  static String constantCase(String text, {String separator = ''}) {
    return _constantCase(groupIntoWords(text), separator: separator);
  }

  ///Returns a String with first letter lower cased.
  static String lowerCaseFirstLetter(String text, {bool upperCaseRest = true}) {
    return '${text.substring(0, 1).toLowerCase()}${upperCaseRest ? text.substring(1).toUpperCase() : text.substring(1)}';
  }

  ///Returns a String with first letter upper cased.
  static String upperCaseFirstLetter(String text, {bool lowerCaseRest = true}) {
    return '${text.substring(0, 1).toUpperCase()}${lowerCaseRest ? text.substring(1).toLowerCase() : text.substring(1)}';
  }

  ///Private helper function for [pascalCase].
  static String _pascalCase(List<String> words, {String separator = ''}) {
    return words.map(upperCaseFirstLetter).join(separator);
  }

  ///Private helper function for [snakeCase].
  static String _snakeCase(List<String> words, {String separator = '_'}) {
    return words.map((word) => word.toLowerCase()).join(separator);
  }

  ///Private helper function for [camelCase].
  static String _camelCase(List<String> words, {String separator = ''}) {
    List<String> _words = words;
    _words[0] = _words[0].toLowerCase();
    return _words.join(separator);
  }

  ///Private helper function for [constantCase].
  static String _constantCase(List<String> words, {String separator = '_'}) {
    return words.map((word) => word.toUpperCase()).join(separator);
  }

  ///Groups a String into words based upon the defined regexps.
  static List<String> groupIntoWords(String text) {
    if (text.isEmpty) return [''];

    StringBuffer sb = StringBuffer();
    List<String> words = [];
    bool isAllCaps = !text.contains(RegExp('[a-z]'));

    for (int i = 0; i < text.length; i++) {
      String char = String.fromCharCode(text.codeUnitAt(i));
      String? nextChar = (i + 1 == text.length
          ? null
          : String.fromCharCode(text.codeUnitAt(i + 1)));

      if (_symbolRegex.hasMatch(char)) {
        continue;
      }

      sb.write(char);

      bool isEndOfWord = nextChar == null ||
          (_upperAlphaRegex.hasMatch(nextChar) && !isAllCaps) ||
          _symbolRegex.hasMatch(nextChar);

      if (isEndOfWord) {
        words.add(sb.toString());
        sb.clear();
      }
    }

    return words;
  }
}
