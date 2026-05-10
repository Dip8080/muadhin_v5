
import 'package:flutter/material.dart';
import 'package:muaddin/core/utility/app_initializer.dart';
import 'package:muaddin/core/widgets/restart_widget.dart';

import 'package:muaddin/muaddin.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppInitializer.init();

  runApp(
    RestartWidget(
      child: const Muaddin(),
    ),
  );
}

