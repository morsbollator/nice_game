import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nice_game/navigation.dart';
import 'package:nice_game/question_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late VideoPlayerController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = VideoPlayerController.file(File('C:\\background.mp4'));

    // controller.setLooping(true);
    // controller.initialize().then((value) {
    //   if (controller.value.isInitialized) {
    //
    //     // controller.setLooping(true);
    //     controller.play();
    //     setState(() {
    //
    //     });
    //     controller.addListener((){
    //       if(controller.value.duration.inMilliseconds<=controller.value.position.inMilliseconds){
    //         controller.pause();
    //         controller.seekTo(Duration(milliseconds: 1,seconds: 0)).then((val){
    //           controller.play();
    //         });
    //
    //       }
    //     });
    //   } else {
    //
    //   }
    // }).catchError((e) {
    //
    // });


  }
  @override
  Widget build(BuildContext context) {
    QuestionProvider questionProvider = Provider.of(context,listen: true);
    return Scaffold(
      body: Container(
        width: 100.w,
        height: 100.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/main_image.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            SizedBox(
              width: 100.w,
              height: 100.h,
              child: controller.value.isInitialized?VideoPlayer(controller):SizedBox(),
            ),
            if(questionProvider.backgroundColor()!=null)Container(
              width: 100.w,
              height: 100.h,
              color: questionProvider.backgroundColor()!.withOpacity(0.3),
            ),
            SizedBox(
              width: 100.w,
              height: 100.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Column(
                  children: [
                    SizedBox(height: 3.w,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            navPop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white
                            ),
                            padding: EdgeInsets.all(3.w),
                            child: Icon(Icons.close,color: Colors.red,size: 5.w,),
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white
                          ),
                          padding: EdgeInsets.all(3.w),
                          child: Text('${questionProvider.index+1}/${questionProvider.questions.length}',style: TextStyle(color: Colors.red,fontSize: 17,fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                    // SizedBox(height: 2.h,),
                    ShaderMask(shaderCallback: (v){
                      return LinearGradient(
                        colors: [Color(0xff681214),Color(0xffCE2428)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ).createShader(v);
                    },child: Text("Choose the correct \nanswer for the question",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.red,height: 1),textAlign: TextAlign.center,)),
                    SizedBox(height: 5.h,),
                    Container(
                      width: 90.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 3.h),
                      child: Center(child: Text(questionProvider.question()['question'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
                    ),
                    SizedBox(height: 5.h,),
                    SizedBox(
                      width: 95.w,
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runSpacing: 3.h,
                        spacing: 5.w,
                        children: List.generate(questionProvider.question()['answers'].length, (index){
                          String answer = questionProvider.question()['answers'][index];
                          bool correctAnswer = questionProvider.correctAnswer(answer);
                          bool wrongAnswer = questionProvider.wrongAnswer(index,answer);
                          return InkWell(
                            onTap: (){
                              questionProvider.setAnswerIndex(index);
                            },
                            child: Container(
                              width: 43.w,
                              decoration: BoxDecoration(
                                gradient: (correctAnswer||wrongAnswer)?null: ( LinearGradient(colors: [Color(0xff681214),Color(0xffCE2428)],begin: Alignment.topCenter,end: Alignment.bottomCenter)),
                                color: correctAnswer?Colors.green:(wrongAnswer?Colors.red:null),
                                borderRadius: BorderRadius.circular(10),
                                border: questionProvider.answerIndex==index?Border.all(color: Colors.green,width: 8,):null,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.h),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.all(3.w),
                                    child: Text(questionProvider.alpha[index],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                  ),
                                  SizedBox(width: 2.w,),
                                  Expanded(child: Text(answer,style: TextStyle(color: Colors.white,fontSize: 15),),),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 5.h,),
                    Container(
                      width: 30.w,
                      height: 30.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red,width: 4),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child:questionProvider.answerFinish?
                            LottieBuilder.asset(questionProvider.lottie()): Text(questionProvider.counter.toString(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
