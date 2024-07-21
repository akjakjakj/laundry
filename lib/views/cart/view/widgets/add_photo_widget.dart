import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/cart/view_model/cart_view_model.dart';
import 'package:provider/provider.dart';

class AddPhotoWidget extends StatelessWidget {
  const AddPhotoWidget({super.key, required this.cartViewProvider});
  final CartViewProvider cartViewProvider;
  @override
  Widget build(BuildContext context) {
    return Selector<CartViewProvider, List<List<int>>>(
        selector: (context, cartProvider) => cartProvider.imageFilesList,
        builder: (context, value, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => _showOptions(context),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: ColorPalette.primaryColor,
                        size: 13.h,
                      ),
                      3.horizontalSpace,
                      Text(
                        'Add photos',
                        style: FontPalette.poppinsRegular.copyWith(
                            color: ColorPalette.primaryColor, fontSize: 13.sp),
                      )
                    ],
                  ),
                ).removeSplash(),
                10.verticalSpace,
                if (value.notEmpty) 12.verticalSpace,
                value.notEmpty
                    ? Wrap(
                        runSpacing: 10.h,
                        children: List.generate(
                            value.length,
                            (index) => _ImageView(
                                  imagePath: Uint8List.fromList(value[index]),
                                  onRemoveTapped: () => cartViewProvider
                                      .removeImageFromList(index),
                                )),
                      )
                    : const SizedBox.shrink()
              ],
            ));
  }

  Future _showOptions(
    BuildContext context,
  ) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text(
              'Photo Gallery',
              style: FontPalette.poppinsRegular.copyWith(fontSize: 15.sp),
            ),
            onPressed: () {
              Navigator.pop(context);
              cartViewProvider.getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Camera',
                style: FontPalette.poppinsRegular.copyWith(fontSize: 15.sp)),
            onPressed: () {
              Navigator.pop(context);
              cartViewProvider.getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }
}

class _ImageView extends StatelessWidget {
  const _ImageView(
      {required this.imagePath, required this.onRemoveTapped});
  final Uint8List imagePath;
  final Function()? onRemoveTapped;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          height: 58.h,
          width: 58.w,
          margin: EdgeInsets.only(right: 6.w),
          child: Image.memory(
            imagePath,
            fit: BoxFit.fill,
          ),
        ),
        InkWell(
            onTap: onRemoveTapped,
            child: Container(
                height: 16.h,
                width: 16.w,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.close,
                  size: 7.h,
                ))),
      ],
    );
  }
}
