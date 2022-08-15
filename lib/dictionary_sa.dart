import 'package:dictionaryx/src/classes.dart';
import 'package:dictionaryx/src/dict_sa.dart';

/// Complete dictionary with synonyms and antonyms.
class DictionarySA extends DictionaryAbs {
  // Does the dictionary list the word.
  static bool hasEntry(String word) => DictSA.hasEntry(word);
  // Returns the entry for the given word.
  static DictEntry getEntry(String word) {
    return DictEntry.noMeaning(
        word, DictSA.getSynonyms(word), DictSA.getAntonyms(word));
  }

  // Returns the number of word-entries of the dictionary.
  static int length() => DictSA.length();
}
