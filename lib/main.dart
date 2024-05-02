import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
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
import 'heper/dependencies.dart' as dep;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
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
          title: 'Flutter Demo',
          
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




