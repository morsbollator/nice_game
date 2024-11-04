import 'package:flutter/material.dart';
import 'package:nice_game/info_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'main.dart';

class SelectGenderPage extends StatelessWidget {
  const SelectGenderPage({super.key});

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: [
            SizedBox(height: 6.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 2.w,),
                BackButtonWidget(),
                Spacer(),
                Image.asset('assets/image1.png',fit: BoxFit.fitWidth,width: 30.w,),
                Spacer(),
                SizedBox(width: 60,),
                SizedBox(width: 2.w,),
              ],
            ),

            SizedBox(height: 2.h,),
            Text('Select Your Gender',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            SizedBox(height: 5.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GenderWidget(image: 'assets/male.png', title: 'MALE',type: true,),
                GenderWidget(image: 'assets/female.png', title: 'FEMALE',type: false,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GenderWidget extends StatelessWidget {
  const GenderWidget({super.key, required this.image, required this.title, required this.type});
  final String image,title;
  final bool type;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Provider.of<InfoProvider>(context,listen: false).goToInfoPage(type);
      },
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xff681214),Color(0xffCE2428)],begin: Alignment.topCenter,end: Alignment.bottomCenter),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 5.h,),
            Image.asset(image),
            SizedBox(height: 7.h,child: Text(title,style: TextStyle(fontSize: 16.sp,
                fontWeight: FontWeight.bold,color: Colors.white),),),
          ],
        ),
      ),
    );
  }
}

