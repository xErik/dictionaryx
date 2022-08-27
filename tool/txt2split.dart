import 'dart:convert';
import 'dart:io';

final json = readJsonFile('./tool/defs/wordnet-data-merged.json');
final outDir = Directory('./lib/assets/');

/// Split tool/defs/wordnet-data-merged into small json files: lib/assets/[a-z].json
///
/// dart run .\tool\txt2split.dart
///
void main() {
  Directory(outDir.path).deleteSync(recursive: true);
  Directory(outDir.path).createSync();

  createFiles(100);

  // dict(Directory('./lib/assets/'));
}

/// Helper function.
Map<String, dynamic> readJsonFile(String filePath) {
  var input = File(filePath).readAsStringSync();
  return (jsonDecode(input) as Map<String, dynamic>);
}

void createFiles(int entriesPerFile, {includeMeaning = true}) {
  List<String> keys = [...json.keys];
  keys.sort();

  List<String> fileNames = [];

  outer:
  for (var index = 0; index < keys.length; index += entriesPerFile) {
    final result = {};

    for (var i = 0; i < entriesPerFile; i++) {
      final indexCombined = i + index;
      if (indexCombined > keys.length - 1) {
        break outer;
      }
      var key = keys.elementAt(indexCombined);
      final antonyms = json[key]!['ANTONYMS'];
      final synonyms = json[key]!['SYNONYMS'];
      final meanings = json[key]!['MEANINGS'];

      result[key.toLowerCase()] = {
        if (includeMeaning) 'M': meanings,
        'S': synonyms,
        'A': antonyms,
      };
    }
    var outJson = jsonEncode(result);
    // out = out.replaceAll('\$', '\\\$');

    List<String> tmp = [...result.keys];
    tmp.sort();
    String name = tmp.first.toString();

    fileNames.add(name);
    final file = '${outDir.path}/$name.json';
    if (File(file).existsSync()) {
      throw 'File exists: $file';
    }
    File(file).writeAsStringSync(outJson);
    print(file);
  }

  var out = '''class DictAssets {
static final dictAssets = ${jsonEncode(fileNames)};
}
''';

  File('./lib/src/dictassets.dart').writeAsStringSync(out);
}
