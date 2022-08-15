import 'dart:convert';
import 'dart:io';

final wordRE = RegExp(r'\[([\w- ]+)\]');
final json = readJsonFile('./tool/defs/wordnet-data-merged.json');

/// Combines tool/defs/* into dart files: lib/src/*.dart
///
/// dart run .\tool\txt2dart.dart
///
void main() {
  dictreduced('DictReducedMSA', './lib/src/dict_reduced_msa.dart');
  dictreduced('DictReducedSA', './lib/src/dict_reduced_sa.dart',
      includeMeaning: false);

  dict('DictMSA', './lib/src/dict_msa.dart');
  dict('DictSA', './lib/src/dict_sa.dart', includeMeaning: false);
}

/// Helper function.
Map<String, dynamic> readJsonFile(String filePath) {
  var input = File(filePath).readAsStringSync();
  return (jsonDecode(input) as Map<String, dynamic>);
}

/// Creates reduced words dicts.
dictreduced(String name, String path, {includeMeaning = true}) {
  final result = {};

  File('./tool/defs/core-wordnet.txt').readAsLinesSync().forEach((String line) {
    final matchUpper = wordRE.firstMatch(line)!.group(1)!.toUpperCase();

    if (json.containsKey(matchUpper)) {
      final antonyms = json[matchUpper]!['ANTONYMS'];
      final synonyms = json[matchUpper]!['SYNONYMS'];
      final meanings = json[matchUpper]!['MEANINGS'];

      result[matchUpper.toLowerCase()] = {
        if (includeMeaning) 'M': meanings,
        'S': synonyms,
        'A': antonyms,
      };
    }
  });
  var out = '''class $name {
static final _dict = ${jsonEncode(result)};
static int length() => _dict.length;
static hasEntry(String word) => _dict.containsKey(word);
static getEntry(String word) => _dict[word]!;
${includeMeaning ? 'static getMeanings(String word) => _dict[word]!["M"]!;' : ''}
static List<String> getSynonyms(String word) => List<String>.from(_dict[word]!['S']!);
static List<String> getAntonyms(String word) => List<String>.from(_dict[word]!['A']!);
}
''';

  out = out.replaceAll('\$', '\\\$');

  File(path).writeAsStringSync(out);
}

/// Creates complete dicts.
dict(String name, String path, {includeMeaning = true}) {
  final result = {};

  json.keys.forEach((String key) {
    final antonyms = json[key]!['ANTONYMS'];
    final synonyms = json[key]!['SYNONYMS'];
    final meanings = json[key]!['MEANINGS'];

    result[key.toLowerCase()] = {
      if (includeMeaning) 'M': meanings,
      'S': synonyms,
      'A': antonyms,
    };
  });

  var out = '''class $name {
static final _dict = ${jsonEncode(result)};
static int length() => _dict.length;
static hasEntry(String word) => _dict.containsKey(word);
static getEntry(String word) => _dict[word]!;
${includeMeaning ? 'static getMeanings(String word) => _dict[word]!["M"]!;' : ''}
static List<String> getSynonyms(String word) => List<String>.from(_dict[word]!['S']!);
static List<String> getAntonyms(String word) => List<String>.from(_dict[word]!['A']!);
}
''';

  out = out.replaceAll('\$', '\\\$');

  File(path).writeAsStringSync(out);
}
