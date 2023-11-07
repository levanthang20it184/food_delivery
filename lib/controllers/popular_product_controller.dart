import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/respository/popular_product_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList=[];
  List<dynamic> get popularProductList=>_popularProductList;
  late CartController _cart;

  bool _isLoaded=true;
  bool get isLoaded=>_isLoaded;

  int _quantity=0;
  int get quantity=>_quantity;
  int _inCartItems=0;
  int get inCartItem=>_inCartItems+_quantity;


   Future<void> getPopularProductlist()async {
    Response response = await popularProductRepo.getPopularProductlist();
      if (response.statusCode==200) {
        
        _popularProductList=[];
        _popularProductList.addAll(Product.fromJson(response.body).products as Iterable);
        
        _isLoaded=true;
        update();
      }else{

      }
   }
  void setQuantity(bool isIncrement){
    if (isIncrement) {
      // print("increment"+_quantity.toString());
      _quantity = checkQuangtity(_quantity+1);
      // print("number of item "+_quantity.toString());
    }else{
      _quantity = checkQuangtity(_quantity-1);
    }
    update();
  }
  int checkQuangtity(int quantity)
  {
          print("in cart item"+_inCartItems.toString());
    if ((_inCartItems+quantity)<0) {
      Get.snackbar("Item count ", "You can't reduce more !",
      backgroundColor: Color.fromARGB(66, 30, 209, 222),
      colorText: Colors.white,
      );
      if (_inCartItems>0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    }else if((_inCartItems+quantity)>20)
    {
      Get.snackbar("Item count ", "You can't add more !",
      backgroundColor: Color.fromARGB(66, 30, 209, 222),
      colorText: Colors.white,
      );
      return 20;
    }else{
      return quantity;
    }
  }
  void initProduct(ProductModel product, CartController cart)
  {
    _quantity=0;
    _inCartItems=0;
    _cart=cart;
    var exist=false;
    exist = _cart.existInCart(product);
    // if exits
    // get from storage _inCartItem
    print("exits or not : "+exist.toString());

    if (exist) {
      _inCartItems=_cart.getQuantity(product);
      print("the quantity in cart : "+_inCartItems.toString());
    }
  }
  void addItem(ProductModel product)
  {
   
      _cart.addItem(product, _quantity);
      _quantity=0;
      _inCartItems=_cart.getQuantity(product);
      _cart.item.forEach((key, value) {
        print("The id is "+value.id.toString()+"The quantity is :"+value.quantity.toString());
      });
        update();
    }
    int get totalItems{
      return _cart.totalItems;
    }
    List <CartModel> get getItems{
      return _cart.getItems;
    }
    
}