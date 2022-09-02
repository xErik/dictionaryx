# dictionaryx

English dictionary with about 120.000 entries, based on Wordnet. 

## Dictionaries

This package offers four optimized `Dart` versions of the same base dictionary. 

Additonally, a `Dart` ready JSON-based dictionary is provided, which reads the entries from the file system and not from the memory.

Additonally, a `Flutter` ready JSON-based dictionary is provided, which reads the entries from the file system and not from the memory.

---

The dictionaries offer meaning (M), synonym (S) and antonym (A). In some cases the meaning (M) is left out to reduce the file size.

Based on the selected dictionary, application startup time and memory footprint are impacted accordingly.

---

**DictionaryMSAFlutter** (1213 JSON files, each has a size of 15 KB)

- About 120.000 entries. Meanings, synonyms and antonyms.
- `Flutter` only.

**DictionaryMSAJson** (1213 JSON files, each has a size of 15 KB)

- About 120.000 entries. Meanings, synonyms and antonyms.
- `Dart` only.

**DictionaryMSA** (16.4 MB)

- About 120.000 entries. Meanings, synonyms and antonyms.
- `Dart` only.

**DictionarySA** (7.3 MB)

- About 120.000 entries. Synonyms and antonyms.
- `Dart` only.

**DictionaryReducedMSA** (1.8 MB)

- About 3700 entries. Meanings, synonyms and antonyms.
- `Dart` only.

**DictionaryReducedSA** (274 KB)

- About 3700 entries. Synonyms and antonyms.
- `Dart` only.

## Installing

In your pubspec.yaml:

```yaml
dependencies:
  dictionaryx: ^0.3.4
```
## How To Use

### Flutter - Complete dictionary in JSON files

An example showing how to access the dictionary using Flutter is
provided in the `example/` folder. Please find an excerpt below.

```dart
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final cText = TextEditingController();
  final dMSAJson = DictionaryMSAFlutter();

  DictEntry _entry = DictEntry('', [], [], []);

  void lookupWord() async {

    DictEntry? tmp;
    
    final txt = cText.text.trim();
    if (await dMSAJson.hasEntry(txt)) {
      tmp = await dMSAJson.getEntry(txt);
    }

    setState(() {
      if (tmp != null) {
        _entry = tmp;
      } else {
        _entry = DictEntry('', [], [], []);
      }
    });
  }

  // ...
}
```

### Dart - Complete dictionary in JSON files

```dart
// -------------------------------------------------------
// With meanings (M) and synonyms (S) and antonyms (A).
// -------------------------------------------------------

var dMSAJson = DictionaryMSAJson();

var entry = dMSAJson.getEntry('meeting');

// A meaning comes with a POS, description
// and optional contextual-meanings and optional examples.

print(entry.meanings.first.pos); // POS.NOUN
print(entry.meanings.first.description); // a formally arranged gathering

print(entry.meanings.first.hasMeanings()); // true
print(entry.meanings.first.hasExamples()); // true

print(entry.meanings.first.meanings.first); // Gathering
print(entry.meanings.first.examples.first); // "next year the meeting (...)
```
### Dart - Reduced dictionary as a data literal

```dart
// -------------------------------------------------------
// With synonyms (S) and antonyms (A).
// -------------------------------------------------------

var dReducedSA = DictionaryReducedSA();

print(dReducedSA.hasEntry('assafef')); // false
print(dReducedSA.hasEntry('meeting')); // true

var entry = dReducedSA.getEntry('meeting');
print(entry.word); // meeting
print(entry.synonyms); // [Assemble, Contact, Adjoin, Forgather, See]
print(entry.antonyms); // [diverge]

// -------------------------------------------------------
// With meanings (M) and synonyms (S) and antonyms (A).
// -------------------------------------------------------

var dReducedMSA = DictionaryReducedMSA();

entry = dReducedMSA.getEntry('meeting');
print(entry.word); // meeting
print(entry.synonyms); // [Assemble, Contact, Adjoin, Forgather, See]
print(entry.antonyms); // [diverge]

// A meaning comes with a POS, description
// and optional contextual-meanings and optional examples.

print(entry.meanings.first.pos); // POS.NOUN
print(entry.meanings.first.description); // a formally arranged gathering

print(entry.meanings.first.hasMeanings()); // true
print(entry.meanings.first.hasExamples()); // true

print(entry.meanings.first.meanings.first); // Gathering
print(entry.meanings.first.examples.first); // "next year the meeting (...)
```
### Dart - Complete dictionary as a data literal

```dart
// -------------------------------------------------------
// In the same manner, the complete dictionary can be accessed.
// Compared to the reduced dictionary, the complete dictionary has
// a larger memory footprint.
// -------------------------------------------------------

// -------------------------------------------------------
// With meanings (M) and synonyms (S) and antonyms (A).
// -------------------------------------------------------

var dMSA = DictionaryMSA();
entry = dMSA.getEntry('tree');

// -------------------------------------------------------
// With synonyms (S) and antonyms (A).
// -------------------------------------------------------

var dSA = DictionarySA();
entry = dSA.getEntry('tree');
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
