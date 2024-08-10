import 'package:ajithkumar_interview/constants/appColors.dart';
import 'package:ajithkumar_interview/screens/home_page/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homePageController = HomePageControllerImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.blueColor,
            pinned: true,
            expandedHeight: 300.0, // Increased height to accommodate the stack
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'lib/assets/images/png_background.png',
                    fit: BoxFit.fill,
                  ),
                  Align(
                    alignment: Alignment(-0.9, -0.3),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20.0), // Adjust positioning
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset('lib/assets/images/png_profile_avatar.png',
                      fit: BoxFit.fill,width: 70, height: 70,)
                    ),
                  ),
                  Align(
                    alignment: Alignment(-0.7, 0.2),
                    child: Container(
                        margin: const EdgeInsets.only(bottom: 20.0), // Adjust positioning
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset('lib/assets/images/png_bubble.png',
                          fit: BoxFit.fill,width: 50, height: 50,)
                    ),
                  ),
                  const Align(
                    alignment: Alignment(-0.3, -0.3),
                    child: Text('Welcome! Muthu', style: TextStyle(fontSize: 18
                    ,fontWeight: FontWeight.w600)),
                  ),
                  Align(
                    alignment: Alignment(0.9, -0.3),
                    child: Container(
                        margin: const EdgeInsets.only(bottom: 20.0), // Adjust positioning
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset('lib/assets/images/png_notification_icon.png',
                          fit: BoxFit.fill,width: 50, height: 50,)
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: Swiper(
                    layout: SwiperLayout.STACK,
                    allowImplicitScrolling: true,
                    axisDirection: AxisDirection.right,
                    scale: 50,
                    itemCount: _homePageController.images.length,
                    itemHeight: 260,
                    itemWidth: 280,
                    duration: 500,
                    loop: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage(_homePageController.images[index]),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
