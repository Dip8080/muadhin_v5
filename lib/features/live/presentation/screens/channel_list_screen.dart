import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muaddin/features/live/presentation/screens/hls_player_screen.dart';
import 'package:muaddin/features/live/controller/live_tv_controller.dart';

class LiveTvScreen extends StatelessWidget {
  final controller = Get.put(LiveTvController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Haramain")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator());
        }
// udated
        return ListView.builder(
          itemCount: controller.channels.length,
          itemBuilder: (context, index) {
            final channel =
                controller.channels[index];

            return ListTile(
              title: Text(channel.name),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HlsPlayerScreen(
                      url: channel.url,
                      title: channel.name,
                    ),
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}