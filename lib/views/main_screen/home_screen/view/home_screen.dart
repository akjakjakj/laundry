import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/eco_dry_clean/model/eco_dry_clean_arguments.dart';
import 'package:laundry/views/main_screen/home_screen/view/widgets/home_image_slider.dart';
import 'package:laundry/views/main_screen/home_screen/view/widgets/home_screen_choose_service_widget.dart';
import 'package:laundry/views/main_screen/home_screen/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../services/route_generator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
              SizedBox(
                height: 50.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Assets.images.logo.image(
                        height: 50.h,
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.pushNamed(context, RouteGenerator.routeCart);
                    //   },
                    //   child: Padding(
                    //       padding: EdgeInsets.only(right: 15.w),
                    //       child:
                    //           Assets.icons.cart.image(height: 30, width: 30)),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                  height: context.sw(size: 1.1.h),
                  child: HomeImageSlider(
                    homeProvider: context.read<HomeProvider>(),
                  )),
              19.verticalSpace,
              Text(
                'CHOOSE OUR SERVICE',
                style: FontPalette.poppinsBold
                    .copyWith(color: ColorPalette.greenColor, fontSize: 15.sp),
              ),
              16.verticalSpace,
              SizedBox(
                height: 95.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChooseServiceWidget(
                      servicesList: context.read<HomeProvider>().servicesList,
                    ),
                    // 30.horizontalSpace,
                    // InkWell(
                    //   // onTap: () {
                    //   //   context.read<PaymentProvider>().payWithCard();
                    //   // },
                    //   onTap: () => Navigator.pushNamed(
                    //     context,
                    //     RouteGenerator.routeEcoDryClean,
                    //     arguments:
                    //         EcoDryCleanArguments(title: '', serviceId: 1),
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       Container(
                    //         height: 65.h,
                    //         width: 65.w,
                    //         alignment: Alignment.center,
                    //         decoration: BoxDecoration(
                    //           shape: BoxShape.circle,
                    //           color: Colors.white,
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: Colors.grey.withOpacity(0.5),
                    //               spreadRadius: 1.r,
                    //               blurRadius: 15.r,
                    //               offset: const Offset(0,
                    //                   2), // changes the position of the shadow
                    //             ),
                    //           ],
                    //         ),
                    //         child: Assets.images.price.image(
                    //           height: 25.h,
                    //           // width: 38.w,
                    //           fit: BoxFit.contain,
                    //         ),
                    //       ),
                    //       10.verticalSpace,
                    //       Text(
                    //         'Price List',
                    //         style: FontPalette.poppinsRegular.copyWith(
                    //             fontSize: 11.sp,
                    //             color: Colors.black,
                    //             fontWeight: FontWeight.w500),
                    //       )
                    //     ],
                    //   ),
                    // ).removeSplash(),
                  ],
                ),
              )
            ],
          )),
        ).withBackgroundImage(),
      ),
    );
  }
}
