import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/heper/notification_helper.dart';
// import 'package:food_delivery/pages/auth/sign_in_page.dart';
// import 'package:food_delivery/pages/auth/sign_up_page.dart';
// import 'package:food_delivery/pages/splash/splash_page.dart';
// import 'package:food_delivery/pages/cart/cart_page.dart';
// import 'package:food_delivery/pages/food/popular_food_detail.dart';
// import 'package:food_delivery/pages/food/recommend_food_detail.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';
import 'controllers/popular_product_controller.dart';
import 'controllers/recommended_product_controller.dart';
import 'package:url_strategy/url_strategy.dart';

import 'heper/dependencies.dart' as dep;

// Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
//   print("onBackground: ${message.notification?.title}/${message.notification?.body}/"
//     "${message.notification?.titleLocKey}");
// }

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
Future<void> main() async {
  // setPathUrlStrategy(); // part 8 에서 추가된 부분
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await dep.init();
   
  // try {
  //   if (GetPlatform.isMobile) { // 모바일일 때 이렇게 하면 되는구나. 웹일때는 다르게 하고.. 다트에서 기본으로 지원해주는 함수이네..
  //     // 모든 메세지를 파이어베이스 콘솔에서 받아온다.
  //     final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage(); // 초기화 하는 부분
  //     await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
  //     FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler); // 백그라운드에서 실행되도록 함수를 연결해준다.
  //   }
  // } catch(e) {
  //   if (kDebugMode) {
  //     print(e.toString());
  //   }
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food Delivery App',
          
          // home: SignInPage(),
          initialRoute: RouterHelper.getSplashPage(),
          getPages: RouterHelper.routes,
          theme: ThemeData(
            primaryColor: Color.fromARGB(255, 54, 232, 176),
            fontFamily: "Lato"
          ),
        );
      });
    });
  }
}




