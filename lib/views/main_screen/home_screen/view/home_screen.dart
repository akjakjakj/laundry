import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/common_widgets/custom_button.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/eco_dry_clean/model/eco_dry_clean_arguments.dart';
import 'package:laundry/views/main_screen/active_orders/model/track_rider_arguments.dart';
import 'package:laundry/views/main_screen/home_screen/view/home_banner_vdo_player.dart';
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
                height: context.sw(size: .16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Assets.images.logo.image(
                        height: context.sw(size: .13),
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
                  height: context.sw(size: 1.2.h),
                  child: VideoScreen(
                    link: context.read<HomeProvider>().homeVdoLink ?? '',
                  )),
              10.verticalSpace,
              Text(
                'CHOOSE OUR SERVICE',
                style: FontPalette.poppinsBold
                    .copyWith(color: ColorPalette.greenColor, fontSize: 15.sp),
              ),
              5.verticalSpace,
              SizedBox(
                height: 95.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChooseServiceWidget(
                      servicesList: context.read<HomeProvider>().servicesList,
                    ),
                  ],
                ),
              ),
              5.verticalSpace,
              CustomButton(
                width: 247.w,
                height: 40.0,
                decoration: BoxDecoration(
                    color: ColorPalette.primaryColor,
                    borderRadius: BorderRadius.circular(40.r)),
                title: 'PRICE LIST',
                textStyle: FontPalette.poppinsBold
                    .copyWith(fontSize: 15.sp, color: Colors.white),
                onTap: () => Navigator.pushNamed(
                  context,
                  RouteGenerator.routeEcoDryClean,
                  arguments: EcoDryCleanArguments(title: '', serviceId: 1),
                ),
              ),
            ],
          )),
        ).withBackgroundImage(),
      ),
    );
  }
}
