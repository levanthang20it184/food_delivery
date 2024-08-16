import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/until/dimensions.dart';
import 'package:food_delivery/until/style.dart';
import 'package:get/get.dart';

class PaymenOptionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  final int index;

  const PaymenOptionButton({super.key, 
  required this.icon, 
  required this.title, 
  required this.subTitle, 
  required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController){
      bool _selected = orderController.paymentIndex==index;
      return InkWell(
        onTap: ()=>orderController.setPaymentIndex(index),
        child: Container(
          padding: EdgeInsets.only(bottom: Dimensions.height10/2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius20/4),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[200]!, blurRadius: 5, spreadRadius: 1,
              )
            ]
          ),
          child: ListTile(
            leading: Icon(
              icon,
              size: 40,
              color: _selected?Theme.of(context).primaryColor:Theme.of(context).disabledColor,
            ),
            title: Text(
              title,
              style: _selected?robotoMedium.copyWith(fontSize: Dimensions.font20, color: Theme.of(context).primaryColor):robotoMedium.copyWith(fontSize: Dimensions.font20),
            ) ,
            subtitle: Text(
              subTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: robotoRegular.copyWith(
                color: Theme.of(context).disabledColor,
                fontSize: Dimensions.font16,
              ), 
            ),
            trailing: _selected?Icon(Icons.check_circle, color: Theme.of(context).primaryColor,):null,
          ),
        ),
      );
  
    });
    
  }
}