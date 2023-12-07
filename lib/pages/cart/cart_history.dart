import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/until/app_constants.dart';
import 'package:food_delivery/until/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
     var getCartHistoryList= Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemPerOder=Map();
  
  for(int i=0;i<getCartHistoryList.length;i++){
  	if(cartItemPerOder.containsKey(getCartHistoryList[i].time))
    {
      cartItemPerOder.update(getCartHistoryList[i].time!, (value)=>++value);
    }else
    {
      cartItemPerOder.putIfAbsent(getCartHistoryList[i].time!,()=>1);
    }
    
  };
  List<int> cartItemsPerOderToList(){
    return cartItemPerOder.entries.map((e)=>e.value).toList();
   // return cartItemPerOder.entries.map((e){
    //  reurn e.value;
    //}).toList();
  }
  List<String> cartOderTimesToList(){
    return cartItemPerOder.entries.map((e)=>e.key).toList();
  
  }
  List<int> itemsPerOder=cartItemsPerOderToList();
  
  
  var listCouter=0;
  Widget timeWidget(int index){
    var outputDate = DateTime.now().toString();
    if (index<getCartHistoryList.length) {
      DateTime parseDate= DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCouter].time!);
      var inputDate =DateTime.parse(parseDate.toString());
      var outputFormat=DateFormat("MM/dd/yy hh:mm a");
       outputDate = outputFormat.format(inputDate);
    }
     return BigText(text:outputDate.toString());

  }
    return Scaffold(
      // appBar: AppBar(
      //   title: BigText(text: "Cart History",),
      // ),
      body: Column(
        children: [
          //header
          Container(
            height: Dimensions.height10*10,
            color: Color.fromARGB(255, 49, 236, 236),
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History", color: Colors.white,),
                AppIcon(icon: Icons.shopping_cart_outlined, iconColor: Color.fromARGB(255, 33, 243, 229), backgroudColor: Color.fromARGB(255, 236, 232, 14),)

              ],
            ),
          ),
          //body
          GetBuilder<CartController>(builder: (_cartController){
           return _cartController.getCartHistoryList().length>0?
            Expanded(child: Container(
                  margin: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context, 
                  child: ListView(
                      children: [
                        for(int i=0;i<itemsPerOder.length;i++)
                          Container(
                            height: Dimensions.height30*4.3,
                            margin: EdgeInsets.only(
                              bottom: Dimensions.height20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              timeWidget(listCouter),
                              SizedBox(height: Dimensions.height20,), 
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: List.generate(itemsPerOder[i], (index) {
                                      if (listCouter<getCartHistoryList.length) {
                                        listCouter++;
                                      }
                                      return index<=2?Container(
                                                  height: Dimensions.height20*3.8,
                                                  width: Dimensions.height20*3.8,
                                                  margin: EdgeInsets.only(right: Dimensions.width10/2),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                          AppConstants.BASE_URL+AppConstants.UPLOAD_URL+getCartHistoryList[listCouter-1].img!
                                                        )
                                                      )
                                                  ),
                                                ):Container();
                                    
                                      
                                    }),
                                  ),
                                  Container(
                                    height: Dimensions.height20*3.8,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SmallText(text: "Total"),
                                        BigText(text: itemsPerOder[i].toString()+" Items"),
                                        GestureDetector(
                                          onTap: (){
                                            var orderTime = cartOderTimesToList();
                                            Map<int, CartModel> moreOrder = {};
                                            for (int j = 0; j < getCartHistoryList.length; j++) {
                                              if (getCartHistoryList[j].time==orderTime[i]) {
                                               moreOrder.putIfAbsent(getCartHistoryList[j].id!, () => 
                                                CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                               );
                                              }
                                            }
                                              Get.find<CartController>().setItems = moreOrder;
                                              Get.find<CartController>().addToCartList();
                                              Get.toNamed(RouterHelper.getCartPage());
                                          },
                                         child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,
                                          vertical: Dimensions.height10/2
                                          ),

                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              Dimensions.radius15/3,
                                            ),
                                            border: Border.all(width: 1,color: Color.fromARGB(255, 33, 243, 236))
                                          ),
                                          child: SmallText(text: "one more"),
                                        )
                                        )
                                      ]),
                                  ),
                                ],
                              )                          
                              ],
                            ),
                          )
                        ],
                    ),
                )
                )
            ):SizedBox(
              height: MediaQuery.of(context).size.height/1.5,
              child: const Center(child: NoDataPage(text: "You din't buy anything so far !",imgPath: "assets/image/empty_box.png",)),
            );
          
          })
          ],
      ),
    );
  }
}