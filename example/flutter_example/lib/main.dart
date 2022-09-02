import 'package:dictionaryx/dictentry.dart';
import 'package:dictionaryx/dictionary_msa_json_flutter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  final String title = 'DictionaryX Flutter Demo';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final cText = TextEditingController();
  var dMSAJson = DictionaryMSAFlutter();
  int timeMillis = 0;

  DictEntry _entry = DictEntry('', [], [], []);

  // Gets a DictEntry for a given word.
  void lookupWord() async {
    DictEntry? tmp;
    final txt = cText.text.trim();
    if (await dMSAJson.hasEntry(txt)) {
      var s = Stopwatch()..start();
      tmp = await dMSAJson.getEntry(txt);
      s.stop();
      timeMillis = s.elapsedMilliseconds;
    }

    setState(() {
      if (tmp != null) {
        _entry = tmp;
      } else {
        _entry = DictEntry('', [], [], []);
      }
    });
  }

  void openPackage() async {
    await launchUrl(Uri.parse('https://pub.dev/packages/dictionaryx'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          ElevatedButton.icon(
            onPressed: () => openPackage(),
            icon: const Icon(Icons.web_sharp),
            label: const Text('DictionaryX Package'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //
            // ENTER WORD
            //
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Enter a word',
                  suffixIcon: IconButton(
                      onPressed: () => lookupWord(),
                      icon: const Icon(Icons.search))),
              onFieldSubmitted: (_) => lookupWord(),
              controller: cText,
            ),
            const SizedBox(height: 16),
            //
            // SHOW ENTRY FOR WORD
            //
            if (_entry.word.isNotEmpty) Milliseconds(timeMillis),
            if (_entry.word.isNotEmpty) WordEntry(_entry)
          ],
        ),
      ),
    );
  }
}

class Milliseconds extends StatelessWidget {
  final int timeMillis;
  const Milliseconds(this.timeMillis, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
        child: Text('$timeMillis ms'),
      ),
    );
  }
}

/// Displays the content of a DictEntry.
class WordEntry extends StatelessWidget {
  final DictEntry _entry;
  const WordEntry(this._entry, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(shrinkWrap: true, children: [
        Table(
          columnWidths: const {0: IntrinsicColumnWidth(), 1: FlexColumnWidth()},
          border: TableBorder.all(width: 1.0, color: Colors.grey),
          children: [
            _tableRow('WORD', _entry.word),
            _tableRow('SYNONYMS', _entry.synonyms.join(', ')),
            _tableRow('ANTONYMS', _entry.antonyms.join(', ')),
            TableRow(
              children: [
                _tableCell('VARIATIONS'),
                Table(
                  columnWidths: const {
                    0: IntrinsicColumnWidth(),
                    1: FlexColumnWidth()
                  },
                  border: TableBorder.all(width: 1.0, color: Colors.grey),
                  children: _entry.meanings
                      .map((e) {
                        return [
                          _tableRow('POS', e.pos.name),
                          _tableRow('DESCRIPTION', e.description),
                          _tableRow('MEANINGS', e.meanings.join(' / ')),
                          _tableRow('EXAMPLES', e.examples.join(' / ')),
                          if (_entry.meanings.last != e) _tableRow('', ''),
                        ];
                      })
                      .expand((element) => element)
                      .toList(),
                )
              ],
            ),
          ],
        ),
      ]),
    );
  }

  TableRow _tableRow(String title, String content) {
    return TableRow(
      children: _tableCells(title, content),
    );
  }

  List<TableCell> _tableCells(String title, String content) {
    return [
      _tableCell(title, isTitle: true),
      _tableCell(content),
    ];
  }

  TableCell _tableCell(String content, {isTitle = false}) {
    var style0 = isTitle
        ? const TextStyle(fontWeight: FontWeight.bold)
        : const TextStyle();
    var style1 = const TextStyle(fontSize: 16);

    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          content,
          style: style0.merge(style1),
        ),
      ),
    );
  }
}
