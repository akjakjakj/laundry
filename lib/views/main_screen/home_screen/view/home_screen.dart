import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/main_screen/home_screen/view/widgets/home_image_slider.dart';
import 'package:laundry/views/main_screen/home_screen/view/widgets/home_screen_choose_service_widget.dart';
import 'package:laundry/views/main_screen/home_screen/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

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
              SizedBox(
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
              SizedBox(
                height: 95.h,
                child: ChooseServiceWidget(
                  servicesList: context.read<HomeProvider>().servicesList,
                ),
              )
            ],
          )),
        ).withBackgroundImage(),
      ),
    );
  }
}
