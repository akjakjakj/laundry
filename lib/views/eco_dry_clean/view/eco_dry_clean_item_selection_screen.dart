import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/common_widgets/custom_button.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/eco_dry_clean/view/widgets/item_selection_widget.dart';

class EcoDryScreenItemSelectionScreen extends StatefulWidget {
  const EcoDryScreenItemSelectionScreen({Key? key}) : super(key: key);

  @override
  _EcoDryScreenItemSelectionScreenState createState() =>
      _EcoDryScreenItemSelectionScreenState();
}

class _EcoDryScreenItemSelectionScreenState
    extends State<EcoDryScreenItemSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            height: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  60.verticalSpace,
                  //const EcoDrySearchBar()
                  SizedBox(
                    height: 42.h,
                    child: SearchBar(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(HexColor('#F3F3F4')),
                      leading: const Icon(Icons.search),
                      hintText: 'Search',
                      hintStyle: MaterialStatePropertyAll<TextStyle>(
                          FontPalette.poppinsRegular.copyWith(
                              fontSize: 14.sp, color: HexColor('#404041'))),
                    ),
                  ),
                  GridView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 23.h,
                        mainAxisExtent: 280.h,
                        crossAxisSpacing: 12.w),
                    itemBuilder: (context, index) =>
                        const ItemSelectionWidget(),
                  ),
                  70.verticalSpace
                ],
              ),
            ),
          ).withBackgroundImage(),
          CustomButton(
            title: 'Go To Cart',
            decoration: BoxDecoration(
                color: ColorPalette.greenColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    topRight: Radius.circular(10.r))),
          )
        ],
      ),
    );
  }
}
