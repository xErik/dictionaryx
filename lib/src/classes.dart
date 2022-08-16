/// Part-Of-Speach.
enum POS { NOUN, VERB, ADJ, ADV }

/// Part of `DictEntry`. Created internally.
class DictEntryMeaning {
  /// Part-Of_Speach.
  POS pos;

  /// Sentence describing the `word` of DictEntry.
  String description;

  /// List of meanings describing the context.
  List<String> meanings;

  /// Whether the meanings are ampty.
  bool hasMeanings() => meanings.isNotEmpty;

  /// Examples illustrsting the meaning.
  List<String> examples;

  /// Whether the examples are ampty.
  bool hasExamples() => examples.isNotEmpty;

  DictEntryMeaning(this.pos, this.description, this.meanings, this.examples);

  /// String representation of class.
  @override
  String toString() {
    return '[${pos.name} "$description" $meanings $examples]';
  }
}

/// Returned result. Created internally. `meaning` may be null to safe memory and one
/// is only interested in synonyms and antonyms.
class DictEntry {
  /// The meaning of the `word`.
  List<DictEntryMeaning> meanings = [];

  /// The entry looked-up.
  String word;

  /// List short synonyms.
  List<String> synonyms = [];

  /// List short antonyms.
  List<String> antonyms = [];
  DictEntry(this.word, this.meanings, this.synonyms, this.antonyms);
  DictEntry.noMeaning(this.word, this.synonyms, this.antonyms);

  /// Whether the `DictEntryMeaning` object is null or not.
  bool hasExplanations() => meanings.isNotEmpty;

  /// String representation of class.
  @override
  String toString() {
    return 'WORD:$word \nEXPL:$meanings \nSYN:$synonyms\nANT:$antonyms';
  }
}

/// Abstract helper class.
abstract class DictionaryAbs {
  /// Maps a string to POS-enum.
  POS getPos(String str) {
    var pos = POS.NOUN;
    switch (str) {
      case 'Verb':
        pos = POS.VERB;
        break;
      case 'Adjective':
        pos = POS.ADJ;
        break;
      case 'Adverb':
        pos = POS.ADV;
        break;
    }
    return pos;
  }
}
