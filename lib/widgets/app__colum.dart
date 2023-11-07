import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_delivery/widgets/small_text.dart';

import '../until/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColum extends StatelessWidget {
  final String text;

  const AppColum({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: text,size: Dimensions.font26,),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Row(
                     
                      children: [
                        Wrap(
                            children: List.generate(5,(index) { return Icon(
                                      Icons.star,
                                      color: Color.fromARGB(255, 83, 198, 227),
                                      size: 15,
                                    );})),
                        SizedBox(width: 10,),
                        SmallText(text: "4.5"),
                        SizedBox(width: 10,),
                        SmallText(text: "1287"),
                        SizedBox(width: 10,),
                        SmallText(text: "comments"),
    
                      ],
                    ),
                    SizedBox(height: Dimensions.height10,),
                    Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndTextWidget(icon: Icons.circle_sharp, text: "Normal", iconColor: Color.fromARGB(255, 242, 179, 33)),
                         IconAndTextWidget(icon: Icons.location_on, text: "1,7km", iconColor: Color.fromARGB(255, 47, 236, 226)),
                          IconAndTextWidget(icon: Icons.access_time_rounded, text: "32min", iconColor: Color.fromARGB(255, 244, 34, 34))
                      ],
                    ),
                  ],
                );
  }
}