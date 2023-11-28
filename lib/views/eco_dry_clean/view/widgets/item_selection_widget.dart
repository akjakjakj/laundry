import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common_widgets/common_fade_in_image.dart';
import 'package:laundry/common_widgets/custom_button.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/eco_dry_clean/model/products_response_model.dart';

class ItemSelectionWidget extends StatelessWidget {
  const ItemSelectionWidget({Key? key, this.productItem}) : super(key: key);
  final Products? productItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 176.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: HexColor('#F3F3F4')),
          color: Colors.white),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            padding: EdgeInsets.only(right: 12.w, left: 12.w, top: 15.h),
            child: Column(
              children: [
                Container(
                  height: 135.h,
                  width: 135.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: HexColor('#F3F3F4')),
                  child: CommonFadeInImage(
                      image: productItem?.image, height: 79.h, width: 86.w),
                  //Assets.images.kidsShoe.image(height: 79.h, width: 86.w),
                ),
                10.verticalSpace,
                Text(
                  productItem?.name ?? '',
                  style: FontPalette.poppinsRegular
                      .copyWith(fontSize: 13.sp, color: Colors.black),
                ),
                2.verticalSpace,
                Text(
                  'AED ${productItem?.rate ?? ''}/Cloth',
                  style: FontPalette.poppinsRegular
                      .copyWith(fontSize: 11.sp, color: HexColor('#404041')),
                ),
                5.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 28.h,
                      width: 28..w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: ColorPalette.greenColor,
                          shape: BoxShape.circle),
                      child: Text(
                        '-',
                        style: FontPalette.poppinsRegular
                            .copyWith(color: Colors.white, fontSize: 19.sp),
                      ),
                    ),
                    15.horizontalSpace,
                    Text(
                      '1',
                      style: FontPalette.poppinsRegular.copyWith(
                          fontSize: 10.sp, color: HexColor('#404041')),
                    ),
                    15.horizontalSpace,
                    Container(
                      height: 28.h,
                      width: 28..w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: ColorPalette.greenColor,
                          shape: BoxShape.circle),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 15.h,
                      ),
                    ),
                  ],
                ),
                38.verticalSpace,
              ],
            ),
          ),
          CustomButton(
            height: 31.h,
            title: 'Add',
            textStyle: FontPalette.poppinsRegular
                .copyWith(fontSize: 11.sp, color: Colors.white),
            decoration: BoxDecoration(
                color: ColorPalette.greenColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                )),
          )
        ],
      ),
    );
  }
}
