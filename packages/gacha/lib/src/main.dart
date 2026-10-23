import 'dart:math';

class Gacha {
  static Gacha? _instance;
  final Random _random;

  // Private constructor to prevent direct instantiation
  Gacha._([int? seed]) : _random = Random(seed);

  // Singleton instance (static access)
  static Gacha get instance {
    _instance ??= Gacha._();
    return _instance!;
  }

  // Constructor to create custom instance with a specific seed
  static Gacha create(int seed) {
    return Gacha._(seed);
  }

  String email() {
    const domains = ['example.com', 'mail.com', 'test.org'];
    final name = chars(8);
    final domain = domains[_random.nextInt(domains.length)];
    return '$name@$domain';
  }

  String phone({String prefix = '+62'}) {
    return '$prefix${_random.nextInt(900000000) + 100000000}';
  }

  int integer({
    int min = 0,
    int max = 100,
    int step = 1,
  }) {
    final range = ((max - min) / step).floor();
    return min + (_random.nextInt(range + 1) * step);
  }

  double float({
    double min = 0.0,
    double max = 100.0,
    double step = 0.1,
  }) {
    final range = ((max - min) / step).floor();
    return min + (_random.nextInt(range + 1) * step);
  }

  DateTime datetime({
    DateTime? start,
    DateTime? end,
    Duration? step,
  }) {
    start ??= DateTime(2000, 1, 1);
    end ??= DateTime.now();
    int difference = end.difference(start).inMilliseconds.clamp(1, 4294967295);
    if (step != null) {
      final steps = (difference / step.inMilliseconds).floor();
      return start.add(Duration(
          milliseconds: _random.nextInt(steps + 1) * step.inMilliseconds));
    }
    return start.add(Duration(milliseconds: _random.nextInt(difference)));
  }

  String chars(int length, {String? charset}) {
    final c = charset ?? 'abcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(length, (index) => c[_random.nextInt(c.length)])
        .join();
  }

  String words(
    int count, {
    int charsMin = 3,
    int charsMax = 8,
    String? characters,
  }) {
    return List.generate(count, (index) {
      int wordLength = charsMin + _random.nextInt((charsMax - charsMin) + 1);
      return chars(wordLength, charset: characters);
    }).join(' ');
  }

  String paragraphs(
    int count, {
    int wordsMin = 30,
    int wordsMax = 50,
    int charsMin = 3,
    int charsMax = 8,
    String? characters,
  }) {
    return List.generate(count, (index) {
      int wordsCount = wordsMin + _random.nextInt((wordsMax - wordsMin) + 1);
      return words(wordsCount,
          charsMin: charsMin, charsMax: charsMax, characters: characters);
    }).join('\n\n');
  }

  T pick<T>(List<T> items) {
    if (items.isEmpty) {
      throw ArgumentError('List cannot be empty');
    }
    return items[_random.nextInt(items.length)];
  }
}
