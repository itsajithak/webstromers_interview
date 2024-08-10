import 'package:ajithkumar_interview/components/curved_edges.dart';
import 'package:ajithkumar_interview/components/custom_elevated_button.dart';
import 'package:ajithkumar_interview/constants/appColors.dart';
import 'package:ajithkumar_interview/screens/home_page/home_page.dart';
import 'package:ajithkumar_interview/screens/order_list/order_list_controller.dart';
import 'package:flutter/material.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> with TickerProviderStateMixin {
  final orderListController = OrderListControllerImpl();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // _tabController.animateTo(1);
  }

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
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                color: AppColors.whiteColor,
                              )),
                          Text(
                            'Order List',
                            style: TextStyle(
                                fontSize: 18,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      CustomElevatedButton(
                        buttonText: 'Pending order',
                        buttonColor: AppColors.whiteColor,
                        textColor: AppColors.redColor,
                      )
                    ],
                  )),
            ),
          ),
          _buildTodayOrderAndTomorrowOrderTab(),
          // SizedBox(height: 20,),
          _buildTodayOrderAndTomorrowOrderTabView(),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return StreamBuilder(
      stream: null,
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
                  const CustomElevatedButton(
                    buttonText: 'Clear All',
                  ),
                  Container(
                    width: 2,
                    height: 30,
                    color: AppColors.whiteColor,
                  ),
                  CustomElevatedButton(
                    buttonText: 'Confirm Order',
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        )),
                  )
                ],
              )),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _buildTodayOrderAndTomorrowOrderTab() {
    return TabBar(
        dividerHeight: 0,
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: AppColors.whiteColor,
        indicatorPadding: const EdgeInsets.all(-10),
        indicatorWeight: 2,
        indicatorColor: AppColors.primaryColor,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primaryColor),
        controller: _tabController,
        tabs: const [
          Text('Today\'s order',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
          Text('Tomorrow\'s order',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
        ]);
  }

  Widget _buildTodayOrderAndTomorrowOrderTabView() {
    return Expanded(
      child: TabBarView(controller: _tabController, children: [
        _buildTodaysOrderList(),
        _buildTodaysOrderList(),
      ]),
    );
  }

  Widget _buildTodaysOrderList() {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: Column(
        children: [
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: AppColors.lightGrey)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete,
                          color: AppColors.redColor,
                        ),
                      ),
                      _buildTextWidget('ProductName'),
                      _buildTextWidget('count'),
                      Checkbox(
                        value: true,
                        onChanged: (value) {},
                      ),
                      _buildTextWidget('₹ 100'),
                    ],
                  ),
                );
              },
            ),
          ),
          _buildTotalAmount(),
        ],
      ),
    );
  }

  Widget _buildTotalAmount() {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.lightGrey)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTextWidget('Total'),
          _buildTextWidget('₹ 500'),
        ],
      ),
    );
  }

  Widget _buildTextWidget(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    );
  }
}
