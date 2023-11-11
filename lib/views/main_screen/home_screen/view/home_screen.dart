import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/main_screen/home_screen/view/widgets/home_image_slider.dart';
import 'package:laundry/views/main_screen/home_screen/view/widgets/home_screen_choose_service_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(height: context.sw(size: 1.3.h), child: HomeImageSlider()),
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
    );
  }
}
