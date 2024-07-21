import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/common_widgets/common_fade_in_image.dart';
import 'package:laundry/common_widgets/three_bounce.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/eco_dry_clean/model/products_response_model.dart';
import 'package:laundry/views/eco_dry_clean/view_model/eco_dry_view_model.dart';

class ItemSelectionWidget extends StatefulWidget {
  const ItemSelectionWidget(
      {super.key, this.productItem, required this.ecoDryProvider});
  final Products? productItem;
  final EcoDryProvider ecoDryProvider;

  @override
  State<ItemSelectionWidget> createState() => _ItemSelectionWidgetState();
}

class _ItemSelectionWidgetState extends State<ItemSelectionWidget> {
  late final ValueNotifier<int> quantity;

  late final ValueNotifier<bool> isLoading;
  late final ValueNotifier<bool> isAdded;

  @override
  void initState() {
    isLoading = ValueNotifier(false);
    quantity = ValueNotifier(widget.productItem?.quantity ?? 1);
    isAdded = ValueNotifier(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: quantity,
      builder: (context, quantityValue, child) => Container(
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
                        image: widget.productItem?.image,
                        height: 79.h,
                        width: 86.w),
                    //Assets.images.kidsShoe.image(height: 79.h, width: 86.w),
                  ),
                  10.verticalSpace,
                  Text(
                    widget.productItem?.name ?? '',
                    style: FontPalette.poppinsRegular
                        .copyWith(fontSize: 13.sp, color: Colors.black),
                  ),
                  2.verticalSpace,
                  Text(
                    'AED ${widget.productItem?.rate ?? ''}/Cloth',
                    style: FontPalette.poppinsRegular
                        .copyWith(fontSize: 11.sp, color: HexColor('#404041')),
                  ),
                  5.verticalSpace,
                  //if ((quantityValue) > 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          if (quantity.value > 1) {
                            updateCount(quantityValue - 1);
                          }
                        },
                        child: Container(
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
                      ).removeSplash(),
                      15.horizontalSpace,
                      Text(
                        (quantityValue).toString(),
                        style: FontPalette.poppinsRegular.copyWith(
                            fontSize: 10.sp, color: HexColor('#404041')),
                      ),
                      15.horizontalSpace,
                      InkWell(
                        onTap: () {
                          updateCount(quantityValue + 1);
                        },
                        child: Container(
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
                      ).removeSplash(),
                    ],
                  ),
                  38.verticalSpace,
                ],
              ),
            ),
            // if ((quantityValue) == 0)
            ValueListenableBuilder<bool>(
              valueListenable: isLoading,
              builder: (context, loadingValue, child) => InkWell(
                onTap:
                    (widget.productItem?.isAdded ?? false) ? null : addToCart,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    height: 31.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: ColorPalette.greenColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.r),
                          bottomRight: Radius.circular(10.r),
                        )),
                    child: loadingValue
                        ? ThreeBounce(
                            size: 25.r,
                          )
                        : ValueListenableBuilder<bool>(
                            valueListenable: isAdded,
                            builder: (context, value, child) => Text(
                              (value) ? 'Added' : 'Add',
                              style: FontPalette.poppinsRegular.copyWith(
                                  fontSize: 11.sp, color: Colors.white),
                            ),
                          ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void updateCount(int count) {
    quantity.value = count;
    isAdded.value = false;
  }

  void addToCart({bool isAdd = true}) {
    isLoading.value = true;
    isAdded.value = true;
    // if (isAdd) {
    widget.ecoDryProvider
        .addToCart(
      widget.productItem?.id ?? 0,
      (quantity.value),
      double.parse((widget.productItem?.rate) ?? '0'),
      onSuccess: () => isAdded.value = true,
      onFailure: () => isAdded.value = false,
    )
        .then((value) {
      isLoading.value = false;
      // quantity.value = quantity.value + 1;
    });
    // } else {
    //   widget.ecoDryProvider
    //       .addToCart(
    //     widget.productItem?.id ?? 0,
    //     (widget.productItem?.quantity ?? 0) - 1,
    //     double.parse((widget.productItem?.rate) ?? '0'),
    //     onSuccess: () => widget.productItem?.quantity =
    //         (widget.productItem?.quantity ?? 0) - 1,
    //   )
    //       .then((value) {
    //     isLoading.value = false;
    //     quantity.value = quantity.value - 1;
    //   });
    // }
  }
}

class _AddToCartButton extends StatefulWidget {
  const _AddToCartButton(
      {required this.ecoDryProvider, required this.productItem});
  final EcoDryProvider? ecoDryProvider;
  final Products? productItem;

  @override
  _AddToCartButtonState createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<_AddToCartButton> {
  late final ValueNotifier<bool> isLoading;

  @override
  void initState() {
    isLoading = ValueNotifier(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isLoading,
      builder: (context, value, child) => InkWell(
        onTap: addToCart,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Container(
            height: 31.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ColorPalette.greenColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                )),
            child: value
                ? ThreeBounce(
                    size: 25.r,
                  )
                : Text(
                    'Add',
                    style: FontPalette.poppinsRegular
                        .copyWith(fontSize: 11.sp, color: Colors.white),
                  ),
          ),
        ),
      ),
    );
  }

  void addToCart() {
    isLoading.value = true;
    widget.ecoDryProvider
        ?.addToCart(
      widget.productItem?.id ?? 0,
      (widget.productItem?.quantity ?? 0) + 1,
      double.parse((widget.productItem?.rate) ?? '0'),
      onSuccess: () => widget.productItem?.quantity =
          (widget.productItem?.quantity ?? 0) + 1,
    )
        .then((value) {
      isLoading.value = false;
    });
  }
}
