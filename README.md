# dictionaryx

English dictionary with about 120000 entries, based on Wordnet. 

## Dictionaries

This package offers four precompiled and optimized `dart` versions of the same base dictionary.

Based on the selected dictionary, application startup time and memory footprint is impacted accordingly.

**DictionaryMSA** (16.4 MB)

- About 120.000 entries. Meanings, synonyms and antonyms.

**DictionarySA** (7.3 MB)

- About 120.000 entries. Synonyms and antonyms.

**DictionaryReducedMSA** (1.8 MB)

- About 3700 entries. Meanings, synonyms and antonyms.

**DictionaryReducedSA** (274 KB)

- About 3700 entries. Synonyms and antonyms.

### Outlook

The option to using the dictionaries by accessing raw text files (`assets`) will be added soon. This will decrease the memory footprint but increase lookup time by adding live parsing.

## Installing

In your pubspec.yaml:

```yaml
dependencies:
  dictionaryx: ^0.1.1
```
## How To Use

```dart
import 'package:dictionaryx/dictionary_msa.dart';
import 'package:dictionaryx/dictionary_sa.dart';
import 'package:dictionaryx/dictionary_reduced_msa.dart';
import 'package:dictionaryx/dictionary_reduced_sa.dart';

void main() {
// Lookup an entry with synonyms and antonyms, only.

  print(DictionaryReducedSA.hasEntry('assafef')); // false
  print(DictionaryReducedSA.hasEntry('meeting')); // true

  var entry = DictionaryReducedSA.getEntry('meeting');
  print(entry.word); // meeting
  print(entry.synonyms); // [Assemble, Contact, Adjoin, Forgather, See]
  print(entry.antonyms); // [diverge]

// Lookup an entry with its meanings.
// A meaning-object comes with a list of optional explanations
// and a list of optional contextual-meanings.

  entry = DictionaryReducedMSA.getEntry('meeting');
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
  entry = DictionarySA.getEntry('tree');

  // Larger memory footprint, with meanings.
  entry = DictionaryMSA.getEntry('tree');
}
```
### Powershell 

```ps1
> .\bin\dict.ps1 tree

WORD:tree 
EXPL:[[NOUN "a tall perennial woody plant having a main trunk and branches forming a distinct elevated crown; includes both gymnosperms and angiosperms" [Woody plant, Ligneous plant] []], [VERB "plant 
with trees" [Plant, Set] [this lot should be treed so that the house will be shaded in summer]], [VERB "chase an animal up a tree" [Chase, Chase after, Trail, Tail, Tag, Give chase, Dog, Go after, Track] [the hunters treed the bear with dogs and killed it, her dog likes to tree squirrels]], [VERB "stretch (a shoe) on a shoetree" [Elongate, Stretch] []]]
SYN:[Corner, Tree, Shoetree, Sir herbert beerbohm tree, Tree diagram]
ANT:[]
``` 

### Command line

Activate:

`dart pub global activate dictionaryx`

Deactivate:

`dart pub global deactivate dictionaryx`

```ps1
> dict tree

WORD:tree 
EXPL:[[NOUN "a tall perennial woody plant having a main trunk and branches forming a distinct elevated crown; includes both gymnosperms and angiosperms" [Woody plant, Ligneous plant] []], [VERB "plant 
with trees" [Plant, Set] [this lot should be treed so that the house will be shaded in summer]], [VERB "chase an animal up a tree" [Chase, Chase after, Trail, Tail, Tag, Give chase, Dog, Go after, Track] [the hunters treed the bear with dogs and killed it, her dog likes to tree squirrels]], [VERB "stretch (a shoe) on a shoetree" [Elongate, Stretch] []]]
SYN:[Corner, Tree, Shoetree, Sir herbert beerbohm tree, Tree diagram]
ANT:[]
```
## Bugs and Requests

If you encounter any problems feel free to open an issue. If you feel the library is missing a feature, please raise a ticket on Github and I'll look into it. Pull request are also welcome.

https://github.com/xErik/dictionaryx/issues

## Inspirations and Sources

Wordnet License

https://wordnet.princeton.edu/license-and-commercial-use

Merged JSON

https://github.com/nightblade9/simple-english-dictionary

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
