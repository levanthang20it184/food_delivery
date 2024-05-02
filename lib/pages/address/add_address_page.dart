// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/models/address_model.dart';
import 'package:food_delivery/pages/address/pick_address_map.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/until/dimensions.dart';
import 'package:food_delivery/widgets/app_text_filed.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {

  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  // CameraPosition _cameraPosition = CameraPosition(target: LatLng(
  //   45.51563, -122.677433), zoom: 17);
  // late LatLng _initialPosition=LatLng(
  //   45.51563, -122.677433);
  CameraPosition _cameraPosition = CameraPosition(target: LatLng(
    16.0544, 108.2022), zoom: 17);
  late LatLng _initialPosition=LatLng(
    16.0544, 108.20223);

  @override
  void initState()
  {
    super.initState();
    _isLogged= Get.find<AuthController>().userLoggedIn();
    if (_isLogged&&Get.find<UserController>().getUserInfo()==null) {
      // if (_isLogged&&Get.find<UserController>().userModel==null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      //bug fix
      if(Get.find<LocationController>().getUserAddressFromLocalStorage()==""){
        Get.find<LocationController>().saveUserAddress(Get.find<LocationController>().addressList.last);
      }
      Get.find<LocationController>().getUserAddress();
      _cameraPosition =CameraPosition(target: 
      LatLng(
        double.parse(Get.find<LocationController>().getAddress['latitude']),
        double.parse(Get.find<LocationController>().getAddress['longitude'])
      ),zoom: 15);
      _initialPosition=LatLng(
        double.parse(Get.find<LocationController>().getAddress['latitude']),
        double.parse(Get.find<LocationController>().getAddress['longitude'])
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Page"),
        backgroundColor: Color.fromARGB(255, 33, 233, 243),
      ),
      body: GetBuilder<UserController>(builder: (userController){

          if (userController.userModel!=null&&_contactPersonName.text.isEmpty) {
            _contactPersonName.text='${userController.userModel?.name}';
            _contactPersonNumber.text='${userController.userModel?.phone}';
            if (Get.find<LocationController>().addressList.isNotEmpty) {
             _addressController.text= Get.find<LocationController>().getUserAddress().address;
            }
          }

        return GetBuilder<LocationController>(builder: (locationController){
        _addressController.text = '${locationController.placemark.name??''}'
        '${locationController.placemark.locality??''}'
        '${locationController.placemark.postalCode??''}'
        '${locationController.placemark.country??''}';
        print("adddress my view :::::::::::::::::::::"+_addressController.text);
      return  SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 140,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 5,right: 5, top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 2,
                        color: Color.fromARGB(255, 33, 243, 240),
      
                      )
                    ),
                    child: Stack(
                      children: [
                        GoogleMap(initialCameraPosition: 
                          CameraPosition(target: _initialPosition, zoom: 17),
                          onTap: (LatLng){
                              Get.toNamed(RouterHelper.getPickAddressPage(),
                                arguments: PickAddressMap(
                                  fromSignup: false,
                                  fromAddress: true,
                                  googleMapController: locationController.mapController,
                                )
                              );
                          },
                          zoomControlsEnabled: true,
                          compassEnabled: false,
                          indoorViewEnabled: true,
                          mapToolbarEnabled: false,
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          onCameraIdle: (){
                            locationController.updatePosition(_cameraPosition,true);
                          },
                          onCameraMove: ((position)=>_cameraPosition=position),
                          onMapCreated: (GoogleMapController controller) {
                            locationController.setMaController(controller);
                            if(Get.find<LocationController>().addressList.isEmpty)
                            {
                              //LocationController.getCurrentLocation(true, mapController:controller)
                            }
                          }
                        )
                      ],
                    ),
                  ),                 
                  Padding(
                    
                    padding: EdgeInsets.only(left: Dimensions.width20,top: Dimensions.height20),
                    child: SizedBox(height: Dimensions.height20+Dimensions.height30,child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: locationController.addressTypelist.length,
                      itemBuilder: (context,index){
                      return InkWell(
                        onTap: () {
                          locationController.setAddressTypeIndex(index);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.width20,vertical: Dimensions.height20),
                          margin: EdgeInsets.only(right: Dimensions.width10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                            color: Theme.of(context).cardColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[200]!,
                                spreadRadius: 1,
                                blurRadius: 5
                              )
                            ]
                          ),
                          
                            child: Icon(
                                  index==0?Icons.home_filled:index==1?Icons.work:Icons.location_on,
                                  color: locationController.addressTypeIndex==index?
                                  Color.fromARGB(255, 33, 229, 243):Theme.of(context).disabledColor,
                                ),
                          
                        ),
                      );
                    }),),
                  ),
                  SizedBox(height: Dimensions.height20,),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.width20),
                    child: BigText(text: "Delivery Address"),
                  ),
                  SizedBox(height: Dimensions.height10  ,),
                  AppTextField(textController: _addressController, hintText: "Your address", icon: Icons.map),
                  SizedBox(height: Dimensions.height20  ,),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.width20),
                    child: BigText(text: "Contact Name"),
                  ),
                  SizedBox(height: Dimensions.height10  ,),
                  AppTextField(textController: _contactPersonName, hintText: "Your name", icon: Icons.person),
                  SizedBox(height: Dimensions.height20  ,),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.width20),
                    child: BigText(text: "Contact Phone"),
                  ),
                  SizedBox(height: Dimensions.height10  ,),
                  AppTextField(textController: _contactPersonNumber, hintText: "Your number", icon: Icons.phone),
      
                ],
              ),
      );    
      
      });
      
      }),
          bottomNavigationBar: 
          GetBuilder<LocationController>(builder: (locationController){
              return Container(
                    height: Dimensions.height20*6.5,
                    padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height30, left: Dimensions.width20,right: Dimensions.width20),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 219, 219, 219),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20*2),
                        topRight: Radius.circular(Dimensions.radius20*2),
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        
                        GestureDetector(
                          onTap: () {
                           AddressModel _addressModel = AddressModel(
                            addressType:  locationController.addressTypelist[locationController.addressTypeIndex],
                            contactPersonName: _contactPersonName.text,
                            contactPersonNumber: _contactPersonNumber.text,
                            address: _addressController.text,
                            latitude: locationController.position.latitude.toString(),
                            longitude: locationController.position.longitude.toString(),
                            );
                            locationController.addAddess(_addressModel).then((response){
                              if (response.isSuccess) {
                                Get.toNamed(RouterHelper.getInitial());
                                  Get.snackbar("Address", "Added Successfully !");
                              }else{
                                Get.snackbar("Address", "Couldn't save address !");
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
                            
                            child: BigText(text: "Save Address",color: Colors.white,size: 26,),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                              color: Color.fromARGB(255, 33, 252, 252),
                              
                            ),
                          ),
                        )
                      ],
                    ),
                  );
            
          },),
      
      );
  }
}