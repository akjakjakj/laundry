import 'package:flutter/material.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common_widgets/custom_button.dart';
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
      required this.pastOrdersProvider});
  final String url;
  final Orders? orders;
  final PastOrdersProvider? pastOrdersProvider;
  @override
  _InvoiceViewState createState() => _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView> {
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
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          children: [
            WebViewWidget(controller: controller),
            if (widget.orders?.paymentStatus?.toLowerCase() != 'completed')
              Selector<PaymentProvider, bool>(
                selector: (context, provider) => provider.btnLoaderState,
                builder: (context, value, child) => CustomButton(
                  title: 'Pay Amount',
                  isLoading: value,
                  onTap: () {
                    context.read<PaymentProvider>().payWithCard(
                          orderId: widget.orders?.id,
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
                            widget.pastOrdersProvider?.helpers
                                .successToast('Payment Successful!');
                            widget.pastOrdersProvider?.getPastOrders().then(
                                (value) => Navigator.popUntil(
                                    context,
                                    (route) =>
                                        route.settings.name ==
                                        RouteGenerator.routeMainScreen));
                          },
                          onFailure: () => widget.pastOrdersProvider?.helpers
                              .errorToast('Payment Failed. Please try again.'),
                        );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
