import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/common_widgets/custom_button.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/eco_dry_clean/model/eco_dry_clean_arguments.dart';
import 'package:laundry/views/main_screen/home_screen/model/banners_model.dart';
import 'package:laundry/views/main_screen/home_screen/view_model/home_view_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../common_widgets/common_fade_in_image.dart';

class HomeImageSlider extends StatelessWidget {
  HomeImageSlider({super.key, required this.homeProvider});
  final PageController pageController = PageController();
  final HomeProvider homeProvider;
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      PageView.builder(
        itemCount: homeProvider.homeBanners.length,
        controller: pageController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => homeProvider.homeBanners[index].type == 'video'
                ? Navigator.pushNamed(context, RouteGenerator.routeVideoScreen,
                    arguments: BannersArguments(
                        link: homeProvider.homeBanners[index].link ?? ''))
                : null,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CommonFadeInImage(
                  image: homeProvider.homeBanners[index].type == 'video'
                      ? homeProvider.homeBanners[index].thumbnail
                      : homeProvider.homeBanners[index].link,
                  fit: BoxFit.cover,
                ),
                if (homeProvider.homeBanners[index].type == 'video')
                  Container(
                      height: 50.r,
                      width: 50.r,
                      decoration: BoxDecoration(
                          color: Colors.grey[200], shape: BoxShape.circle),
                      child: const Icon(
                        Icons.play_arrow,
                      ))
              ],
            ),
          ).removeSplash();
        },
      ),
      Positioned(
          bottom: 60.h,
          child: CustomButton(
            width: 247.w,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(40.r)),
            title: 'PRICE LIST',
            textStyle: FontPalette.poppinsBold
                .copyWith(fontSize: 15.sp, color: ColorPalette.greenColor),
            onTap: () => Navigator.pushNamed(
              context,
              RouteGenerator.routeEcoDryClean,
              arguments: EcoDryCleanArguments(title: '', serviceId: 1),
            ),
          )),
      Positioned(
        bottom: 20.h,
        child: SmoothPageIndicator(
          controller: pageController,
          count: homeProvider.homeBanners.length,
          effect: ScrollingDotsEffect(
              strokeWidth: 1.0,
              activeStrokeWidth: 1.0,
              paintStyle: PaintingStyle.fill,
              activeDotColor: ColorPalette.greenColor,
              dotColor: Colors.white,
              dotHeight: 7.r,
              dotWidth: 7.r),
        ),
      ),
    ]);
  }
}
