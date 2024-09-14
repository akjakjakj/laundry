import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/payment_service.dart';
import 'package:laundry/services/provider_helper_class.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/views/main_screen/past_orders/model/payment_response.dart';
import 'package:laundry/views/main_screen/past_orders/repo/past_orders_repo.dart';

class PaymentProvider extends ChangeNotifier with ProviderHelperClass {
  PaymentService paymentService = sl.get<PaymentService>();
  bool isLoading = false;
  PastOrdersRepo pastOrdersRepo = sl.get<PastOrdersRepo>();
  Future<void> payWithCard(
      {required ShippingDetails shippingDetails,
      required BillingDetails billingDetails,
      required double amount,
      required int? orderId,
      Function()? onSuccess,
      Function()? onFailure}) async {
    updateBtnLoader(true);
    FlutterPaytabsBridge.startCardPayment(
        paymentService.generateConfig(
            billingDetails: billingDetails,
            shippingDetails: shippingDetails,
            amount: amount), (event) {
      updateBtnLoader(false);
      if (event["status"] == "success") {
        // Handle transaction details here.

        var transactionDetails = event["data"];

        if (transactionDetails["isSuccess"]) {
          pastOrdersRepo
              .updateTransactionDetails(PaymentRequestModel(
                  amount: transactionDetails["cartAmount"],
                  orderId: orderId,
                  customerName: billingDetails.name,
                  email: billingDetails.email,
                  phoneNumber: billingDetails.phone,
                  paymentType: 'PayTabs',
                  paymentStatus: 'Completed',
                  transactionId: transactionDetails['transactionReference']))
              .fold((left) {
            if (onFailure != null) onFailure();
            updateBtnLoader(false);
          }, (right) {
            if (onSuccess != null) onSuccess();
            updateBtnLoader(false);
          }).onError((error, stackTrace) {
            if (onFailure != null) onFailure();
            updateBtnLoader(false);
          });

          print("successful transaction");
        } else {
          updateBtnLoader(false);
          print("failed transaction");
          if (onFailure != null) onFailure();
        }
      } else if (event["status"] == "error") {
        updateBtnLoader(false);
        if (onFailure != null) onFailure();
        // Handle error here.
      } else if (event["status"] == "event") {
        updateBtnLoader(false);
        // Handle cancel events here.
      }
    });
  }

  void updateBtnLoader(bool value) {
    btnLoaderState = value;
    notifyListeners();
  }

  @override
  void updateLoadState(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }
}
