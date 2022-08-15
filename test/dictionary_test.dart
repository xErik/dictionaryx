import 'package:dictionaryx/dictionary_msa.dart';
import 'package:dictionaryx/dictionary_reduced_msa.dart';
import 'package:dictionaryx/dictionary_reduced_sa.dart';
import 'package:dictionaryx/dictionary_sa.dart';
import 'package:test/test.dart';

void main() {
  test('DictionaryReducedMSA, fail', () {
    expect(DictionaryReducedMSA.hasEntry('assafef'), false);
  });

  test('DictionaryReducedMSA', () {
    expect(DictionaryReducedMSA.hasEntry('meeting'), true);
    final entry = DictionaryReducedMSA.getEntry('meeting');
    expect(entry.meanings.length, 4);
    expect(entry.synonyms.contains('Assemble'), true);
    expect(entry.antonyms.contains('diverge'), true);
    final expl = entry.meanings.first;
    expect(expl.hasExamples(), true);
    expect(expl.hasMeanings(), true);
  });

  test('DictionaryReducedSA', () {
    expect(DictionaryReducedSA.hasEntry('meeting'), true);
    final entry = DictionaryReducedSA.getEntry('meeting');
    expect(entry.meanings.length, 0);
    expect(entry.synonyms.contains('Assemble'), true);
    expect(entry.antonyms.contains('diverge'), true);
  });

  // Testing dicts with all entries

  test('DictionaryReducedMSA, fail', () {
    expect(DictionaryMSA.hasEntry('assafef'), false);
  });

  test('DictionaryMSA', () {
    expect(DictionaryMSA.hasEntry('meeting'), true);
    final entry = DictionaryMSA.getEntry('meeting');
    expect(entry.meanings.length, 4);
    expect(entry.synonyms.contains('Assemble'), true);
    expect(entry.antonyms.contains('diverge'), true);
  });

  test('DictionarySA', () {
    expect(DictionarySA.hasEntry('meeting'), true);
    final entry = DictionarySA.getEntry('meeting');
    expect(entry.meanings.length, 0);
    expect(entry.synonyms.contains('Assemble'), true);
    expect(entry.antonyms.contains('diverge'), true);
  });

  test('length all', () {
    expect(DictionarySA.length() > 100000, true);
  });

  test('length reduced', () {
    expect(DictionaryReducedSA.length() > 3000, true);
  });
  print(DictionaryReducedSA.length());
}
