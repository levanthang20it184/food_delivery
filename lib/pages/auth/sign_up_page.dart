import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/models/signup_body_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/until/dimensions.dart';
import 'package:food_delivery/widgets/app_text_filed.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController(); 
    var nameController=TextEditingController(); 
    var phoneController=TextEditingController(); 
    var signUpImages = [
      "t.png",
      "f.png",
      "g.png",
    ];
    //register
    void _registration(AuthController authController)
    {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
        String email = emailController.text.trim();
        String password = passwordController.text.trim();
      if (name.isEmpty) { 
        ShowCustomSnackBar("Type in your name !", title: "Name");
      }else if(phone.isEmpty)
              {
        ShowCustomSnackBar("Type in your phone !", title: "Phone");

              }else if(email.isEmpty)
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
        SignUpBody signUpBody=SignUpBody(
          name: name, 
          phone: phone, 
          email: email, 
          password: password,);
          authController.registration(signUpBody).then((status){
            if(status.isSuccess){
              print("Success registrantion !");
              Get.offNamed(RouterHelper.getInitial());
               }else{
                ShowCustomSnackBar(status.message);
               }
          });
              }

    }
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading?SingleChildScrollView(
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
            // your name
            AppTextField(
              textController: nameController, 
              hintText: "Name", 
              icon: Icons.person),
              SizedBox(height: Dimensions.height20,),
            // you phone
            AppTextField(
              textController: phoneController, 
              hintText: "Phone", 
              icon: Icons.phone),
              SizedBox(height: Dimensions.height20,),
            // Sign up button
            GestureDetector(
              onTap: () {
                _registration(_authController);
              },
              child: Container(
                width: Dimensions.screenWidth/2,
                height: Dimensions.screenHeight/13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: Color.fromARGB(255, 33, 229, 243),
                  
                ),
                child: Center(child: BigText(color:Colors.white,text: "Sign Up",size: Dimensions.font20+Dimensions.font20/2,)),
              ),
            ),
            SizedBox(height: Dimensions.height10,),
            //tag line 
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                text: "Have an account already !",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font20,
                )
              ),
              ),
            SizedBox(height: Dimensions.screenHeight*0.05,),
            // sign up option 
            RichText(
              text: TextSpan(
                text: "Sign up using one of the following methods !",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font16,
                )
              ),
              ),
              Wrap(
                
                children: List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: Dimensions.radius30,
                    backgroundImage: AssetImage(
                      "assets/image/"+signUpImages[index],
                    ),
                  ),
                )),
              )
           ]
          ),
      ):const CustomLoader();

      })
      
      );
  
  
  }
}