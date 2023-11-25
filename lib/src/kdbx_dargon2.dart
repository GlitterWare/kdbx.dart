import 'package:dargon2/dargon2.dart' as dargon2;
import 'package:dargon2_flutter_desktop/dargon2_flutter_desktop.dart'
    as dargon2_desktop;
import 'package:dargon2_flutter_mobile/dargon2_flutter_mobile.dart'
    as dargon2_mobile;
import 'package:dargon2_interface/dargon2_interface.dart' as dargon2_interface;

late dargon2_interface.DArgon2 argon2;

enum KdbxDargon2Platform {
  dart,
  desktop,
  mobile,
}

class KdbxDargon2 {
  void initialize(KdbxDargon2Platform platform) {
    switch (platform) {
      case KdbxDargon2Platform.dart:
        argon2 = dargon2.argon2;
        break;
      case KdbxDargon2Platform.desktop:
        argon2 = dargon2_desktop.DArgon2Desktop();
        break;
      case KdbxDargon2Platform.mobile:
        argon2 = dargon2_mobile.DArgon2Mobile();
        break;
    }
  }
}
