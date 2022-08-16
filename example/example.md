```dart
import 'package:dictionaryx/dictionary_msa.dart';
import 'package:dictionaryx/dictionary_reduced_msa.dart';
import 'package:dictionaryx/dictionary_reduced_sa.dart';
import 'package:dictionaryx/dictionary_sa.dart';

void main() {
// Lookup an entry with synonyms and antonyms, only.

  var dReducedSA = DictionaryReducedSA();
  var dReducedMSA = DictionaryReducedMSA();

  var dSA = DictionarySA();
  var dMSA = DictionaryMSA();

  print(dReducedSA.hasEntry('assafef')); // false
  print(dReducedSA.hasEntry('meeting')); // true

  var entry = dReducedSA.getEntry('meeting');
  print(entry.word); // meeting
  print(entry.synonyms); // [Assemble, Contact, Adjoin, Forgather, See]
  print(entry.antonyms); // [diverge]

// Lookup an entry with its meanings.
// A meaning-object comes with a list of optional explanations
// and a list of optional contextual-meanings.

  entry = dReducedMSA.getEntry('meeting');
  print(entry.word); // meeting
  print(entry.synonyms); // [Assemble, Contact, Adjoin, Forgather, See]
  print(entry.antonyms); // [diverge]

  // An meaning comes with a POS, description
  // and optional contextual-meanings and optional examples.

  print(entry.meanings.first.pos); // POS.NOUN
  print(entry.meanings.first.description); // a formally arranged gathering

  print(entry.meanings.first.hasMeanings()); // true
  print(entry.meanings.first.hasExamples()); // true

  print(entry.meanings.first.meanings.first); // Gathering
  print(entry.meanings.first.examples.first); //"next year the meeting (...)

// In the same manner, the complete dictionary can be accessed.
// Compared to the reduced dictionary, the complete dictionary has
// a larger memory footprint.

  // Smaller memory footprint, with no meanings.
  entry = dSA.getEntry('tree');

  // Larger memory footprint, with meanings.
  entry = dMSA.getEntry('tree');
}
```