import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:muaddin/core/widgets/scrolling_text.dart';
import 'package:muaddin/features/player_two/controller/audio_controller_two.dart';

class TransparentDrawerThree extends StatelessWidget {
  final BuildContext context;

  TransparentDrawerThree({required this.context});

  final AudioControllerTwo audioController = Get.find();
// dfjeoiwhmf
  @override
  Widget build(BuildContext context) {
    // final AudioController audioController = Get.find();
    return Drawer(
      width: 35.w,
      backgroundColor: Colors.amber.withOpacity(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: Colors.white70.withOpacity(0.1),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Obx(() => ChoiceChip(
                        side: BorderSide.none,
                        iconTheme: IconThemeData(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.black87,
                        label: const Text(
                          "Ruqya               ",
                          style: TextStyle(fontWeight: FontWeight.w100),
                        ),
                        selected: audioController.isRukyaMode.value,
                        onSelected: (_) =>
                            audioController.isRukyaMode.value = true,
                        selectedColor: Colors.black,
                        labelStyle: TextStyle(
                          fontSize: 2.5.w,
                          fontWeight: FontWeight.w100,
                          color: audioController.isRukyaMode.value
                              ? Colors.white
                              : Colors.black,
                        ),
                      )),
                  // SizedBox(width: 1.w),
                  Obx(
                    () => ChoiceChip(
                      side: BorderSide.none,
                      backgroundColor: Colors.black87,
                      label: const Text("Dua                "),
                      selected: !audioController.isRukyaMode.value,
                      onSelected: (_) =>
                          audioController.isRukyaMode.value = false,
                      selectedColor: Colors.black,
                      labelStyle: TextStyle(
                        fontSize: 2.5.w,
                        color: !audioController.isRukyaMode.value
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 35.h,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                  ),
                  child: Center(child: _buildSurahPlayerBody(audioController)),
                ),
              ),
              Obx(() {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 1.5.w, vertical: 0.3.w),
                    // decoration: BoxDecoration(color: Colors.white30),
                    child: ListView.builder(
                      // itemCount: audioController.rukyaNames.length,
                      itemCount: audioController.currentItemCount,

                      itemBuilder: (context, index) {
                        return GestureDetector(
                          // onTap: () {
                          //   audioController.isPlaying.value = true;
                          //   audioController.playRukya(index);
                          //   audioController.rukyaIndex.value = index;
                          // },
                          onTap: () {
                            audioController.isPlaying.value = true;
                            audioController.rukyaIndex.value = index;

                            if (audioController.isRukyaMode.value) {
                              audioController.playRukya(index);
                            } else {
                              audioController.playDua(index);
                            }
                          },

                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: .8.h),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent.withOpacity(0.1),
                              border: Border.all(
                                color: Colors.white,
                                width: .4,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 14.0, horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: <Widget>[
                                    diamond_container(index),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                  ],
                                ),
                                // this is new , we will use scrolling text here to show the full name of the dua or rukya
                                Expanded(
                                  // child: Text(
                                  //   audioController.currentTitles[index],
                                  //   maxLines: 1,
                                  //   overflow: TextOverflow.ellipsis,
                                  //   textAlign: TextAlign.left,
                                  //   style: TextStyle(
                                  //     fontSize: 2.w,
                                  //     fontWeight: FontWeight.w100,
                                  //     color: Colors.white,
                                  //   ),
                                  // ),
                                  child: ScrollingText(
                                    text:
                                        '${audioController.currentTitles[index]}'
                                            .tr,
                                    textStyle: TextStyle(
                                      fontSize: 2.5.w,
                                      fontWeight: FontWeight.w100,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),

                                Obx(
                                  () => GestureDetector(
                                    onTap: () {
                                      audioController.isPlaying.value = true;
                                      audioController.rukyaIndex.value = index;

                                      if (audioController.isRukyaMode.value) {
                                        audioController.playRukya(index);
                                      } else {
                                        audioController.playDua(index);
                                      }
                                    },
                                    child: Container(
                                      width: 3.w,
                                      height: 3.w,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                          color: audioController
                                                      .rukyaIndex.value ==
                                                  index
                                              ? Colors.white
                                              : Colors.transparent,
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        audioController.rukyaIndex.value ==
                                                index
                                            ? Icons.play_arrow
                                            : Icons.play_arrow,
                                        color:
                                            audioController.rukyaIndex.value ==
                                                    index
                                                ? Colors.black
                                                : Colors.white,
                                        weight: 4,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Container diamond_container(int index) {
    return Container(
      height: 4.5.w,
      width: 4.5.w,
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/icons/rec.png'), fit: BoxFit.contain),
        // border: Border.all(color: Colors.white),
      ),
      child: Center(
        child: Text(
          '${index + 1}',
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
    );
  }

  Container circle_with_icon(IconData icon) {
    return Container(
      width: 3.w,
      height: 3.w,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          color: Colors.transparent,
          shape: BoxShape.circle),
      child: Icon(
        icon,
        color: Colors.white,
        weight: 4,
      ),
    );
  }

  Widget _buildSurahPlayerBody(AudioControllerTwo controller) {
    return Obx(() {
      String formatDuration(Duration duration) {
        final minutes = duration.inMinutes.toString().padLeft(2, '0');
        final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
        return "$minutes:$seconds";
      }

      bool isPlaying = controller.isPlaying.value;
      int rukyaIndex = controller.rukyaIndex.value;
      final currantTime = formatDuration(audioController.currentPosition.value);
      final totalTime = formatDuration(audioController.totalDuration.value);

      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    audioController.stopAudio();
                    audioController.toggleShowAdhanTimesOnSide(false);
                    Navigator.pop(context);
                  },
                  child: circle_with_icon(Icons.close)),
              SizedBox(
                width: 1.5.w,
              ),
              SizedBox(
                  width: 3.5.w,
                  height: 3.5.w,
                  child: diamond_container(rukyaIndex)),
              SizedBox(
                width: .6.w,
              ),
              // Text(
              //   "${controller.rukyaNames[rukyaIndex]}",
              //   style: TextStyle(
              //       fontSize: 3.w,
              //       fontWeight: FontWeight.w100,
              //       color: Colors.white),
              // ),
              // ScrollingText(text: "${controller.rukyaNames[rukyaIndex]}", textStyle: TextStyle(
              //       fontSize: 3.w,
              //       fontWeight: FontWeight.w100,
              //       color: Colors.white),)
              Expanded(
                child: Text(
                  controller.currentTitles[rukyaIndex].tr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 3.w,
                    fontWeight: FontWeight.w100,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    controller.toogleMute();
                  },
                  icon: Icon(
                    !controller.isMuted.value
                        ? Icons.volume_up
                        : Icons.volume_mute,
                    color: Colors.white,
                  )),
              Container(
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          audioController.skipBackward();
                        },
                        icon: Icon(
                          Icons.fast_rewind,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: 1.w,
                    ),
                    isPlaying
                        ? GestureDetector(
                            onTap: () {
                              controller.isPlaying.value = false;
                              controller.pauseAudio();
                            },
                            child: circle_with_icon(Icons.pause))
                        : GestureDetector(
                            onTap: () {
                              controller.isPlaying.value = true;
                              controller.playAudio();
                            },
                            child: circle_with_icon(Icons.play_arrow)),
                    SizedBox(
                      width: 1.w,
                    ),
                    IconButton(
                        onPressed: () {
                          audioController.skipForward();
                        },
                        icon: Icon(
                          Icons.fast_forward,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
              Container()
            ],
          ),
          Slider(
            activeColor: Colors.white,
            value: audioController.position.value.inSeconds.toDouble(),
            max: audioController.duration.value.inSeconds.toDouble(),
            onChanged: (value) {
              // await _audioPlayer.seek(Duration(seconds: value.toInt()));
              // return audioController.seekAudio(value);
              audioController.audioPlayer
                  .seek(Duration(seconds: value.toInt()));
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 1.8.w,
              ),
              Text(
                '${formatDuration(audioController.position.value)}',
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
              SizedBox(
                width: 20.w,
              ),
              Text(
                '${totalTime}',
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      );
    });
  }
}
