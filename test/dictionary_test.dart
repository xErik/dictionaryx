import 'package:dictionaryx/dictionary_msa.dart';
import 'package:dictionaryx/dictionary_reduced_msa.dart';
import 'package:dictionaryx/dictionary_reduced_sa.dart';
import 'package:dictionaryx/dictionary_sa.dart';
import 'package:test/test.dart';

void main() {
  var dReducedSA = DictionaryReducedSA();
  var dReducedMSA = DictionaryReducedMSA();

  var dSA = DictionarySA();
  var dMSA = DictionaryMSA();

  test('DictionaryReducedMSA, fail', () {
    expect(dReducedMSA.hasEntry('assafef'), false);
  });

  test('DictionaryReducedMSA', () {
    expect(dReducedMSA.hasEntry('meeting'), true);
    final entry = dReducedMSA.getEntry('meeting');
    expect(entry.meanings.length, 4);
    expect(entry.synonyms.contains('Assemble'), true);
    expect(entry.antonyms.contains('diverge'), true);
    final expl = entry.meanings.first;
    expect(expl.hasExamples(), true);
    expect(expl.hasMeanings(), true);
  });

  test('DictionaryReducedSA', () {
    expect(dReducedSA.hasEntry('meeting'), true);
    final entry = dReducedSA.getEntry('meeting');
    expect(entry.meanings.length, 0);
    expect(entry.synonyms.contains('Assemble'), true);
    expect(entry.antonyms.contains('diverge'), true);
  });

  // Testing dicts with all entries

  test('DictionaryReducedMSA, fail', () {
    expect(dMSA.hasEntry('assafef'), false);
  });

  test('DictionaryMSA', () {
    expect(dMSA.hasEntry('meeting'), true);
    final entry = dMSA.getEntry('meeting');
    expect(entry.meanings.length, 4);
    expect(entry.synonyms.contains('Assemble'), true);
    expect(entry.antonyms.contains('diverge'), true);
  });

  test('DictionarySA', () {
    expect(dSA.hasEntry('meeting'), true);
    final entry = dSA.getEntry('meeting');
    expect(entry.meanings.length, 0);
    expect(entry.synonyms.contains('Assemble'), true);
    expect(entry.antonyms.contains('diverge'), true);
  });

  test('length all', () {
    expect(dSA.length() > 100000, true);
  });

  test('length reduced', () {
    expect(dReducedSA.length() > 3000, true);
    expect(dReducedSA.length() < 10000, true);
  });
}
