
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/until/app_constants.dart';
import 'package:food_delivery/until/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.89);
  var _currPageValue=0.0;
  double _scaleFactor=0.8;
  double _height=Dimensions.pageViewContainer;
@override
void initState()
{
    super.initState();
  pageController.addListener(() {
    setState(() {
      _currPageValue=pageController.page!;
      print("Current value is "+ _currPageValue.toString());

    });
  });
}
@override
void dispose()
{
  pageController.dispose();
  super.dispose();

}

  @override
  Widget build(BuildContext context) {
    return Column(
      // Slider section
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return popularProducts.isLoaded?Container(
              //color: Color.fromARGB(255, 190, 11, 11),
              height: Dimensions.pageView,
              
                
                child: PageView.builder(
                    controller: pageController,
                    itemCount: popularProducts.popularProductList.length,
                    itemBuilder: (context, position) {
                      return _buildPageItem(position, popularProducts.popularProductList[position]);
                    }),
              
            ):CircularProgressIndicator(
              color: Colors.cyan,
            );
        
        }),
        // dot
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return DotsIndicator(
              dotsCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
              position: _currPageValue.toInt(),// có sửa khi lỗi chạy dự án
              decorator: DotsDecorator(
                activeColor: Color.fromARGB(255, 24, 243, 243),
                size: Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            );
        
        }),
        //popular text
        SizedBox(height: Dimensions.height30,),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(width:Dimensions.width10,),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: BigText(text: ".",color: Colors.black26,),
              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food pairing",),
              )
            ],
          ),
        ),
        // list and food images
        // recommended food
         GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
          return recommendedProduct.isLoaded?
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedProduct.recommendedProductList.length,
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(RouterHelper.getRecommendedFood(index,"home"));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,bottom: Dimensions.height20),
                    child: Row(
                      children: [
                        // images section
                        Container(
                          height: Dimensions.ListViewImgsSize,
                          width: Dimensions.ListViewImgsSize100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white38,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                          AppConstants.BASE_URL+AppConstants.UPLOAD_URL+recommendedProduct.recommendedProductList[index].img!
                      )
                              )
                          ),
                        ),
                        // Text container
                        Expanded(
                          child: Container(
                            height: Dimensions.ListViewTextContSize,
                            
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimensions.radius20),
                                bottomRight: Radius.circular(Dimensions.radius20),
                              ),
                              color: Colors.white,
                        
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(text: recommendedProduct.recommendedProductList[index].name!),
                                  SizedBox(height: Dimensions.height10,),
                                  SmallText(text: "Width chinese characteristics"),
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
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ):CircularProgressIndicator(
              color: Color.fromARGB(255, 24, 199, 231),
            );

         }),        
      ],
    );
    
    }

  Widget _buildPageItem(int index,ProductModel popularProduct) {
    Matrix4 matrix=new Matrix4.identity();
    if (index==_currPageValue.floor()) {
      
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor); 
      var currTrans = _height*(1-currScale)/2;
      matrix= Matrix4.diagonal3Values(1, currScale, 1);
      matrix= Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0,currTrans,0);
    }else if(index == _currPageValue.floor()+1)
    {
      var currScale =_scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix= Matrix4.diagonal3Values(1, currScale, 1);
      matrix= Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0,currTrans,0);


    }else if(index == _currPageValue.floor()-1)
    {
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor); 
      var currTrans = _height*(1-currScale)/2;
      matrix= Matrix4.diagonal3Values(1, currScale, 1);
      matrix= Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0,currTrans,0);


    }else{
      var currScale=0.8;
       matrix= Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0,_height*(1-_scaleFactor)/2,0);;

    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
                  Get.toNamed(RouterHelper.getPopularFood(index,"home"));
                },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven
                      ? Color.fromARGB(255, 103, 221, 230)
                      : Color.fromARGB(255, 133, 76, 238),
                  image:  DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          AppConstants.BASE_URL+AppConstants.UPLOAD_URL+popularProduct.img!
                      )
                      )
                    ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30, bottom: Dimensions.width30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                  color: Color(0xFFe8e8e8),
                  blurRadius:5,
                  offset: Offset(0, 5),
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(-5, 0)
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(5, 0)
                )
                ]
              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height15, left: Dimensions.height15, right: Dimensions.height15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: popularProduct.name!),
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
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
