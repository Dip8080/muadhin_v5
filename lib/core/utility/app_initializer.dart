import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'package:muaddin/firebase_options.dart';

class AppInitializer {
  static Future<void> init() async {
    // 🌍 Timezone
    tz.initializeTimeZones();

    // 🔥 Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // 🌐 Localization
    await initializeDateFormatting('nl', null);

    // 📱 Kiosk mode UI
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }
}