[![Pub Version](https://img.shields.io/pub/v/gacha)](https://pub.dev/packages/gacha) ![GitHub](https://img.shields.io/github/license/davigmacode/flutter_gacha) [![GitHub](https://badgen.net/badge/icon/buymeacoffee?icon=buymeacoffee&color=yellow&label)](https://www.buymeacoffee.com/davigmacode) [![GitHub](https://badgen.net/badge/icon/ko-fi?icon=kofi&color=red&label)](https://ko-fi.com/davigmacode)

🚀 **Gacha** is a lightweight Dart library for generating random data with high flexibility! Whether for testing, dummy data generation, or other use cases, `gacha` provides various generators such as emails, phone numbers, numbers, text, random lists, and more.

## ✨ Key Features
- **Flexible Access**: Use it as a **singleton** with `Gacha.instance` or create a new instance with a **custom seed** using `Gacha.create(seed)`.
- **Random Data Generators**:
  - 📧 **Email**: `gacha.email()`
  - 📱 **Phone Number**: `gacha.phone()`
  - 🔢 **Integer & Double Numbers**: `gacha.integer()`, `gacha.decimal()`
  - ⏳ **Date & Time**: `gacha.datetime()`
  - 🔤 **Random Text**: `gacha.chars()`, `gacha.words()`, `gacha.paragraphs()`
  - 🎰 **Pick Random Item from List**: `gacha.pick(list)`

## 🚀 Usage

### Using Singleton (default instance)
```dart
import 'package:gacha/gacha.dart';

void main() {
  print(Gacha.instance.email()); // example: `qwerty123@mail.com`
}
```

### Creating an Instance with a Custom Seed
```dart
import 'package:gacha/gacha.dart';

void main() {
  final gacha = Gacha.create(9999);
  print(gacha.email()); // Will always generate the same email for the same seed
}
```