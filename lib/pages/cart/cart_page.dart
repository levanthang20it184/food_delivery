import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/pages/food/recommend_food_detail.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/until/app_constants.dart';
import 'package:food_delivery/until/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20*3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  backgroudColor: Color.fromARGB(255, 34, 227, 217),
                  iconSize: Dimensions.iconsize24,
                  ),
                  SizedBox(width: Dimensions.width20*5,),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouterHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroudColor: Color.fromARGB(255, 34, 227, 217),
                    iconSize: Dimensions.iconsize24,
                    ),
                  ),
                  AppIcon(icon: Icons.shopping_cart_outlined,
                  iconColor: Colors.white,
                  backgroudColor: Color.fromARGB(255, 34, 227, 217),
                  iconSize: Dimensions.iconsize24,
                  )
              ],
            )
            ),
          Positioned(
            top: Dimensions.height20*5,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: Container(
              //color: Colors.red,
              margin: EdgeInsets.only(top: Dimensions.height15,),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(builder: (cartcontroller){
                  var _cartList = cartcontroller.getItems;
                  return ListView.builder(
                      itemCount: _cartList.length,
                      itemBuilder: (_,index){
                        return Container(
                          width: double.maxFinite,  
                          height: Dimensions.height20*5,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  var popularIndex = Get.find<PopularProductController>()
                                  .popularProductList
                                  .indexOf(_cartList[index].product);
                                  
                                  if (popularIndex>=0) {
                                    Get.toNamed(RouterHelper.getPopularFood(popularIndex,"cartpage"));
                                  }else{
                                  var recommendIndex = Get.find<RecommendedProductController>()
                                  .recommendedProductList
                                  .indexOf(_cartList[index].product);
                                  Get.toNamed(RouterHelper.getRecommendedFood(recommendIndex,"cartpage"));
                                  }
                                  // print("list product:"+popularIndex.toString());
                                },
                                child: Container(
                                    width: Dimensions.width20*5,
                                    height: Dimensions.height20*5,
                                    margin: EdgeInsets.only(bottom: Dimensions.height10,),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartcontroller.getItems[index].img!
                                        )
                                      ),
                                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                                      color: Colors.white,
                                    ),
                            
                                  ),
  
                                
                              ),                             
                              SizedBox(width: Dimensions.width10,),
                              Expanded(
                                child: Container(
                                  height: Dimensions.height20*5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(text: cartcontroller.getItems[index].name!,color: Colors.black54,),
                                      SmallText(text: "spicy"),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(text: "\$ ${cartcontroller.getItems[index].price.toString()} ",color: Colors.red,),
                                          Container(
                                            padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height10,left: Dimensions.width20,right: Dimensions.width20),

                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: (){
                                                    cartcontroller.addItem(_cartList[index].product!, -1);
                                                  },
                                                  child: Icon(Icons.remove, color:Color.fromARGB(255, 122, 116, 116),)),
                                                SizedBox(width: Dimensions.width20/5),
                                                BigText(text:_cartList[index].quantity.toString()),// popularProduct.inCartItem.toString()),
                                                SizedBox(width: Dimensions.width20/5),                  
                                                GestureDetector(
                                                  onTap: (){
                                                    cartcontroller.addItem(_cartList[index].product!, 1);
                                                    print("being ontaap");
                                                  },
                                                  child: Icon(Icons.add, color:Color.fromARGB(255, 122, 116, 116),)),
                                              ],
                                            ),
                                          ),
    
                                        ],
                                      )
                                    ],
                                  ),
                                )
                                )
                            ],
                          ),
                          );
                      });
              
                })
                ),
            ) 
            )
        ],
      ),
      bottomNavigationBar: 
            GetBuilder<CartController>(builder: (cartController){
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
                                
                                SizedBox(width: Dimensions.width20/5),
                                BigText(text: "\$"+cartController.totalAmount.toString()),
                                SizedBox(width: Dimensions.width20/5),                  
                                
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // popularProduct.addItem(product);
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
                              
                              child: BigText(text: "Check out",color: Colors.white,),
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