import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common_widgets/custom_button.dart';
import 'package:laundry/common_widgets/custom_linear_progress_indicator.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/main_screen/past_orders/model/past_orders_response_model.dart';
import 'package:laundry/views/main_screen/past_orders/view_model/past_orders_view_model.dart';
import 'package:laundry/views/main_screen/past_orders/view_model/payment_view_model.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InvoiceView extends StatefulWidget {
  const InvoiceView(
      {super.key,
      required this.url,
      required this.orders,
      required this.pastOrdersProvider,
      this.onSuccess,
      this.onFailure});
  final String url;
  final Orders? orders;
  final PastOrdersProvider? pastOrdersProvider;
  final Function()? onSuccess;
  final Function()? onFailure;
  @override
  _InvoiceViewState createState() => _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            isLoading.value = true;
          },
          onPageFinished: (String url) {
            isLoading.value = false;
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Invoice',
          style: FontPalette.poppinsBold
              .copyWith(color: Colors.black, fontSize: 17.sp),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: isLoading,
        builder: (context, value, child) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              if (value) const CustomLinearProgress(),
              WebViewWidget(controller: controller),
              if (widget.orders?.paymentStatus?.toLowerCase() != 'completed' &&
                  widget.orders?.invoice != null)
                Selector<PaymentProvider, bool>(
                  selector: (context, provider) => provider.btnLoaderState,
                  builder: (context, value, child) => Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 14.w),
                    child: CustomButton(
                      title: 'Pay Amount',
                      isLoading: value,
                      onTap: () {
                        context.read<PaymentProvider>().payWithCard(
                              orderId: widget.orders?.id,
                              pickUpReferenceNumber:
                                  widget.orders?.pickUpReferenceNumber,
                              amount: double.parse(
                                  widget.orders?.invoice?.netAmount ?? '0.00'),
                              shippingDetails: ShippingDetails(
                                  widget.orders?.customer ?? 'N/A',
                                  widget.orders?.email ?? 'N/A',
                                  widget.orders?.phoneNumber ?? 'N/A',
                                  widget.orders?.address ?? 'N/A',
                                  'eg',
                                  'UAE',
                                  'UAE',
                                  '00000'),
                              billingDetails: BillingDetails(
                                  widget.orders?.customer ?? 'N/A',
                                  widget.orders?.email ?? 'N/A',
                                  widget.orders?.phoneNumber ?? 'N/A',
                                  widget.orders?.address ?? 'N/A',
                                  'eg',
                                  'UAE',
                                  'UAE',
                                  '00000'),
                              onSuccess: () {
                                if (widget.onSuccess != null) {
                                  widget.onSuccess!();
                                }
                              },
                              onFailure: () {
                                if (widget.onFailure != null) {
                                  widget.onFailure!();
                                }
                              },
                            );
                      },
                    ),
                  ),
                ),
              if (widget.orders?.paymentStatus?.toLowerCase() != 'completed' &&
                  widget.orders?.invoice != null &&
                  Platform.isIOS)
                Column(
                  children: [
                    14.verticalSpace,
                    Selector<PaymentProvider, bool>(
                      selector: (context, provider) => provider.btnLoaderState,
                      builder: (context, value, child) => GestureDetector(
                        onTap: () {
                          context.read<PaymentProvider>().payWithApplePay(
                                orderId: widget.orders?.id,
                                pickUpReferenceNumber:
                                    widget.orders?.pickUpReferenceNumber,
                                amount: double.parse(
                                    widget.orders?.invoice?.netAmount ??
                                        '0.00'),
                                shippingDetails: ShippingDetails(
                                    widget.orders?.customer ?? 'N/A',
                                    widget.orders?.email ?? 'N/A',
                                    widget.orders?.phoneNumber ?? 'N/A',
                                    widget.orders?.address ?? 'N/A',
                                    'eg',
                                    'UAE',
                                    'UAE',
                                    '00000'),
                                billingDetails: BillingDetails(
                                    widget.orders?.customer ?? 'N/A',
                                    widget.orders?.email ?? 'N/A',
                                    widget.orders?.phoneNumber ?? 'N/A',
                                    widget.orders?.address ?? 'N/A',
                                    'eg',
                                    'UAE',
                                    'UAE',
                                    '00000'),
                                onSuccess: () {
                                  if (widget.onSuccess != null) {
                                    widget.onSuccess!();
                                  }
                                },
                                onFailure: () {
                                  if (widget.onFailure != null) {
                                    widget.onFailure!();
                                  }
                                },
                              );
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(40.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Image.asset(
                              //   'assets/apple_logo_white.png', // Include a white Apple logo
                              //   height: 20,
                              // ),
                              // 10.horizontalSpace,
                              Text(
                                'Pay with Apple Pay',
                                style: FontPalette.poppinsBold.copyWith(
                                    color: Colors.white, fontSize: 17.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
