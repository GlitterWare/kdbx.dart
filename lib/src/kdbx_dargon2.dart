import 'package:dargon2/dargon2.dart' as dargon2;
import 'package:dargon2_flutter/dargon2_flutter.dart' as dargon2_flutter;
import 'package:dargon2_interface/dargon2_interface.dart' as dargon2_interface;

late dargon2_interface.DArgon2 argon2;

enum KdbxDargon2Platform {
  dart,
  flutter,
}

class KdbxDargon2 {
  void initialize(KdbxDargon2Platform platform) {
    switch (platform) {
      case KdbxDargon2Platform.dart:
        argon2 = dargon2.argon2;
        break;
      case KdbxDargon2Platform.flutter:
        dargon2_flutter.DArgon2Flutter.init();
        argon2 = dargon2_flutter.argon2;
        break;
    }
  }
}
