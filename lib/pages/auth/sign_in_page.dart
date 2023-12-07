import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/until/dimensions.dart';
import 'package:food_delivery/widgets/app_text_filed.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController(); 
     void _login(AuthController authController)
    {
      
        String email = emailController.text.trim();
        String password = passwordController.text.trim();
      if(email.isEmpty)
              {
        ShowCustomSnackBar("Type in your email !", title: "Email");

              }else if(!GetUtils.isEmail(email))
              {
        ShowCustomSnackBar("TType in a vaild email address ", title: "Vaild email address");

              }else if(password.isEmpty)
              {
        ShowCustomSnackBar("Type in your password !", title: "Password");

              }else if(password.length<6)
              {
        ShowCustomSnackBar("Password can not be less than six characters !", title: "Password");

              }else
              {
        // ShowCustomSnackBar("All went well !", title: "Perfect");
        
          authController.login(email, password).then((status){
            if(status.isSuccess){
              Get.toNamed(RouterHelper.getInitial());
              //Get.toNamed(RouterHelper.getCartPage());
               }else{
                ShowCustomSnackBar(status.message);
               }
          });
              }

    }
    
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading? SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: Dimensions.screenHeight*0.05,),
                //app  logo
                Container(
                  height: Dimensions.screenHeight*0.25,
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 80,
                      backgroundImage: AssetImage(
                        "assets/image/chokoshake.jpg"
                      ),
                    ),
                  ),
                ),
                //Wellcome
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20),
                  width: double.maxFinite,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        "Hello",
                        style: TextStyle(
                          fontSize: Dimensions.font20*3+Dimensions.font20/2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Sign into your account !",
                        style: TextStyle(
                          fontSize: Dimensions.font20,
                          color: Colors.grey[500],
                        
                        ),
                      )
                    ],
                  ),
                ),
              SizedBox(height: Dimensions.height20,),

                // your email
                AppTextField(
                  textController: emailController, 
                  hintText: "Email", 
                  icon: Icons.email),
                  SizedBox(height: Dimensions.height20,),
                // your password
                AppTextField(
                  textController: passwordController, 
                  hintText: "Password", 
                  icon: Icons.password,
                  isObscure: true,),
                  SizedBox(height: Dimensions.height20,),
                
                
                //tag line 
                Row(
                  children: [
                    Expanded(child: Container()),
                    RichText(
                          text: TextSpan(
                            text: "Sign in to your account !",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20,
                            )
                          ),
                        ),
                    SizedBox(width: Dimensions.width20,),

                  ],
                ),
                // Sign in button
                SizedBox(height: Dimensions.height10,),
                GestureDetector(
                  onTap: () {
                    _login(authController);
                  },
                  child: Container(
                    width: Dimensions.screenWidth/2,
                    height: Dimensions.screenHeight/13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: Color.fromARGB(255, 33, 229, 243),
                          
                    ),
                    child: Center(child: BigText(color:Colors.white,text: "Sign In",size: Dimensions.font20+Dimensions.font20/2,)),
                  ),
                ),
              
                SizedBox(height: Dimensions.screenHeight*0.05,),
                // sign up option 
                RichText(
                  text: TextSpan(
                    text: "Don\'t have an account ?",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20,
                    ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(),transition: Transition.fade),
                        text: " Create !",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 34, 32, 32),
                          fontSize: Dimensions.font20,
                      )
                      ),
                    ]
                  ),
                  ),
                  
              ]
              ),
          ):const CustomLoader();
    
      })
      );
  }
}