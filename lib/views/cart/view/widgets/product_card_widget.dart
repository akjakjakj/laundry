import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/common_widgets/common_fade_in_image.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';

class ProductCardWidget extends StatefulWidget {
  const ProductCardWidget(
      {Key? key,
      this.productImage,
      this.productName,
      this.service,
      this.amount,
      this.qty})
      : super(key: key);
  final String? productImage;
  final String? productName;
  final String? service;
  final int? qty;
  final String? amount;



  @override
  _ProductCardWidgetState createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 97.h,
      width: double.maxFinite,
      padding: EdgeInsets.only(
        right: 10.w,
      ),
      margin: EdgeInsets.only(
        bottom: 10.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: CommonFadeInImage(
                      image: widget.productImage ??
                          "https://i.ebayimg.com/images/g/BYIAAOSwR01jHCuS/s-l500.jpg",
                      fit: BoxFit.cover,
                      height: 97.w,
                      width: 90.w,
                    )),
                20.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        widget.productName ?? "Casual Shirt",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: FontPalette.poppinsRegular
                            .copyWith(color: Colors.black, fontSize: 15.sp),
                      ),
                    ),
                    Text(
                      widget.service ?? "Steam ironing x (1)",
                      style: FontPalette.poppinsRegular.copyWith(
                          color: const Color(0xff404041), fontSize: 11.sp),
                    ),
                    20.verticalSpace,
                    Text(
                      "AED ${widget.amount}",
                      style: FontPalette.poppinsRegular.copyWith(
                          color: const Color(0xff076633), fontSize: 11.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),

          //quanity
          Row(
            children: [
              InkWell(
                onTap: () {
                  if ((widget.qty ?? 0) > 1) {
                    // widget.qty = -1;
                  }
                },
                child: CircleAvatar(
                    radius: 10.r,
                    backgroundColor: ColorPalette.greenColor,
                    child: Text(
                      "-",
                      style: FontPalette.poppinsRegular
                          .copyWith(color: Colors.white, fontSize: 15.sp),
                    )),
              ).removeSplash(),
              10.horizontalSpace,
              Text(
                "${widget.qty}",
                style: FontPalette.poppinsRegular
                    .copyWith(color: Colors.black, fontSize: 15.sp),
              ),
              10.horizontalSpace,
              InkWell(
                onTap: () {
                  // widget.qty = (widget.qty ?? 0) + 1;
                },
                child: CircleAvatar(
                    radius: 10.r,
                    backgroundColor: ColorPalette.greenColor,
                    child: Text(
                      "+",
                      style: FontPalette.poppinsRegular
                          .copyWith(color: Colors.white, fontSize: 15.sp),
                    )),
              ).removeSplash(),
            ],
          ),
        ],
      ),
    );
  }
}
