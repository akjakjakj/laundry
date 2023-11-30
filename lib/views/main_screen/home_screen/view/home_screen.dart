import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/main_screen/home_screen/view/widgets/home_image_slider.dart';
import 'package:laundry/views/main_screen/home_screen/view/widgets/home_screen_choose_service_widget.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../services/route_generator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
              child: Column(
            children: [
              // 20.verticalSpace,
              Container(
                height: 50.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Assets.images.logo.image(
                        height: 50.h,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteGenerator.routeCart);
                      },
                      child: Padding(
                          padding: EdgeInsets.only(right: 15.w),
                          child:
                              Assets.icons.cart.image(height: 30, width: 30)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: context.sw(size: 1.1.h), child: HomeImageSlider()),
              19.verticalSpace,
              Text(
                'CHOOSE OUR SERVICE',
                style: FontPalette.poppinsBold
                    .copyWith(color: ColorPalette.greenColor, fontSize: 15.sp),
              ),
              16.verticalSpace,
              const ChooseServiceWidget()
            ],
          )),
        ).withBackgroundImage(),
      ),
      // bottomNavigationBar: CurvedNavigationBar(
      //   index: 2,
      //   animationCurve: Curves.easeInOutSine,
      //   height: 75,
      //   color: ColorPalette.primaryColor,
      //   backgroundColor: Colors.white,
      //   items: <Widget>[
      //     Center(
      //         child: Center(
      //             child: Container(
      //                 height: 30,
      //                 width: 30,
      //                 padding: EdgeInsets.all(1),
      //                 child: Assets.icons.order.image(
      //                     height: 30,
      //                     width: 30,
      //                     fit: BoxFit.fill,
      //                     color: Colors.white)))),
      //     Center(
      //         child: Assets.icons.whatsapp.image(
      //             height: 30,
      //             width: 30,
      //             fit: BoxFit.fill,
      //             color: Colors.white)),
      //     Center(
      //         child: Center(
      //             child: Container(
      //                 height: 30,
      //                 width: 30,
      //                 child: Assets.icons.home
      //                     .image(height: 20, width: 20, fit: BoxFit.fill)))),
      //     Center(
      //         child: Assets.icons.male.image(
      //             height: 30,
      //             width: 30,
      //             fit: BoxFit.fill,
      //             color: Colors.white)),
      //     Center(
      //         child: Assets.icons.settings.image(
      //             height: 30,
      //             width: 30,
      //             fit: BoxFit.fill,
      //             color: Colors.white)),
      //   ],
      //   onTap: (index) {
      //     //Handle button tap
      //   },
      // ),
    );
  }
}
