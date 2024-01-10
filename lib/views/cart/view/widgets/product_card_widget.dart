import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/common_widgets/common_fade_in_image.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/cart/view_model/cart_view_model.dart';

class ProductCardWidget extends StatefulWidget {
  const ProductCardWidget(
      {Key? key,
      this.productImage,
      this.productName,
      this.service,
      this.amount,
      this.qty,
      this.cartId,
      required this.cartViewProvider,
      this.index})
      : super(key: key);
  final int? index;
  final String? productImage;
  final String? productName;
  final String? service;
  final int? qty;
  final String? amount;
  final int? cartId;
  final CartViewProvider cartViewProvider;
  @override
  _ProductCardWidgetState createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  late final ValueNotifier<int> quantity;
  Helpers helpers = sl.get<Helpers>();

  @override
  void initState() {
    quantity = ValueNotifier(widget.qty ?? 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: quantity,
      builder: (context, value, child) => Container(
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
                    if (value > 1) {
                      updateCount(value - 1);
                      widget.cartViewProvider.updateCart(
                          cartId: widget.cartId ?? 0,
                          quantity: quantity.value,
                          onSuccess: () {
                            if (widget.index == 0) {
                              widget.cartViewProvider
                                  .getNormalService(enableLoader: false,enableBtnLoader: true);
                            } else {
                              widget.cartViewProvider
                                  .getExpressService(enableLoader: false,enableBtnLoader: true);
                            }

                          },
                          onFailure: () {
                            updateCount(value + 1);
                            helpers
                                .errorToast('Oops...! Something went wrong.');
                          });
                    } else {
                      widget.cartViewProvider.removeFromCart(
                        widget.cartId ?? 0,
                        onSuccess: () {
                          if (widget.index == 0) {
                            widget.cartViewProvider
                                .getNormalService(enableLoader: false,enableBtnLoader: true);
                          } else {
                            widget.cartViewProvider
                                .getExpressService(enableLoader: false,enableBtnLoader: true);
                          }
                        },
                        onFailure: () => helpers
                            .errorToast('Oops...! Something went wrong.'),
                      );
                    }
                  },
                  child: CircleAvatar(
                      radius: 15.r,
                      backgroundColor: ColorPalette.greenColor,
                      child: Text(
                        "-",
                        style: FontPalette.poppinsRegular
                            .copyWith(color: Colors.white, fontSize: 15.sp),
                      )),
                ).removeSplash(),
                10.horizontalSpace,
                Text(
                  "$value",
                  style: FontPalette.poppinsRegular
                      .copyWith(color: Colors.black, fontSize: 15.sp),
                ),
                10.horizontalSpace,
                InkWell(
                  onTap: () {
                    updateCount(value + 1);
                    widget.cartViewProvider.updateCart(
                        cartId: widget.cartId ?? 0,
                        quantity: quantity.value,
                        onSuccess: () {
                          if (widget.index == 0) {
                            widget.cartViewProvider
                                .getNormalService(enableLoader: false);
                          } else {
                            widget.cartViewProvider
                                .getExpressService(enableLoader: false);
                          }

                        },
                        onFailure: () {
                          updateCount(value - 1);
                          helpers.errorToast('Oops...! Something went wrong.');
                        });
                  },
                  child: CircleAvatar(
                      radius: 15.r,
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
      ),
    );
  }

  void updateCount(int count) {
    quantity.value = count;
    print(quantity.value);
  }
}
