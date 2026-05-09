import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muaddin/features/player_two/controller/audio_controller.dart';
import 'package:muaddin/features/player_two/presentation/screens/surah_player_screen.dart';

class PlayerHome extends StatelessWidget {
  const PlayerHome({super.key});

  @override
  Widget build(BuildContext context) {
    final AudioController controller = Get.find();

    return Scaffold(
        appBar: AppBar(title: const Text('Quran Audio Player')),
        body: ListView.builder(
          itemCount: controller.surahNames.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(controller.surahNames[index]),
              trailing: const Icon(Icons.play_arrow),
              onTap: () {
                controller.playSurah(index);
                Get.to(() => SurahPlayerScreen(surahIndex: index));
              },
            );
          },
        ));
  }
}
