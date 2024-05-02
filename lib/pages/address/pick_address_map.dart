import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_button.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/pages/address/search_location_dialogue_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/until/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;

  const PickAddressMap({super.key, required this.fromSignup, required this.fromAddress,
  this.googleMapController
  });

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition=LatLng(16.05443, 108.2022);
      _cameraPosition=CameraPosition(target: _initialPosition,zoom: 17);
    }else{
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition=LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]), 
          double.parse(Get.find<LocationController>().getAddress["longitude"]));
          _cameraPosition=CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locacationController){
      return  Scaffold(
            body: SafeArea(
              child: Center(
                child: SizedBox(
                  width: double.maxFinite,
                  child: Stack(
                    children: [
                      GoogleMap(initialCameraPosition: CameraPosition(
                        target: _initialPosition, zoom: 17
                        ),
                        zoomControlsEnabled: false,
                        onCameraMove: (CameraPosition cameraPosition){
                          _cameraPosition=cameraPosition;
                        },
                        onCameraIdle: (){
                          Get.find<LocationController>().updatePosition(_cameraPosition, false);
                        },
                         myLocationEnabled: true,
                         onMapCreated: (GoogleMapController mapController){
                          _mapController=mapController;
                          //còn thiếu

                         },
                        ),
                        Center(
                          child: !locacationController.loading?Image.asset("assets/image/pick_marker1.png",
                          height: 50,width: 50,):CircularProgressIndicator()
                        ),
                          // Showing and selecting address
                        Positioned(
                          top: Dimensions.height45,
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                          child: InkWell(
                            // onTap: ()=>Get.dialog(SearchLocationDialogue(mapController: _mapController)),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 97, 242, 250),
                                borderRadius: BorderRadius.circular(Dimensions.radius20/2)
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.location_on, size: 25, color: Colors.amberAccent,),
                                  Expanded(
                                    child: Text(
                                      '${locacationController.pickplacemark.name??''}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Dimensions.font16,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    ),
                                    // SizedBox(width: Dimensions.width10,),
                                    IconButton(
                                      icon: Icon(Icons.search, size: 25, color:  Colors.amberAccent),
                                      onPressed: () {
                                        Get.dialog(SearchLocationDialogue(mapController: _mapController));
                                      },
                                    ),
                                    
                                ]
                                ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 80,
                          left: Dimensions.width20,
                          right: Dimensions.width20,                       
                          child: locacationController.isLoading?Center(child: CircularProgressIndicator(),) : CustomButton(
                            width: 290,
                            buttonText:locacationController.inZone?widget.fromAddress?"Pick Address":"Pick Location":"Service is not avalible in your area !",
                            onPressed: (locacationController.buttonDisabaled||locacationController.loading)?null:(){
                              if (locacationController.pickPostion.latitude!=0&&locacationController.pickplacemark.name!=null) {
                                if (widget.fromAddress) {
                                  if (widget.googleMapController!=null) {
                                    print("Now you can clicked on this");
                                    widget.googleMapController!.moveCamera(CameraUpdate.newCameraPosition(
                                      CameraPosition(target: LatLng(
                                        locacationController.pickPostion.latitude, 
                                        locacationController.pickPostion.longitude
                                        ),zoom: 14)));
                                      locacationController.setAddAddressData();
                                  }
                                  //Get.back() create update problem 
                                  // list , a value 
                                  Get.back();
                                  // Get.toNamed(RouterHelper.getAddressPage());

                                }
                              }
                            },
                          )
                      
                          ),
                      
                    ],
                  )
                ),
              ),
              ),
          );
        
    });
    }
}