import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common_widgets/custom_button.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeImageSlider extends StatelessWidget {
  HomeImageSlider({Key? key}) : super(key: key);
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      PageView.builder(
        itemCount: 3,
        controller: pageController,
        itemBuilder: (context, index) {
          return Image.network(
            'https://c.dlnws.com/image/upload/c_limit,f_auto,q_auto,w_1800/v1666098428/Blog/putting_clothes_into_washer.jpg',
            fit: BoxFit.fill,
          );
        },
      ),
      Positioned(
          bottom: 60.h,
          child: CustomButton(
            width: 247.w,
            decoration: BoxDecoration(
                color: ColorPalette.hintColor, borderRadius: BorderRadius.zero),
            title: 'EXPLORE OUR SERVICE',
            textStyle: FontPalette.poppinsBold
                .copyWith(fontSize: 15.sp, color: ColorPalette.greenColor),
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
