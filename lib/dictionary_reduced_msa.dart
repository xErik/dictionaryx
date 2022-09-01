import 'package:dictionaryx/dictentry.dart';
import 'package:dictionaryx/src/dict_abstract.dart';
import 'package:dictionaryx/src/dict_reduced_msa.dart';

/// Dictionary with limited words, meanings, synonyms and antonyms.
class DictionaryReducedMSA extends DictionaryAbs {
  /// Does the dictionary list the word.
  bool hasEntry(String word) => DictReducedMSA.hasEntry(word);

  /// Returns the entry for the given word.
  DictEntry getEntry(String word) {
    List<DictEntryMeaning> explanations =
        DictReducedMSA.getMeanings(word).map<DictEntryMeaning>((meaning) {
      var pos = getPos(meaning[0]!);
      return DictEntryMeaning(pos, meaning[1], List<String>.from(meaning[2]),
          List<String>.from(meaning[3]));
    }).toList();

    return DictEntry(word, explanations, DictReducedMSA.getSynonyms(word),
        DictReducedMSA.getAntonyms(word));
  }

  /// Returns the number of word-entries of the dictionary.
  int length() => DictReducedMSA.length();
}
