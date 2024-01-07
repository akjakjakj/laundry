import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common_widgets/custom_linear_progress_indicator.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/main_screen/past_orders/view_model/past_orders_view_model.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen(
      {Key? key, required this.pastOrdersProvider, this.orderId})
      : super(key: key);
  final PastOrdersProvider pastOrdersProvider;
  final int? orderId;

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    widget.pastOrdersProvider.getOrderDetails(widget.orderId ?? 0);
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
        value: widget.pastOrdersProvider,
        child:
            Consumer<PastOrdersProvider>(builder: (context, provider, child) {
          switch (provider.loaderState) {
            case LoaderState.loading:
              return const CustomLinearProgress();
            case LoaderState.loaded:
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.verticalSpace,
                      Row(
                        children: [
                          Text(
                            'Cancelled',
                            style: FontPalette.poppinsRegular.copyWith(
                                fontSize: 17.sp, color: HexColor('#F11A1A')),
                          ),
                          const Spacer(),
                          Text(
                            'Order Id: ${provider.orderDetailsModel?.order?.id}',
                            style: FontPalette.poppinsRegular.copyWith(
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
                      const _OrderDetailsTile(
                        title: 'Name',
                        value: '',
                      ),
                      32.verticalSpace,
                      const _OrderDetailsTile(
                        title: 'Address',
                        value: '',
                      ),
                      32.verticalSpace,
                      _OrderDetailsTile(
                        title: 'Pick up details',
                        value: provider.orderDetailsModel?.order?.pickupAt,
                      ),
                      32.verticalSpace,
                      _OrderDetailsTile(
                        title: 'Delivery details',
                        value: provider
                            .orderDetailsModel?.order?.expectedDeliveryDate,
                      ),
                    ],
                  ),
                ),
              );

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
  const _OrderDetailsTile({Key? key, this.title, this.value}) : super(key: key);
  final String? title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      decoration: BoxDecoration(
          color: const Color(0xfff3f3f4),
          borderRadius: BorderRadius.circular(7.r)),
      child: Row(
        children: [
          Text(
            title ?? '',
            style:
                FontPalette.poppinsRegular.copyWith(color: HexColor('#404041')),
          ),
          const Spacer(),
          Text(value ?? '',
              style: FontPalette.poppinsRegular
                  .copyWith(color: HexColor('#404041')))
        ],
      ),
    );
  }
}
