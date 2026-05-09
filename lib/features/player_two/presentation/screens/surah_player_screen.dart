import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muaddin/features/player_two/controller/audio_controller.dart';

class SurahPlayerScreen extends StatelessWidget {
  const SurahPlayerScreen({super.key, required this.surahIndex});

  final int surahIndex;

  @override
  Widget build(BuildContext context) {
    final AudioController controller = Get.find<AudioController>();
    // final int surahIndex = Get.arguments;

    return Scaffold(
      appBar: AppBar(title: Text(controller.surahNames[surahIndex])),
      body: Obx(() {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Playing: ${controller.surahNames[surahIndex]}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              "Position: ${controller.position.value.inMinutes}:${controller.position.value.inSeconds % 60}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: controller.playAudio,
                  child: const Text('Play'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: controller.pauseAudio,
                  child: const Text('Pause'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: controller.stopAudio,
                  child: const Text('Stop'),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
