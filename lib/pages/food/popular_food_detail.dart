import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/until/app_constants.dart';
import 'package:food_delivery/until/dimensions.dart';
import 'package:food_delivery/widgets/app__colum.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    // print("page id :"+pageId.toString());
    // print("product name :"+product.name.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // background images
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImagSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!
                  ),
                ),
              ),
            ),
          ),
          // icon widget
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    if(page=="cartpage"){
                      Get.toNamed(RouterHelper.getCartPage());
                    }else{
                      Get.toNamed(RouterHelper.getInitial());
                    }
                  },
                  child: AppIcon(icon: Icons.arrow_back_ios)),
                  GetBuilder<PopularProductController>(builder: (controller){
                    return GestureDetector(
                        
                        onTap: () {
                          if(controller.totalItems>=1)  
                          Get.toNamed(RouterHelper.getCartPage());
                        },
                      child: Stack(
                        children: [
                          
                           AppIcon(icon: Icons.shopping_cart_outlined),
                          controller.totalItems>=1?
                          Positioned(
                            right: 0,top: 0,
                            child:AppIcon(icon: Icons.circle, size: 20, 
                              iconColor: Colors.transparent, backgroudColor: Color.fromARGB(255, 107, 254, 252),),
                            
                          ):
                          Container(),
                          Get.find<PopularProductController>().totalItems>=1?
                          Positioned(
                            right: 4,top: 3,
                            child: BigText(text: Get.find<PopularProductController>().totalItems.toString(),
                            size: 12,
                            color: Colors.white,
                            ),
                          ):
                          Container(),
                        ],
                      ),
                    );
                  }),   
              ],
            ) 
          ),
          // introduction of food
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImagSize-20,
            child: Container(
              padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,top: Dimensions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20),
                  topLeft: Radius.circular(Dimensions.radius20),
                ),
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColum(text: product.name!,),
                  SizedBox(height: Dimensions.height20,),
                  BigText(text: "Introducce"),
                  SizedBox(height: Dimensions.height20,),
                  Expanded(child: SingleChildScrollView(child: ExpandableTextWidget(text: product.description!)))
                ],
              )
            )
          ),
          // expandable widget

        ],
      ),
      bottomNavigationBar: 
       GetBuilder<PopularProductController>(builder: (popularProduct){
          return Container(
                height: Dimensions.bottomHeightBar,
                padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height30, left: Dimensions.width20,right: Dimensions.width20),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 219, 219, 219),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20*2),
                    topRight: Radius.circular(Dimensions.radius20*2),
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Container(
                      padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              popularProduct.setQuantity(false);
                            },
                            child: Icon(Icons.remove, color:Color.fromARGB(255, 122, 116, 116),)),
                          SizedBox(width: Dimensions.width20/5),
                          BigText(text: popularProduct.inCartItem.toString()),
                          SizedBox(width: Dimensions.width20/5),                  
                          GestureDetector(
                            onTap: (){
                              popularProduct.setQuantity(true);
                            },
                            child: Icon(Icons.add, color:Color.fromARGB(255, 122, 116, 116),)),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        popularProduct.addItem(product);
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
                        
                         child: BigText(text: "\$ ${product.price!}  | Add to cart ",color: Colors.white,),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: Color.fromARGB(255, 33, 252, 252),
                          
                        ),
                      ),
                    )
                  ],
                ),
              );
        
       },),
      );
  }
}