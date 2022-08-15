import 'package:dictionaryx/src/classes.dart';
import 'package:dictionaryx/src/dict_msa.dart';

/// Complete dictionary with meanings, synonyms and antonyms.
class DictionaryMSA extends DictionaryAbs {
  // Does the dictionary list the word.
  static bool hasEntry(String word) => DictMSA.hasEntry(word);
  // Returns the entry for the given word.
  static DictEntry getEntry(String word) {
    List<DictEntryMeaning> explanations =
        DictMSA.getMeanings(word).map<DictEntryMeaning>((meaning) {
      var pos = DictionaryAbs.getPos(meaning[0]!);
      return DictEntryMeaning(pos, meaning[1], List<String>.from(meaning[2]),
          List<String>.from(meaning[3]));
    }).toList();

    return DictEntry(word, explanations, DictMSA.getSynonyms(word),
        DictMSA.getAntonyms(word));
  }

  // Returns the number of word-entries of the dictionary.
  static int length() => DictMSA.length();
}
