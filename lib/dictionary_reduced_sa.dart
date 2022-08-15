import 'package:dictionaryx/src/classes.dart';
import 'package:dictionaryx/src/dict_reduced_sa.dart';

/// Dictionary with limited words, only synonyms and antonyms.
class DictionaryReducedSA extends DictionaryAbs {
  // Does the dictionary list the word.
  static bool hasEntry(String word) => DictReducedSA.hasEntry(word);
  // Returns the entry for the given word.
  static DictEntry getEntry(String word) {
    return DictEntry.noMeaning(
        word, DictReducedSA.getSynonyms(word), DictReducedSA.getAntonyms(word));
  }

  // Returns the number of word-entries of the dictionary.
  static int length() => DictReducedSA.length();
}
