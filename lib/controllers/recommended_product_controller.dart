import 'package:food_delivery/data/respository/popular_product_repo.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:get/get.dart';

import '../data/respository/recommended_product_repo.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList=[];
  List<dynamic> get recommendedProductList=>_recommendedProductList;

  bool _isLoaded=true;
  bool get isLoaded=>_isLoaded;
   Future<void> getRecommendedProductlist()async {
    Response response = await recommendedProductRepo.getRecommendedProductlist();
      if (response.statusCode==200) {
        //  print("got product recommended");
        _recommendedProductList=[];
        _recommendedProductList.addAll(Product.fromJson(response.body).products as Iterable);
        //print(_popularProductList);
        _isLoaded=true;
        update();
      }else{
        print("could not get product recommended");
      }
   }
}