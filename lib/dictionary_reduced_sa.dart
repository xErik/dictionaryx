import 'package:dictionaryx/dictentry.dart';
import 'package:dictionaryx/src/dict_abstract.dart';
import 'package:dictionaryx/src/dict_reduced_sa.dart';

/// Dictionary with limited words, only synonyms and antonyms.
class DictionaryReducedSA extends DictionaryAbs {
  /// Does the dictionary list the word.
  bool hasEntry(String word) => DictReducedSA.hasEntry(word);

  /// Returns the entry for the given word.
  DictEntry getEntry(String word) {
    return DictEntry.noMeaning(
        word, DictReducedSA.getSynonyms(word), DictReducedSA.getAntonyms(word));
  }

  /// Returns the number of word-entries of the dictionary.
  int length() => DictReducedSA.length();
}
