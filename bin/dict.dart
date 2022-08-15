import 'dart:io';

import 'package:dictionaryx/src/dict_reduced_msa.dart';

main(List<String> args) {
  if (args.isEmpty) {
    print('Will use DictionaryReducedMSA for lookups.');
    print('USAGE: dart run dict.dart <WORD>');
    exit(0);
  }
  print(DictReducedMSA.getEntry(args.elementAt(0)));
}
