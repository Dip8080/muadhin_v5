import 'package:flutter/material.dart';
import 'package:muaddin/features/Home/presentation/screens/alerm_three.dart';
import 'package:video_player/video_player.dart';

class VideoSplashScreen extends StatefulWidget {
  @override
  _VideoSplashScreenState createState() => _VideoSplashScreenState();
}

class _VideoSplashScreenState extends State<VideoSplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/splash.mp4')
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
          _controller.play();
        }
      });

    // Navigate to the next screen after the video ends
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            // MaterialPageRoute(builder: (context) => AlermTwo()),
            //  MaterialPageRoute(builder: (context) => AlermTwo()),
             MaterialPageRoute(builder: (context) => AlermThree()),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(() {});
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller.value.isInitialized
          ? SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Center(child: Text('Welcome to the app!')),
    );
  }
}
