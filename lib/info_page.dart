import 'package:flutter/material.dart';
import 'package:nice_game/info_provider.dart';
import 'package:nice_game/main.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key, required this.image, required this.title, required this.keyController});
  final String image,title,keyController;
  @override
  Widget build(BuildContext context) {
    InfoProvider infoProvider = Provider.of(context,listen: true);
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
                Image.asset(image,fit: BoxFit.fitWidth,width: 30.w,),
                Spacer(),
                SizedBox(width: 60,),
                SizedBox(width: 2.w,),
              ],
            ),
            SizedBox(height: 2.h,),
            Text(title,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            SizedBox(height: 5.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: TextFormField(

                controller: infoProvider.textEditingController(keyController),
                cursorHeight: 25,
                cursorColor: Colors.black,
                autofocus: true,
                style: TextStyle(fontSize: 20),




                decoration: inputDecoration(context,label: '',suffix: keyController=='phone'&& infoProvider.textEditingController(keyController).text!='',onTap: (){
                  infoProvider.goToNextInput(keyController);
                }),
              ),
            ),
            SizedBox(height: 5.h,),
            Container(
              // Keyboard is transparent
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black,
              ),
              margin: EdgeInsets.all(2.w),

              child: Center(
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: VirtualKeyboard(
                    // Default height is 300
                      height: 20.h,
                      // Default height is will screen width
                      width: 90.w,
                      // Default is black
                      textColor: Colors.white,
                      textController: infoProvider.textEditingController(keyController),
                      // Default 14
                      fontSize: 20,
                      // the layouts supported
                      defaultLayouts : keyController=='phone'?[VirtualKeyboardDefaultLayouts.English,]:[VirtualKeyboardDefaultLayouts.English,
                        VirtualKeyboardDefaultLayouts.Arabic],
                      // [A-Z, 0-9]
                      type: keyController=='phone'?VirtualKeyboardType.Numeric:VirtualKeyboardType.Alphanumeric,
                      postKeyPress: (val){
                        // print(val.text);
                        print(val.action);
                        if(val.action==VirtualKeyboardKeyAction.Return){
                          infoProvider.goToNextInput(keyController);
                        }
                        if(keyController=='phone'){
                          infoProvider.rebuild();
                        }
                      },
                      // Callback for key press event
                      // onKeyPress: (VirtualKeyboardKey val){
                        // print(val.text);
                        // print(val.action);
                        // print(val.capsText);
                        // print(val.keyType.name);
                        // if(val.keyType.name=="String"){
                        //   textEditingController.text = textEditingController.text+val.text!;
                        // }else if(val.action==VirtualKeyboardKeyAction.Backspace&&textEditingController.text.isNotEmpty){
                        //   textEditingController.text = textEditingController.text.substring(0,textEditingController.text.length-1);
                        // }else if(val.action==VirtualKeyboardKeyAction.Space&&textEditingController.text.isNotEmpty){
                        //   textEditingController.text = '${textEditingController.text} ';
                        // }
                      // },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


InputDecoration inputDecoration(context,{bool obscureText = false,
  double? borderR,void Function()? onTap,
  int max = 1,bool translateOpen = true,Color? hintColor,
  bool title = false,String? titleText,Color? color,
  Widget? prefix,required String label,bool suffix = false,
  TextStyle? hintStyle,bool counter = false
}){
  return InputDecoration(
    counterText: counter?null:'',
    hintText: title?(titleText!=null?label:null):label,
    fillColor: color??Colors.white,
    filled: true,
    hintStyle: hintStyle??TextStyle(fontSize: 10.sp,color: hintColor??Colors.black,height: 1,),
    floatingLabelStyle: TextStyle(color: Colors.white,fontSize: 11.sp),
    floatingLabelBehavior: max==1?null:FloatingLabelBehavior.always,
    border: border(borderR: borderR),
    disabledBorder:border(borderR: borderR),
    focusedBorder: border(borderR: borderR),
    enabledBorder: border(borderR: borderR),
    errorBorder: border(color: Colors.red,borderR: borderR),
    focusedErrorBorder: border(color: Colors.red,borderR: borderR),
    hoverColor: Colors.grey,
    prefixIcon: prefix,
    contentPadding: max==1?EdgeInsets.symmetric(horizontal: 3.w):EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
    suffixIcon: !suffix?null:IconButton(onPressed:onTap,
        icon: Icon(Icons.arrow_circle_right_sharp,
          size: 5.w,color: Colors.green,),
        splashColor: Colors.transparent,highlightColor: Colors.transparent),
  );
}
InputBorder border({Color? color,double? borderR}){
  return OutlineInputBorder(borderRadius: BorderRadius.circular(borderR??8),
      borderSide: BorderSide(color: color??Colors.white));
}
