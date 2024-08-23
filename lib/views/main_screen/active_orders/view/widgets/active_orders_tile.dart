import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/main_screen/active_orders/view_model/active_orders_view_model.dart';
import 'package:laundry/views/main_screen/past_orders/model/order_details_arguments.dart';
import 'package:laundry/views/main_screen/past_orders/model/past_orders_response_model.dart';

class ActiveOrdersTile extends StatelessWidget {
  const ActiveOrdersTile(
      {super.key, required this.ordersList, this.activeOrdersProvider});
  final List<Orders> ordersList;
  final ActiveOrdersProvider? activeOrdersProvider;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: ordersList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => InkWell(
        onTap: () => Navigator.pushNamed(
            context, RouteGenerator.routeActiveOrderDetails,
            arguments: ActiveOrderDetailsArguments(
                orderId: ordersList[index].id,
                activeOrdersProvider: activeOrdersProvider,
                orders: ordersList[index])),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: ColorPalette.hintColor, width: 1.5.h)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Order ID : #${ordersList[index].id}',
                    style: FontPalette.poppinsRegular.copyWith(
                        fontSize: 11.sp,
                        color: HexColor('#000000'),
                        fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Text(
                    ordersList[index].orderDate ?? '',
                    style: FontPalette.poppinsRegular.copyWith(
                        fontSize: 11.sp,
                        color: ColorPalette.greenColor,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              10.verticalSpace,
              Text(
                'Address :  ${ordersList[index].address.toString()}',
                style: FontPalette.poppinsRegular.copyWith(
                    fontSize: 11.sp,
                    color: HexColor('#000000'),
                    fontWeight: FontWeight.w500),
              ),
              10.verticalSpace,
              Text(
                'Pickup Date : ${ordersList[index].pickupDate ?? 'N/A'}',
                style: FontPalette.poppinsRegular.copyWith(
                    fontSize: 11.sp,
                    color: HexColor('#000000'),
                    fontWeight: FontWeight.w500),
              ),
              10.verticalSpace,
              Text(
                'Pickup Time Slot : ${ordersList[index].pickUpTimeSlot ?? 'N/A'}',
                style: FontPalette.poppinsRegular.copyWith(
                    fontSize: 11.sp,
                    color: HexColor('#000000'),
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
      separatorBuilder: (context, index) => 30.verticalSpace,
    );
  }
}
