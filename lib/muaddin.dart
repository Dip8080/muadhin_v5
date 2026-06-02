// import 'package:flutter/material.dart';
// import 'package:flutter_sizer/flutter_sizer.dart';
// import 'package:get/get.dart';
// import 'package:muaddin/core/bindings/initial_binding.dart';
// import 'package:muaddin/core/theme/light_theme.dart';
// import 'package:muaddin/features/Home/controller/app_translations.dart';
// import 'package:muaddin/features/Home/presentation/screens/alerm_three.dart';
// import 'package:muaddin/features/update/controller/update_controller.dart';
// import 'package:muaddin/features/update/presentation/screens/update_screen.dart';

// class Muaddin extends StatelessWidget {
//   const Muaddin({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final UpdateController updateController = Get.find();
//     return FlutterSizer(builder: (context, orientation, screenType) {
//       return GetMaterialApp(
//         initialRoute: '/',
//         theme: lightThemeData(),
//         debugShowCheckedModeBanner: false,
//         translations: AppTranslations(),
//         locale: Locale('nl'),
//         fallbackLocale: Locale('en'),
//         // home: VideoSplashScreen(),
//         // home: AlermThree(),
//         initialBinding: InitialBinding(),
//         home: Obx(() {
//           /// 🔄 While checking (first load)
//           if (updateController.latestVersion.value.isEmpty) {
//             return const Scaffold(
//               body: Center(child: CircularProgressIndicator()),
//             );
//           }

//           /// 🚨 If update available
//           if (updateController.isUpdateAvailable.value) {
//             return UpdateScreen();
//           }

//           /// ✅ Otherwise continue app
//           return AlermThree();
//         }),
//       );
//     });
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:muaddin/core/bindings/initial_binding.dart';
import 'package:muaddin/core/theme/light_theme.dart';
import 'package:muaddin/features/Home/controller/app_translations.dart';
import 'package:muaddin/features/Home/presentation/screens/alerm_three.dart';
import 'package:muaddin/features/update/controller/update_controller.dart';
import 'package:muaddin/features/update/presentation/screens/update_screen.dart';

class Muaddin extends StatelessWidget {
  const Muaddin({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          initialRoute: '/',
          theme: lightThemeData(),
          debugShowCheckedModeBanner: false,
          translations: AppTranslations(),
          locale: const Locale('nl'),
          fallbackLocale: const Locale('en'),
          initialBinding: InitialBinding(),

          home: GetX<UpdateController>(
            builder: (updateController) {
              if (updateController.latestVersion.value.isEmpty) {
                return const Scaffold(
                  backgroundColor: Colors.black,
                  body: Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF8ED6D8),
                    ),
                  ),
                );
              }

              if (updateController.isUpdateAvailable.value) {
                return UpdateScreen();
              }
              return const AlermThree();
            },
          ),
        );
      },
    );
  }
}


// updated the way we listen to the update controller using GetX instead of Obx for better readability and performance.
// updated the way we listen to the update controller using GetX instead of Obx for better readability and performance.