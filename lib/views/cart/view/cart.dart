import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/cart/view/widgets/normal_service.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 1, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.only(left: 15.r),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Center(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 4,
                          blurStyle: BlurStyle.outer,
                          color: Color.fromARGB(255, 224, 224, 224),
                          spreadRadius: 0.5)
                    ],
                  ),
                  child: CircleAvatar(
                      radius: 18.r,
                      backgroundColor: Colors.white,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 6.w),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                            size: 18.r,
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ),
          title: Text(
            "Cart",
            style: FontPalette.poppinsBold
                .copyWith(color: Colors.black, fontSize: 17.sp),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  TabBar(
                    controller: tabController,
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                            width: 3.w, color: Colors.transparent),
                        insets: EdgeInsets.symmetric(
                            horizontal: 50.w, vertical: -10.h)),
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Text(
                        "",
                        style: FontPalette.poppinsBold.copyWith(
                            color: ColorPalette.greenColor, fontSize: 15.sp),
                      ),
                      // Text(
                      //   "Express Service",
                      //   style: FontPalette.poppinsBold.copyWith(
                      //       color: ColorPalette.greenColor, fontSize: 15.sp),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            controller: tabController,
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    NormalService(
                      index: tabController.index,
                    )
                  ],
                ),
              ),
              // Center(
              //   child: Column(
              //     children: <Widget>[
              //       NormalService(
              //         index: tabController.index,
              //       )
              //     ],
              //   ),
              // )
            ],
          ).withBackgroundImage(),
        ));
  }
}