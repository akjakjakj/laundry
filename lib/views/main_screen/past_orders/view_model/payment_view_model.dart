import 'package:flutter/cupertino.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/payment_service.dart';
import 'package:laundry/services/provider_helper_class.dart';
import 'package:laundry/utils/enums.dart';

class PaymentProvider extends ChangeNotifier with ProviderHelperClass {
  PaymentService paymentService = sl.get<PaymentService>();
  Future<void> payWithCard() async {
    FlutterPaytabsBridge.startCardPayment(paymentService.generateConfig(),
        (event) {
      if (event["status"] == "success") {
        // Handle transaction details here.
        var transactionDetails = event["data"];
        print(transactionDetails);

        if (transactionDetails["isSuccess"]) {
          print("successful transaction");
        } else {
          print("failed transaction");
        }
      } else if (event["status"] == "error") {
        // Handle error here.
      } else if (event["status"] == "event") {
        // Handle cancel events here.
      }
    } );
  }

  @override
  void updateLoadState(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }
}
