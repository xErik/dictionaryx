import 'dart:io';

import 'package:dictionaryx/dictionary_msa_json.dart';

main(List<String> args) {
  if (args.isEmpty) {
    print('Will use DictionaryReducedMSA for lookups.');
    print('USAGE: dart run dict.dart <WORD>');
    exit(0);
  }
  print(DictionaryMSAJson().getEntry(args.elementAt(0)));
}
