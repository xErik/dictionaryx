import 'package:dictionaryx/dictionary_msa_json.dart';
import 'package:test/test.dart';

void main() {
  var dMSA = DictionaryMSAJson();

  test('DictionaryMSAJson', () {
    expect(dMSA.hasEntry('assafef'), false);
    expect(dMSA.hasEntry('tree'), true);
    expect(dMSA.length(), 121300);
  });

  test('DictionaryMSAJson meeting antonyms and synonyms', () {
    expect(dMSA.hasEntry('meeting'), true);
    final entry = dMSA.getEntry('meeting');
    expect(entry.meanings.length, 4);
    expect(entry.synonyms.contains('Assemble'), true);
    expect(entry.antonyms.contains('diverge'), true);
  });
}
