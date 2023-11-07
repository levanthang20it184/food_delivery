import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_delivery/pages/home/food_page_body.dart';
import 'package:food_delivery/until/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    // print("current height is "+MediaQuery.of(context).size.width.toString());
    return Scaffold(
      body: Column(
        children: [
          //show header
          Container(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height15),
              padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [BigText(text: "Bangladesh",color: Color.fromARGB(255, 33, 243, 240),size: 18),
                               Row(
                                children: [
                                  SmallText(text: "Narsingdi",color: Color.fromARGB(255, 91, 89, 89),),
                                  Icon(Icons.arrow_drop_down_rounded)
                                ],
                               )
                    ],
                  ),
                  Container(
                    width: Dimensions.width45,
                    height: Dimensions.height45,
                    child: Icon(Icons.search,color: Colors.white,size: Dimensions.iconsize24,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: Color.fromARGB(255, 33, 243, 240),
                    ),
                  )
                ],
              ),
            ),
          ),
          //show body
          Expanded(child: SingleChildScrollView(
            child: FoodPageBody(),
          )),

        ],
      ),
    );
  }
}
