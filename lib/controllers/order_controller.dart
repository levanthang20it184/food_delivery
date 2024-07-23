
import 'package:food_delivery/data/respository/order_repo.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:food_delivery/models/place_order_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController implements GetxService{
  OrderRepo orderRepo;
  OrderController({required this.orderRepo});
  bool _isloading=false;  
  late List<OrderModel> _currentOrderList;
  late List<OrderModel> _historyOrderList;

  bool get isLoading=>_isloading;
  List<OrderModel> get currentOrderList => _currentOrderList;
  List<OrderModel> get historyOrderList => _historyOrderList;

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
  Future<void> getOrderList()async {
    _isloading=true;
    Response response = await orderRepo.getOrderList();
    if (response.statusCode==200) {
      _currentOrderList = [];
      _historyOrderList = [];
      response.body.forEach((order)
      {
        OrderModel orderModel = OrderModel.fromJson(order);
        if (orderModel.orderStatus=='pending'||
            orderModel.orderStatus=='accepted'||
            orderModel.orderStatus=='proccessing'||
            orderModel.orderStatus=='picked_up'||
            orderModel.orderStatus=='success'||
            orderModel.orderStatus=='handover'
        ) {
          _currentOrderList.add(orderModel);
        }else{
          historyOrderList.add(orderModel);
        }
      });
      
    }else{
      _currentOrderList = [];
      _historyOrderList = [];
    }
    _isloading=false;
    update();
  }
}