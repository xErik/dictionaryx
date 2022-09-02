// import 'package:dictionaryx/dictionary_msa_json_flutter.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_test/flutter_test.dart';
// // import 'package:test/test.dart';

// void main() {
//   // TestWidgetsFlutterBinding.ensureInitialized();
//   WidgetsFlutterBinding.ensureInitialized();
//   var dMSA = DictionaryMSAFlutter();

//   test('DictionaryMSAFlutter', () async {
//     expect(await dMSA.hasEntry('assafef'), false);
//     expect(await dMSA.hasEntry('tree'), true);
//     expect(await dMSA.length(), 121300);
//   });

//   test('DictionaryMSAFlutter meeting antonyms and synonyms', () async {
//     expect(dMSA.hasEntry('meeting'), true);
//     final entry = await dMSA.getEntry('meeting');
//     expect(entry.meanings.length, 4);
//     expect(entry.synonyms.contains('Assemble'), true);
//     expect(entry.antonyms.contains('diverge'), true);
//   });
// }
