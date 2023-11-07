import 'package:flutter/material.dart';
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
    Get.find<PopularProductController>().getPopularProductlist();
    Get.find<RecommendedProductController>().getRecommendedProductlist();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      
      //home: CartPage(),
      initialRoute: RouterHelper.getInitial(),
       getPages: RouterHelper.routes,
    );
  }
}




