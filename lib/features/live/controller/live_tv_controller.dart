import 'package:get/get.dart';
import 'package:muaddin/features/live/utls/model/live_tv_channel.dart';
import 'package:muaddin/features/live/utls/service/live_Tv_service.dart';
class LiveTvController extends GetxController {
  var channels = <LiveTvChannel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetch();
    super.onInit();
  }

  void fetch() async {
    try {
      isLoading.value = true;
      channels.value = await LiveTvService.fetchChannels();
    } finally {
      isLoading.value = false;
    }
  }
}