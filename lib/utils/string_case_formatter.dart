class StringCaseFormatter {
  static final RegExp _upperAlphaRegex = new RegExp(r'[A-Z]');
  static final RegExp _symbolRegex = new RegExp(r'[ ./_\-]');

  static String className(String text) {
    return pascalCase(text);
  }

  static String pascalCase(String text, {String separator: ''}) {
    return _pascalCase(groupIntoWords(text), separator: separator);
  }

  static String snakeCase(String text, {String separator: '_'}) {
    return _snakeCase(groupIntoWords(text), separator: separator);
  }

  static String camelCase(String text, {String separator: ''}) {
    return _camelCase(groupIntoWords(text), separator: separator);
  }

  static String constantCase(String text, {String separator: ''}) {
    return _constantCase(groupIntoWords(text), separator: separator);
  }

  static String lowerCaseFirstLetter(String text, {bool upperCaseRest = true}) {
    return '${text.substring(0, 1).toLowerCase()}${upperCaseRest ? text.substring(1).toUpperCase() : text.substring(1)}';
  }

  static String upperCaseFirstLetter(String text, {bool lowerCaseRest = true}) {
    return '${text.substring(0, 1).toUpperCase()}${lowerCaseRest ? text.substring(1).toLowerCase() : text.substring(1)}';
  }

  static String _pascalCase(List<String> words, {String separator: ''}) {
    return words.map(upperCaseFirstLetter).join(separator);
  }

  static String _snakeCase(List<String> words, {String separator: '_'}) {
    return words.map((word) => word.toLowerCase()).join(separator);
  }

  static String _camelCase(List<String> words, {String separator: ''}) {
    List<String> _words = words;
    _words[0] = _words[0].toLowerCase();
    return _words.join(separator);
  }

  static String _constantCase(List<String> words, {String separator: '_'}) {
    return words.map((word) => word.toUpperCase()).join(separator);
  }

  static List<String> groupIntoWords(String text) {
    if (text == null || text.isEmpty) return [''];

    StringBuffer sb = new StringBuffer();
    List<String> words = [];
    bool isAllCaps = !text.contains(RegExp('[a-z]'));

    for (int i = 0; i < text.length; i++) {
      String char = new String.fromCharCode(text.codeUnitAt(i));
      String nextChar = (i + 1 == text.length
          ? null
          : new String.fromCharCode(text.codeUnitAt(i + 1)));

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
