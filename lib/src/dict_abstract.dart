import 'package:dictionaryx/dictentry.dart';

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
