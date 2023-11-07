import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_delivery/until/dimensions.dart';
import 'package:food_delivery/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({super.key, required this.text});

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = Dimensions.screenWidth/1;
  @override
   void initState()
   {
    super.initState();
    if (widget.text.length>textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt()+1,widget.text.length);

      
    }else{
      firstHalf = widget.text;
      secondHalf="";
    }
   }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallText(height: 1.8,color:Color.fromARGB(255, 88, 87, 87),size: Dimensions.font16,text: firstHalf):Column(
        children: [
          SmallText(color:Color.fromARGB(255, 88, 87, 87),text: hiddenText?(firstHalf+"...."):(firstHalf+secondHalf)),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText=!hiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(size: Dimensions.font16,text: "Show more",color: Color.fromARGB(255, 6, 211, 225),),
                Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up,color: Color.fromARGB(255, 6, 211, 225),),
              ],
            ),
          )
        ],
      ),
    );
  }
}