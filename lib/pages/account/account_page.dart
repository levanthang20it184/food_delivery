import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_delivery/base/custom_app_bar.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/pages/cart/cart_history.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/until/dimensions.dart';
import 'package:food_delivery/widgets/account_widget.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      // print("User has logg");
    }
    return Scaffold(
      appBar: CustomAppBar(title: "Profile"),
      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn?
        (userController.isLoading?Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(top: Dimensions.height20),
            child: Column(
              children: [
                    //profile icon
                    AppIcon(
                      icon: Icons.person,
                      backgroudColor:  Color.fromARGB(255, 33, 229, 243),
                      iconColor: Colors.white,
                      size: Dimensions.height15*10,
                      iconSize: Dimensions.height30+Dimensions.height45,
                      ),
                      SizedBox(height: Dimensions.height30,),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            //name
                          AccountWidget(
                            appIcon: 
                            AppIcon(
                              icon: Icons.person,
                              backgroudColor:  Color.fromARGB(255, 33, 229, 243),
                              iconColor: Colors.white,
                              size: Dimensions.height10*5,
                              iconSize: Dimensions.height10*5/2,
                              ), 
                            bigText: BigText(text: userController.userModel.name),),
                            SizedBox(height: Dimensions.height30,),
                          //phone
                          AccountWidget(
                            appIcon: 
                            AppIcon(
                              icon: Icons.phone,
                              backgroudColor:  Color.fromARGB(255, 243, 208, 33),
                              iconColor: Colors.white,
                              size: Dimensions.height10*5,
                              iconSize: Dimensions.height10*5/2,
                              ), 
                            bigText: BigText(text: userController.userModel.phone),),
                            SizedBox(height: Dimensions.height30,),
                          //email
                          AccountWidget(
                            appIcon: 
                            AppIcon(
                              icon: Icons.email,
                              backgroudColor:  Color.fromARGB(255, 243, 208, 33),
                              iconColor: Colors.white,
                              size: Dimensions.height10*5,
                              iconSize: Dimensions.height10*5/2,
                              ), 
                            bigText: BigText(text: userController.userModel.email),),
                            SizedBox(height: Dimensions.height30,),
                          //adress
                          GetBuilder<LocationController>(builder: (locationController){
                            if (_userLoggedIn&&locationController.addressList.isEmpty) {
                              return GestureDetector(
                                onTap: () {
                                  Get.offNamed(RouterHelper.getAddressPage());
                                },
                                child: AccountWidget(
                                                          appIcon: 
                                                          AppIcon(
                                icon: Icons.location_on,
                                backgroudColor:  Color.fromARGB(255, 243, 208, 33),
                                iconColor: Colors.white,
                                size: Dimensions.height10*5,
                                iconSize: Dimensions.height10*5/2,
                                ), 
                                                          bigText: BigText(text: "Hoa Thủy"),),
                              );
                            
                            }else{
                              return GestureDetector(
                                onTap: () {
                                  Get.offNamed(RouterHelper.getAddressPage());
                                },
                                child: AccountWidget(
                                                          appIcon: 
                                                          AppIcon(
                                icon: Icons.location_on,
                                backgroudColor:  Color.fromARGB(255, 243, 208, 33),
                                iconColor: Colors.white,
                                size: Dimensions.height10*5,
                                iconSize: Dimensions.height10*5/2,
                                ), 
                                                          bigText: BigText(text: "You address"),),
                              );
                            }
                          }),
                          SizedBox(height: Dimensions.height30,),
                          //message
                          AccountWidget(
                            appIcon: 
                            AppIcon(
                              icon: Icons.message_outlined,
                              backgroudColor:  Colors.redAccent,
                              iconColor: Colors.white,
                              size: Dimensions.height10*5,
                              iconSize: Dimensions.height10*5/2,
                              ), 
                            bigText: BigText(text: "Thang hello"),),
                            SizedBox(height: Dimensions.height30,),
                          GestureDetector(
                            onTap: (){
                              if (Get.find<AuthController>().userLoggedIn()) {
                                Get.find<AuthController>().clearSharedData();
                                Get.find<CartController>().clear();
                                Get.find<CartController>().clearCartHistory();
                                Get.find<LocationController>().clearAddessList();
                                Get.offAndToNamed(RouterHelper.getInitial());
                              }else{
                                print("you logout");
                              }
                            },
                            child: AccountWidget(
                            appIcon: 
                            AppIcon(
                              icon: Icons.logout,
                              backgroudColor:  Colors.redAccent,
                              iconColor: Colors.white,
                              size: Dimensions.height10*5,
                              iconSize: Dimensions.height10*5/2,
                              ), 
                            bigText: BigText(text: "Logout"),),
                          )
                            
                                    
                                    ],
                                  ),
                      ),
                    )
                ],
            ),
          ):
          CustomLoader()):
          Container(child: Center(child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: double.maxFinite,
                  height: Dimensions.height20*8,
                  margin:  EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/image/signin.png"
                      )
                      )
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouterHelper.GetSignInPage());
                  },
                  child: Container(
                    
                    width: double.maxFinite,
                    height: Dimensions.height20*5,
                    margin:  EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 33, 243, 240),
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      
                    ),
                    child: Center(child: BigText(text: "Sign in",color: Colors.white,size: Dimensions.font26,)),
                  ),
                )
            ],
          )),);
    
      })
      );
  }
}