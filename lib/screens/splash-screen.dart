// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meshr_app/screens/home_page.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key,});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _controller =
        VideoPlayerController.asset('assets/splash/meshr_intro.mp4')
          ..initialize().then((_) {
            setState(() {});
          })
          ..setVolume(0.0);
    _playVideo();
  }

  void _playVideo() async {
   _controller.play();
    await Future.delayed(Duration(seconds: 7));

    Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) {
      return HomePage();
    })));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFB83C),
      body: Center(
          child: _controller.value.isInitialized
              ? VideoPlayer(_controller)
              : Container()),
    );
  }
}
