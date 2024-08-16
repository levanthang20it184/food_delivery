import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/until/dimensions.dart';
import 'package:food_delivery/until/style.dart';
import 'package:get/get.dart';

class DeliveryOptions extends StatelessWidget {
  final String value;
  final String title;
  final double amount;
  final bool isFree;

  const DeliveryOptions({super.key, 
  required this.value, 
  required this.title, 
  required this.amount, 
  required this.isFree});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController){
      return Row(
        children: [
          Radio(
            activeColor: Theme.of(context).primaryColor,
            value: value, 
            groupValue: orderController.orderType, 
            onChanged: (String? value)=>orderController.setDeliveryType(value!)
            ),
            SizedBox(width: Dimensions.width10/2,),
            Text(title,style: robotoRegular.copyWith(fontSize: Dimensions.font20, color: Theme.of(context).disabledColor),),
            SizedBox(width: Dimensions.width10/2,),
            Text(
              '(${(value == 'take away'||isFree)?'Free':'\$${amount/10}'})',
              style: TextStyle(fontSize: Dimensions.font26/2, color: Theme.of(context).disabledColor),
            )
        ],
      );
  
    });
  }
}