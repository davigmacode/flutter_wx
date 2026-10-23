import 'package:flutter_test/flutter_test.dart';
import 'package:gacha/gacha.dart';

void main() {
  group('Gacha Test', () {
    test('Generates a valid email', () {
      final email = Gacha.instance.email();
      expect(email, isNotEmpty);
      expect(email, contains('@'));
      expect(email, matches(RegExp(r'^[a-z0-9]+@[a-z]+\.[a-z]+$')));
    });

    test('Generates a valid phone number', () {
      final phone = Gacha.instance.phone();
      expect(phone, startsWith('+62'));
      expect(phone.length, greaterThan(10));
    });

    test('Generates integer within range', () {
      final intValue = Gacha.instance.integer(min: 10, max: 20);
      expect(intValue, inInclusiveRange(10, 20));
    });

    test('Generates float within range', () {
      final floatValue = Gacha.instance.float(min: 1.5, max: 3.5, step: 0.5);
      expect(floatValue, inInclusiveRange(1.5, 3.5));
    });

    test('Generates datetime within range', () {
      final start = DateTime(2020, 1, 1);
      final end = DateTime(2025, 1, 1);
      final datetime = Gacha.instance.datetime(start: start, end: end);
      expect(
          datetime.isAfter(start) || datetime.isAtSameMomentAs(start), isTrue);
      expect(datetime.isBefore(end) || datetime.isAtSameMomentAs(end), isTrue);
    });

    test('Generates random chars with correct length', () {
      final chars = Gacha.instance.chars(5);
      expect(chars.length, equals(5));
    });

    test('Generates words with correct count and length range', () {
      final words =
          Gacha.instance.words(5, charsMin: 3, charsMax: 6).split(' ');
      expect(words.length, equals(5));
      for (var word in words) {
        expect(word.length, inInclusiveRange(3, 6));
      }
    });

    test('Generates paragraphs with correct number of words', () {
      final paragraphs =
          Gacha.instance.paragraphs(2, wordsMin: 10, wordsMax: 15);
      final lines = paragraphs.split('\n\n');
      expect(lines.length, equals(2));

      for (var line in lines) {
        final wordsCount = line.split(' ').length;
        expect(wordsCount, inInclusiveRange(10, 15));
      }
    });

    test('Picks a random item from list', () {
      final items = ['apple', 'banana', 'cherry'];
      final picked = Gacha.instance.pick(items);
      expect(items.contains(picked), isTrue);
    });

    test('Creates a deterministic Gacha instance with seed', () {
      final gacha1 = Gacha.create(12345);
      final gacha2 = Gacha.create(12345);

      expect(gacha1.email(), equals(gacha2.email()));
      expect(gacha1.integer(min: 10, max: 20),
          equals(gacha2.integer(min: 10, max: 20)));
    });
  });
}
