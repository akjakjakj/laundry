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
import 'package:laundry/views/main_screen/active_orders/view_model/active_orders_view_model.dart';
import 'package:laundry/views/main_screen/past_orders/model/order_details_arguments.dart';
import 'package:laundry/views/main_screen/past_orders/model/past_orders_response_model.dart';
import 'package:laundry/views/main_screen/past_orders/view_model/payment_view_model.dart';
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

  // @override
  // void dispose() {
  //   widget.activeOrdersProvider.adminCommentStatus = null;
  //   super.dispose();
  // }

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
                                color: HexColor('#404041'), fontSize: 14.sp),
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
                          ),
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
                            widget.orders?.adminReportedData?.status == null &&
                                    widget.activeOrdersProvider
                                            .adminCommentStatus ==
                                        null
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _RejectButton(
                                          activeOrdersProvider:
                                              widget.activeOrdersProvider,
                                          orderId: (widget.orders?.id ?? 0)
                                              .toString()),
                                      _ApproveButton(
                                          activeOrdersProvider:
                                              widget.activeOrdersProvider,
                                          orderId: (widget.orders?.id ?? 0)
                                              .toString()),
                                    ],
                                  )
                                : _OrderDetailsTile(
                                    title: 'Status',
                                    value: widget.orders?.adminReportedData
                                            ?.status ??
                                        widget.activeOrdersProvider
                                            .adminCommentStatus ??
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
                                            widget.activeOrdersProvider.helpers
                                                .successToast(
                                                    'Payment Successful!');
                                            widget.activeOrdersProvider
                                                .getActiveOrders()
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
                                              .activeOrdersProvider.helpers
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

class _ApproveButton extends StatefulWidget {
  const _ApproveButton(
      {required this.activeOrdersProvider, required this.orderId});
  final ActiveOrdersProvider activeOrdersProvider;
  final String? orderId;
  @override
  State<_ApproveButton> createState() => _ApproveButtonState();
}

class _ApproveButtonState extends State<_ApproveButton> {
  ValueNotifier isLoading = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isLoading,
      builder: (context, value, child) => CustomButton(
        width: 150.w,
        height: 40.0,
        title: 'Approve',
        isLoading: value,
        onTap: () {
          isLoading.value = true;
          widget.activeOrdersProvider.updateAdminCommentStatus(
            orderId: widget.orderId ?? '',
            status: 'Approved',
            onFailure: () {
              isLoading.value = false;
              widget.activeOrdersProvider.helpers.errorToast(
                  widget.activeOrdersProvider.message ??
                      'Oops... Something went wrong');
            },
            onSuccess: () {
              isLoading.value = false;
              widget.activeOrdersProvider.helpers.successToast(
                  widget.activeOrdersProvider.message ??
                      'Successfully updated');
            },
          );
        },
      ),
    );
  }
}

class _RejectButton extends StatefulWidget {
  const _RejectButton(
      {required this.activeOrdersProvider, required this.orderId});
  final ActiveOrdersProvider activeOrdersProvider;
  final String? orderId;
  @override
  State<_RejectButton> createState() => _RejectButtonState();
}

class _RejectButtonState extends State<_RejectButton> {
  @override
  Widget build(BuildContext context) {
    ValueNotifier isLoading = ValueNotifier<bool>(false);
    return ValueListenableBuilder(
      valueListenable: isLoading,
      builder: (context, value, child) => CustomButton(
        width: 150.w,
        height: 40.0,
        title: 'Reject',
        color: ColorPalette.errorBorderColor,
        isLoading: value,
        onTap: () {
          isLoading.value = true;
          widget.activeOrdersProvider.updateAdminCommentStatus(
            orderId: widget.orderId ?? '',
            status: 'Rejected',
            onFailure: () {
              isLoading.value = false;
              widget.activeOrdersProvider.helpers.errorToast(
                  widget.activeOrdersProvider.message ??
                      'Oops... Something went wrong');
            },
            onSuccess: () {
              isLoading.value = false;
              widget.activeOrdersProvider.helpers.successToast(
                  widget.activeOrdersProvider.message ??
                      'Successfully updated');
            },
          );
        },
      ),
    );
  }
}
