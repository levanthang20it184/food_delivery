
import 'package:food_delivery/data/respository/order_repo.dart';
import 'package:food_delivery/models/place_order_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController implements GetxService{
  OrderRepo orderRepo;
  OrderController({required this.orderRepo});
  bool _isloading=false;  
  bool get isLoading=>_isloading;
  Future<void> placeOder(PlaceOrderModel placeOrder ,Function callback)async {
    _isloading = true;
    Response response = await orderRepo.placeOder(placeOrder);
    if (response.statusCode == 200) {
      _isloading = false;
      String message = response.body['message'];
      String orderID = response.body['order_id'].toString();
      callback(true, message, orderID);
    }else{
      callback(false, response.statusText!, '-1');
    }
  }
}