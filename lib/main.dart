import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nice_game/navigation.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:window_manager/window_manager.dart';

import 'constants.dart';
import 'home_page.dart';
import 'info_provider.dart';



//https://www.figma.com/design/EyeR36Ukm0sUqAbzhkn4Go/heaven-vally-(Copy)?node-id=2102-2&t=0CkqmNy6sefqxsNZ-1
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatefulWidget {


  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)async{
      await windowManager.ensureInitialized();
      await WindowManager.instance.setFullScreen(true);
      // await WindowManager.instance.setSize(Size(1080/2.5,1920/2.5));
      await windowManager.setAsFrameless();
      navPARU(HomePage());
    });
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => InfoProvider()),
        ],
        child: LayoutBuilder(
            builder: (context,a) {
              return Sizer(
                builder: (context, orientation, deviceType) {
                  print(100.w);
                  print(100.h);
                  return MaterialApp(
                    // title: 'MAZO',
                      debugShowCheckedModeBanner: false,
                      navigatorObservers: [routeObserver],
                      navigatorKey: Constants.navState,
                      builder: (context, child) {
                        return Stack(
                          children: [
                            child!,
                          ],
                        );
                      },

                      home:  Container(
                        width: 100.w,
                        height: 100.h,
                        color: Colors.black,
                      ));
                },
              );
            }
        ));
  }
}




class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
