import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nice_game/info_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = VideoPlayerController.file(File('C:\\start.mp4'));

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
            controller.seekTo(Duration(milliseconds: 1,seconds: 0)).then((val){
              controller.play();
            });

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
      body: InkWell(
        onTap: (){
          Provider.of<InfoProvider>(context,listen: false).goToGenderPage();
        },
        child: Container(
          width: 100.w,
          height: 100.h,
          child: controller.value.isInitialized?VideoPlayer(controller):SizedBox(),
        ),
      ),
    );
  }
}
