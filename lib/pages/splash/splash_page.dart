import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/until/dimensions.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  Future<void> _LoadResoure()
  async {
    await Get.find<PopularProductController>().getPopularProductlist();
    await Get.find<RecommendedProductController>().getRecommendedProductlist();

  }

  @override
  void initState()
  {
    super.initState();
    _LoadResoure();
    controller = AnimationController(
      vsync: this, 
      duration: const Duration(seconds: 2))..forward();
    animation = CurvedAnimation(
      parent: controller, 
      curve: Curves.linear);

    Timer(const Duration(seconds: 3), 
      ()=>Get.offNamed(RouterHelper.getInitial())
     );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          ScaleTransition(scale: animation,
          child: Center(child: Image.asset("assets/image/the_splash2.png",width: Dimensions.splashImage,))),
          Center(child: Image.asset("assets/image/the_splash.png",width: Dimensions.splashImage,))
        ]
        ),
    );
  }
}