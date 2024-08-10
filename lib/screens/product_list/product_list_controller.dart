import 'dart:async';

import 'package:ajithkumar_interview/app_servies/app_services.dart';
import 'package:ajithkumar_interview/models/product_list_model.dart';


abstract class ProductListController {
  bool get isChipIsTrue;

  Stream get chipStream;

  Stream get totalAmountStream;

  double get totalAmount;

  Future<ProductListModel> getProductList();
}

class ProductListControllerImpl extends ProductListController {
  final StreamController _isChipStreamController = StreamController.broadcast();
  final StreamController _totalAmountStreamStreamController =
      StreamController.broadcast();
  List<String> category = ['Milk', 'Cool Drinks', 'Chips', 'Chips', 'Chips'];
  List<String> shopNames = ['webStromers', 'Aavin milk stall', 'Aarokya milk stall'];
  List<String> selectPrices = ['10 - 20', '20 - 25', '25 - 30'];
  List<String> days = ['Yesterday', 'Today', 'Tomorrow'];
  final _appServices = AppServicesImpl();
  double _totalAmount = 0;
  bool _isChipIsTrue = false;
  int selectedChipIndex = -1;

  @override
  bool get isChipIsTrue => _isChipIsTrue;

  set isChipIsTrue(bool value) {
    _isChipIsTrue = value;
  }

  @override
  Stream get chipStream => _isChipStreamController.stream;

  chipStreamController(bool streamValue) {
    _isChipStreamController.add(streamValue);
  }

  @override
  Future<ProductListModel> getProductList() {
    return _appServices.getProductList();
  }

  @override
  Stream get totalAmountStream => _totalAmountStreamStreamController.stream;

  totalAmountStreamStreamController(bool streamValue) {
    _totalAmountStreamStreamController.add(streamValue);
  }

  @override
  double get totalAmount => _totalAmount;
  set totalAmount(double amount){
    _totalAmount = amount;
  }
}
