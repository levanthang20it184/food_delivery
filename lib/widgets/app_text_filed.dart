import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_delivery/until/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  bool isObscure;
  AppTextField({super.key, required this.textController, required this.hintText, required this.icon, this.isObscure=false});

  @override
  Widget build(BuildContext context) {
    return  Container(
                
                margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      spreadRadius: 1,
                      offset: Offset(1, 1),
                      color: Colors.grey.withOpacity(0.2),
                    )
                  ]
                ),
                child: TextField(
                  obscureText: isObscure?true:false,
                  controller: textController,
                  decoration: InputDecoration(
                    //hintText,
                    hintText: hintText,
                    // prefixIcon
                    prefixIcon: Icon(icon,color: Color.fromARGB(255, 237, 192, 41)),
                    // focusedBorder
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Colors.white,
                      )
                    ),
                    //enabledBorder
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Colors.white,
                      ),
                    ),
                    // border
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      
                    )
                  ),
                ),
              )
        ;
  }
}