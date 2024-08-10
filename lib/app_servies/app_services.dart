import 'dart:convert';

import 'package:ajithkumar_interview/models/product_list_model.dart';
import 'package:dio/dio.dart';

abstract class AppServices{
  Future<ProductListModel> getProductList();
}
class AppServicesImpl extends AppServices{
  @override
  Future<ProductListModel> getProductList() async{
    final dio = Dio();
    var response = await dio.get('https://dummyjson.com/products');
    print('the response is: ${response.data}');
    final result = productListModelFromJson(jsonEncode(response.data));
    return result;
  }

}