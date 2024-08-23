import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/common_widgets/custom_linear_progress_indicator.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/main_screen/active_orders/view_model/active_orders_view_model.dart';
import 'package:laundry/views/main_screen/past_orders/model/past_orders_response_model.dart';
import 'package:provider/provider.dart';

class ActiveOrdersDetailsScreen extends StatefulWidget {
  const ActiveOrdersDetailsScreen(
      {super.key,
      required this.activeOrdersProvider,
      this.orderId,
      required this.orders});
  final ActiveOrdersProvider activeOrdersProvider;
  final int? orderId;
  final Orders? orders;
  @override
  State<ActiveOrdersDetailsScreen> createState() =>
      _ActiveOrdersDetailsScreenState();
}

class _ActiveOrdersDetailsScreenState extends State<ActiveOrdersDetailsScreen> {
  @override
  void initState() {
    // widget.activeOrdersProvider.getOrderDetails(widget.orderId ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 15.r),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 4,
                        blurStyle: BlurStyle.outer,
                        color: Color.fromARGB(255, 224, 224, 224),
                        spreadRadius: 0.5)
                  ],
                ),
                child: CircleAvatar(
                    radius: 18.r,
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 6.w),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 18.r,
                        ),
                      ),
                    )),
              ),
            ),
          ),
        ),
        title: Text(
          'Order Details',
          style: FontPalette.poppinsBold
              .copyWith(color: Colors.black, fontSize: 17.sp),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: ChangeNotifierProvider.value(
        value: widget.activeOrdersProvider,
        child:
            Consumer<ActiveOrdersProvider>(builder: (context, provider, child) {
          switch (provider.loaderState) {
            case LoaderState.loading:
              return const CustomLinearProgress();
            case LoaderState.loaded:
              return Container(
                height: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.verticalSpace,
                      Row(
                        children: [
                          Text('Order Status : ',
                              style: FontPalette.poppinsRegular.copyWith(
                                  fontSize: 14.sp,
                                  color: ColorPalette.primaryColor)),
                          Text(
                            widget.orders?.orderStatus ?? 'N/A',
                            style: FontPalette.poppinsBold.copyWith(
                                color: HexColor('#404041'), fontSize: 17.sp),
                          ),
                          const Spacer(),
                          Text('Order id : ',
                              style: FontPalette.poppinsRegular.copyWith(
                                  fontSize: 14.sp,
                                  color: ColorPalette.primaryColor)),
                          Text(
                            "#${widget.orders?.id?.toString() ?? 'N/A'}",
                            style: FontPalette.poppinsBold.copyWith(
                                fontSize: 14.sp,
                                color: ColorPalette.primaryColor),
                          )
                        ],
                      ),
                      30.verticalSpace,
                      Text(
                        'Details',
                        style:
                            FontPalette.poppinsBold.copyWith(fontSize: 17.sp),
                      ),
                      25.verticalSpace,
                      _OrderDetailsTile(
                        title: 'Name',
                        value: widget.orders?.customer ?? 'N/A',
                      ),
                      14.verticalSpace,
                      _OrderDetailsTile(
                        title: 'Address',
                        value: widget.orders?.address?.toString() ?? 'N/A',
                      ),
                      14.verticalSpace,
                      _OrderDetailsTile(
                        title: 'Order Date',
                        value: widget.orders?.orderDate ?? 'N/A',
                      ),
                      14.verticalSpace,
                      _OrderDetailsTile(
                        title: 'Pickup Date',
                        value: widget.orders?.pickupDate ?? 'N/A',
                      ),
                      14.verticalSpace,
                      _OrderDetailsTile(
                        title: 'Pickup Time',
                        value: widget.orders?.pickUpTimeSlot ?? 'N/A',
                      ),
                      14.verticalSpace,
                      // _OrderDetailsTile(
                      //   title: 'Delivery details',
                      //   value: provider
                      //       .orderDetailsModel?.order?.expectedDeliveryDate,
                      // ),
                      // 32.verticalSpace,
                      // Text(
                      //   'Total Items',
                      //   style:
                      //       FontPalette.poppinsBold.copyWith(fontSize: 17.sp),
                      // ),
                      // 32.verticalSpace,
                      // _OrderDetailsTile(
                      //   title: 'Total items is',
                      //   value: provider
                      //       .orderDetailsModel?.order?.details?.length
                      //       .toString(),
                      // ),
                      // 25.verticalSpace,
                      // Text(
                      //   'Included Items',
                      //   style:
                      //       FontPalette.poppinsBold.copyWith(fontSize: 17.sp),
                      // ),
                      // 25.verticalSpace,
                      // Container(
                      //   padding: EdgeInsets.symmetric(horizontal: 25.w),
                      //   decoration: BoxDecoration(
                      //       color: const Color(0xfff3f3f4),
                      //       borderRadius: BorderRadius.circular(7.r)),
                      //   child: Column(
                      //     children: [
                      //       15.verticalSpace,
                      //       ListView.separated(
                      //         itemBuilder: (context, index) {
                      //           return Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               Column(
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                 children: [
                      //                   Text(
                      //                     provider.orderDetailsModel?.order
                      //                             ?.details?[index].product ??
                      //                         '',
                      //                     style: FontPalette.poppinsBold
                      //                         .copyWith(fontSize: 14.sp),
                      //                   ),
                      //                   Text(
                      //                     'Stream Ironing x (${provider.orderDetailsModel?.order?.details?[index].quantity})',
                      //                     style: FontPalette.poppinsRegular
                      //                         .copyWith(
                      //                             fontSize: 11.sp,
                      //                             color: HexColor('#404041')),
                      //                   )
                      //                 ],
                      //               ),
                      //               Text(
                      //                 'AED ${provider.orderDetailsModel?.order?.details?[index].amount}',
                      //                 style: FontPalette.poppinsRegular
                      //                     .copyWith(
                      //                         fontSize: 15.sp,
                      //                         color: HexColor('#404041')),
                      //               )
                      //             ],
                      //           );
                      //         },
                      //         separatorBuilder: (context, index) =>
                      //             10.verticalSpace,
                      //         itemCount:
                      //             (provider.orderDetailsModel?.order?.details !=
                      //                     null)
                      //                 ? provider.orderDetailsModel!.order!
                      //                     .details!.length
                      //                 : 0,
                      //         shrinkWrap: true,
                      //         physics: const NeverScrollableScrollPhysics(),
                      //       ),
                      //       20.verticalSpace,
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text(
                      //             'Total (Incl. VAT)',
                      //             style: FontPalette.poppinsRegular.copyWith(
                      //                 fontSize: 13.sp,
                      //                 color: HexColor('#404041')),
                      //           ),
                      //           Text(
                      //             'AED ${provider.orderDetailsModel?.order?.totalCost}',
                      //             style: FontPalette.poppinsBold.copyWith(
                      //                 fontSize: 15.sp,
                      //                 color: HexColor('#404041')),
                      //           )
                      //         ],
                      //       ),
                      //       20.verticalSpace
                      //     ],
                      //   ),
                      // ),
                      // 50.verticalSpace
                    ],
                  ),
                ),
              ).withBackgroundImage();

            case LoaderState.noProducts:
              return Center(
                child: Text(
                  'No orders found',
                  style: FontPalette.poppinsBold,
                ),
              );
            case LoaderState.networkErr:
              return Center(
                child: Text(
                  'Network Error',
                  style: FontPalette.poppinsBold,
                ),
              );
            case LoaderState.error:
              return Center(
                child: Text('Oops...! Error', style: FontPalette.poppinsBold),
              );
            case LoaderState.noData:
              return Center(
                child: Text(
                  'No orders Found',
                  style: FontPalette.poppinsBold,
                ),
              );
          }
        }),
      ),
    );
  }
}

class _OrderDetailsTile extends StatelessWidget {
  const _OrderDetailsTile({this.title, this.value});
  final String? title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? '',
          style:
              FontPalette.poppinsRegular.copyWith(color: HexColor('#404041')),
        ),
        6.verticalSpace,
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.0),
          decoration: BoxDecoration(
              color: const Color(0xfff3f3f4),
              borderRadius: BorderRadius.circular(7.r)),
          child: Text(value ?? '',
              style: FontPalette.poppinsRegular
                  .copyWith(color: HexColor('#404041'))),
        ),
      ],
    );
  }
}
