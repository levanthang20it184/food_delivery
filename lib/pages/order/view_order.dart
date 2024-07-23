import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery/until/app_color.dart';
import 'package:food_delivery/until/dimensions.dart';
import 'package:food_delivery/until/style.dart';
import 'package:get/get.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;
  const ViewOrder({super.key, required this.isCurrent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(builder: (orderController){
        if (orderController.isLoading==false) {
          late List<OrderModel> orderList;
          if (orderController.currentOrderList.isNotEmpty) {
            orderList = isCurrent? orderController.currentOrderList.reversed.toList():
            orderController.historyOrderList.reversed.toList();
          }
          return SizedBox(
            width: Dimensions.screenWidth,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width10/2, vertical: Dimensions.height10/2),
              child: ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder:(context, index){
                    return InkWell(
                      onTap: ()=>null,
                      child: Column(
                        children: [
                          Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(" Id   ",style: robotoRegular.copyWith(fontSize: Dimensions.font16),),
                                        Text(orderList[index].id.toString()),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.mainColor,
                                            borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                                          ),
                                            padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,vertical: Dimensions.width10/2),
                                            margin: EdgeInsets.all(Dimensions.height10/2),
                                            child: Text('${orderList[index].orderStatus}',
                                            style:  robotoMedium.copyWith(
                                              color: Theme.of(context).canvasColor,
                                              fontSize: Dimensions.font16-2,
                                              ),
                                            ),
                                          
                                        ),
                                        
                                        SizedBox(height: Dimensions.height10/2,),
                                        InkWell(
                                          onTap: () => null,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,vertical: Dimensions.width10/2),
                                            margin: EdgeInsets.all(Dimensions.height10/2),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                                              border: Border.all(width: 1, color: Theme.of(context).primaryColor),

                                            ),
                                            child: Container(
                                              margin: EdgeInsets.all(Dimensions.height10/2),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.car_crash_rounded, color: Theme.of(context).primaryColor,size: Dimensions.font16),
                                                  SizedBox(width: Dimensions.width10/2,),
                                                  Text("Track order",style: robotoMedium.copyWith(fontSize: Dimensions.font16-4),),
                                                ],
                                              )
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),   
                          SizedBox(height: Dimensions.height10,),
                        ],
                      ),
                      );
                  } 
                  ),
              ),
          );
        }else{
          return CustomLoader();
        }
      }),
    );
  }
}