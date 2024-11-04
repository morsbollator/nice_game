import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nice_game/navigation.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

class GameOverPage extends StatefulWidget {
  const GameOverPage({super.key, required this.path});
  final String path;

  @override
  State<GameOverPage> createState() => _GameOverPageState();
}

class _GameOverPageState extends State<GameOverPage> {
  late VideoPlayerController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = VideoPlayerController.file(File(widget.path));

    // controller.setLooping(true);
    controller.initialize().then((value) {
      if (controller.value.isInitialized) {

        // controller.setLooping(true);
        controller.play();
        setState(() {

        });
        controller.addListener((){
          if(controller.value.duration.inMilliseconds<=controller.value.position.inMilliseconds){
            controller.pause();
            navPU();

          }
        });
      } else {

      }
    }).catchError((e) {

    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: 100.w,
        height: 100.h,
        child: controller.value.isInitialized?VideoPlayer(controller):SizedBox(),
      ),
    );
  }
}
