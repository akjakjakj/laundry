import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common_widgets/custom_button.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/eco_dry_clean/model/eco_dry_clean_arguments.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../common_widgets/common_fade_in_image.dart';

class HomeImageSlider extends StatelessWidget {
  HomeImageSlider({super.key});
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      PageView.builder(
        itemCount: 3,
        controller: pageController,
        itemBuilder: (context, index) {
          return const CommonFadeInImage(
            image:
                'https://media.product.which.co.uk/prod/images/original/gm-2afcf653-d966-4cda-9789-79cd1710023e-ironinglead.jpeg',
            fit: BoxFit.cover,
          );
        },
      ),
      Positioned(
          bottom: 60.h,
          child: CustomButton(
            width: 247.w,
            decoration: const BoxDecoration(
                color: Color(0XFFa7b8c5), borderRadius: BorderRadius.zero),
            title: 'NEW PRICING',
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
          count: 3,
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
