import 'dart:convert';

import 'package:dictionaryx/dictentry.dart';
import 'package:dictionaryx/src/dict_abstract.dart';
import 'package:dictionaryx/src/dictassets.dart';

/// Helper class
abstract class AbstractAssetFileFetcherService {
  Future<String> getAssetFileContent(String assetName);
}

AbstractAssetFileFetcherService? service;

/// Complete dictionary with meanings, synonyms and antonyms.
class DictionaryMSAJsonFlutter extends DictionaryAbs {
  String _currentWord = '';
  Map<String, dynamic> _currentJson = {};

  String _resolveAsset(String word) {
    var asset = DictAssets.dictAssets
        .lastWhere((ast) => word.compareTo(ast) >= 0, orElse: () => '');

    if (asset.isEmpty) {
      throw 'No asset file found for word: $word';
    }
    return asset;
  }

  Future<Map<String, dynamic>> _getAssetBundleFor(String word) async {
    if (word == _currentWord) {
      return _currentJson;
    }
    String asset = _resolveAsset(word);
    // _currentJson =
    //     jsonDecode(File('./lib/assets/$asset.json').readAsStringSync());
    // _currentJson = jsonDecode(await rootBundle.loadString('$asset.json'));

    _currentJson =
        jsonDecode(await service!.getAssetFileContent('$asset.json'));
    // _currentJson = jsonDecode(await rootBundle.loadString('$asset.json'));
    _currentWord = word;
    return _currentJson;
  }

  Future<Map<String, dynamic>> _getAssetEntry(String word) async {
    return (await _getAssetBundleFor(word))[word];
  }

  /// Does the dictionary list the word.
  Future<bool> hasEntry(String word) async {
    return (await _getAssetBundleFor(word)).containsKey(word);
  }

  // /// Returns the entry for the given word.
  Future<DictEntry> getEntry(String word) async {
    final assetEntry = await _getAssetEntry(word);

    List<DictEntryMeaning> explanations =
        assetEntry['M'].map<DictEntryMeaning>((meaning) {
      var pos = getPos(meaning[0]!);
      return DictEntryMeaning(pos, meaning[1], List<String>.from(meaning[2]),
          List<String>.from(meaning[3]));
    }).toList();

    return DictEntry(word, explanations, List<String>.from(assetEntry['S']),
        List<String>.from(assetEntry['A']));
  }

  // /// Returns the number of word-entries of the dictionary.
  Future<int> length() async {
    var ret = 0;
    for (var asset in DictAssets.dictAssets) {
      ret += (await _getAssetBundleFor(asset)).keys.length;
    }
    return ret;
  }
}
