import 'package:ajithkumar_interview/components/curved_edges.dart';
import 'package:ajithkumar_interview/components/custom_dropdownbuttonformfield.dart';
import 'package:ajithkumar_interview/components/custom_elevated_button.dart';
import 'package:ajithkumar_interview/constants/appColors.dart';
import 'package:ajithkumar_interview/models/product_list_model.dart';
import 'package:ajithkumar_interview/screens/order_list/order_list.dart';
import 'package:ajithkumar_interview/screens/product_list/product_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final _prodController = ProductListControllerImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          ClipPath(
            clipper: CurvedEdges(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                color: AppColors.whiteColor,
                              )),
                          Text(
                            'Order delivery',
                            style: TextStyle(
                                fontSize: 18,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      CustomDropDownButtonFormField(
                          width: 150,
                          dropDownList: _prodController.days,
                          hintText: 'Days')
                    ],
                  )),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildCategoryListChip(),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildFilterDropDowns(),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildProductList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryListChip() {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          scrollDirection: Axis.horizontal,
          itemCount: _prodController.category.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _prodController.selectedChipIndex = index;
                _prodController.chipStreamController(true);
              },
              child: StreamBuilder(
                stream: _prodController.chipStream,
                builder: (context, snapshot) {
                  bool isSelected = _prodController.selectedChipIndex == index;
                  return Chip(
                      color: WidgetStatePropertyAll(isSelected
                          ? AppColors.primaryColor
                          : AppColors.secondaryColor),
                      side: BorderSide.none,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      label: Text(
                        _prodController.category[index],
                        style: TextStyle(
                            color: isSelected
                                ? AppColors.whiteColor
                                : AppColors.lightBlack),
                      ));
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFilterDropDowns() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomDropDownButtonFormField(
              hintText: 'Select price',
              dropDownList: _prodController.selectPrices),
          CustomDropDownButtonFormField(
              hintText: 'Select store',
              dropDownList: _prodController.shopNames),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return FutureBuilder(
      future: _prodController.getProductList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          List<Product>? products = snapshot.data?.products;
          return GridView.builder(
            padding: const EdgeInsets.only(right: 15, left: 15),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products?.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 3,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              return _buildProductContainer(products, index);
            },
          );
        } else {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
      },
    );
  }

  Widget _buildProductContainer(List<Product>? products, int index) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
                color: AppColors.lightBlack,
                blurRadius: 5,
                blurStyle: BlurStyle.outer,
                spreadRadius: 0),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProductTitle(products, index),
            _buildProductImage(products, index),
            const SizedBox(
              width: 10,
            ),
            _buildProductPrice(products, index),
          ],
        ),
      ),
      onTap: () {
        double? price =
            double.tryParse(products?[index].price.toString() ?? '');
        if (price != null) {
          _addTotalPrice(price);
        }
      },
    );
  }

  Widget _buildProductTitle(List<Product>? products, int index) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.productColor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      height: 40,
      width: double.infinity,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          products?[index].title.toString() ?? '',
          style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
      )),
    );
  }

  Widget _buildProductImage(List<Product>? products, int index) {
    return SizedBox(
      height: 100,
      child:
          Image.network(products?[index].images?.first ?? '', fit: BoxFit.fill),
    );
  }

  Widget _buildProductPrice(List<Product>? products, int index) {
    final price = products?[index].price;
    final formattedPrice = price != null
        ? NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(price)
        : '';
    return Center(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.lightBlack,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(formattedPrice,
                style: const TextStyle(fontWeight: FontWeight.w600)),
          )),
    );
  }

  void _addTotalPrice(double? price) {
    _prodController.totalAmount += price?.toDouble() ?? 0;
    _prodController.totalAmountStreamStreamController(true);
  }

  Widget _buildFloatingActionButton() {
    return StreamBuilder(
      stream: _prodController.totalAmountStream,
      builder: (context, snapshot) => SizedBox(
        width: 300,
        child: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          isExtended: true,
          child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomElevatedButton(
                    buttonText:
                        'Total  ${NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(_prodController.totalAmount)}',
                  ),
                  Container(
                    width: 2,
                    height: 30,
                    color: AppColors.whiteColor,
                  ),
                  CustomElevatedButton(
                    buttonText: 'Order List',
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrderList(),
                        )),
                  )
                ],
              )),
          onPressed: () {},
        ),
      ),
    );
  }
}
