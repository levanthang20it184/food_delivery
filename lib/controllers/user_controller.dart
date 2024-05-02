import 'package:food_delivery/data/respository/user_repo.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/response_model.dart';

class UserController extends GetxController implements GetxService{
  final UserRepo userRepo;
  UserController({
    required this.userRepo,
  });
  
  bool _isLoading = false;
  late UserModel _userModel;
  
  bool get isLoading=>_isLoading;
  UserModel get userModel =>_userModel;
  Future<ResponseModel> getUserInfo()
  async {
    
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    print("test"+response.body.toString());
    if (response.statusCode==200) {
      _userModel = UserModel.fromJson(response.body);
      _isLoading=true;
      responseModel = ResponseModel(true, "sucessfull");
    }else{
      
      responseModel = ResponseModel(false, response.statusText!);

      print(response.statusText);
    }
    update();
    return responseModel;
  }

  
}