import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/common_widgets/custom_button.dart';
import 'package:laundry/common_widgets/custom_linear_progress_indicator.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/main_screen/past_orders/model/order_details_arguments.dart';
import 'package:laundry/views/main_screen/past_orders/model/past_orders_response_model.dart';
import 'package:laundry/views/main_screen/past_orders/view_model/past_orders_view_model.dart';
import 'package:provider/provider.dart';

import '../view_model/payment_view_model.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen(
      {super.key,
      required this.pastOrdersProvider,
      this.orderId,
      required this.orders});
  final PastOrdersProvider pastOrdersProvider;
  final int? orderId;
  final Orders? orders;

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    // widget.pastOrdersProvider.getOrderDetails(widget.orderId ?? 0);
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
                        ],
                      ),
                      10.verticalSpace,
                      Row(
                        children: [
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
                      14.verticalSpace,
                      Text(
                        'Details',
                        style:
                            FontPalette.poppinsBold.copyWith(fontSize: 17.sp),
                      ),
                      14.verticalSpace,
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
                      if (widget.orders?.adminReportedData != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            14.verticalSpace,
                            _OrderDetailsTile(
                              title: 'Comments from Branch',
                              value: widget
                                      .orders?.adminReportedData?.description ??
                                  'N/A',
                            ),
                            10.verticalSpace,
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              alignment: WrapAlignment.start,
                              runSpacing: 10.h,
                              spacing: 10.w,
                              children: List.generate(
                                  (widget.orders?.adminReportedData?.images ??
                                          [])
                                      .length, (index) {
                                return Container(
                                  height: 100.r,
                                  width: 100.r,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(20.r)),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.orders?.adminReportedData
                                            ?.images?[index] ??
                                        '',
                                    height: 100.r,
                                    width: 100.r,
                                  ),
                                );
                              }),
                            ),
                            10.verticalSpace,
                            _OrderDetailsTile(
                              title: 'Status',
                              value: widget.orders?.adminReportedData?.status ??
                                  'N/A',
                            ),
                          ],
                        ),
                      14.verticalSpace,
                      if (widget.orders?.invoice != null)
                        Column(
                          children: [
                            _OrderDetailsTile(
                              title: 'Invoice Id',
                              value: widget.orders?.invoice?.totalBillNumber ??
                                  'N/A',
                            ),
                            14.verticalSpace,
                            _OrderDetailsTile(
                              title: 'Invoice Id',
                              value: widget.orders?.invoice?.totalBillNumber ??
                                  'N/A',
                            ),
                            14.verticalSpace,
                            _OrderDetailsTile(
                              title: 'Sub Total',
                              value: widget.orders?.invoice?.subTotal ?? 'N/A',
                            ),
                            14.verticalSpace,
                            _OrderDetailsTile(
                              title: 'Tax Amount',
                              value: widget.orders?.invoice?.taxAmount ?? 'N/A',
                            ),
                            14.verticalSpace,
                            if (widget.orders?.invoice?.discountAmount !=
                                    null &&
                                (widget.orders?.invoice?.discountAmount !=
                                    '0.00'))
                              _OrderDetailsTile(
                                title: 'Discount Amount',
                                value: widget.orders?.invoice?.discountAmount ??
                                    'N/A',
                              ),
                            if (widget.orders?.invoice?.discountAmount !=
                                    null &&
                                (widget.orders?.invoice?.discountAmount !=
                                    '0.00'))
                              14.verticalSpace,
                            _OrderDetailsTile(
                              title: 'Net Amount',
                              value: widget.orders?.invoice?.netAmount ?? 'N/A',
                            ),
                            14.verticalSpace,
                            CustomButton(
                              title: 'View invoice',
                              onTap: () => Navigator.pushNamed(
                                  context, RouteGenerator.routeInvoiceView,
                                  arguments: InvoiceArguments(
                                      url:
                                          'https://ledegraissage-online-v2.azureposae.com/view/invoice-v3/html?order_id=${widget.orders?.invoice?.invoiceNumber}')),
                            ),
                            14.verticalSpace,
                            if (widget.orders?.paymentStatus?.toLowerCase() !=
                                'completed')
                              Selector<PaymentProvider, bool>(
                                selector: (context, provider) =>
                                    provider.btnLoaderState,
                                builder: (context, value, child) =>
                                    CustomButton(
                                  title: 'Pay Amount',
                                  isLoading: value,
                                  onTap: () {
                                    context.read<PaymentProvider>().payWithCard(
                                          orderId: widget.orders?.id,
                                          amount: double.parse(widget
                                                  .orders?.invoice?.netAmount ??
                                              '0.00'),
                                          shippingDetails: ShippingDetails(
                                              widget.orders?.customer ?? 'N/A',
                                              widget.orders?.email ?? 'N/A',
                                              widget.orders?.phoneNumber ??
                                                  'N/A',
                                              widget.orders?.address ?? 'N/A',
                                              'eg',
                                              'UAE',
                                              'UAE',
                                              '00000'),
                                          billingDetails: BillingDetails(
                                              widget.orders?.customer ?? 'N/A',
                                              widget.orders?.email ?? 'N/A',
                                              widget.orders?.phoneNumber ??
                                                  'N/A',
                                              widget.orders?.address ?? 'N/A',
                                              'eg',
                                              'UAE',
                                              'UAE',
                                              '00000'),
                                          onSuccess: () {
                                            widget.pastOrdersProvider.helpers
                                                .successToast(
                                                    'Payment Successful!');
                                            widget.pastOrdersProvider
                                                .getPastOrders()
                                                .then((value) =>
                                                    Navigator.popUntil(
                                                        context,
                                                        (route) =>
                                                            route.settings
                                                                .name ==
                                                            RouteGenerator
                                                                .routeMainScreen));
                                          },
                                          onFailure: () => widget
                                              .pastOrdersProvider.helpers
                                              .errorToast(
                                                  'Payment Failed. Please try again.'),
                                        );
                                  },
                                ),
                              ),
                            30.verticalSpace
                          ],
                        )
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
