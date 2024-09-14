import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTokenFormat.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTokeniseType.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTransactionType.dart';

class PaymentService {
  BillingDetails billingDetails = BillingDetails(
      "John Smith",
      "email@domain.com",
      "+97311111111",
      "st. 12",
      "eg",
      "dubai",
      "dubai",
      "12345");
  ShippingDetails shippingDetails = ShippingDetails(
      "John Smith",
      "email@domain.com",
      "+97311111111",
      "st. 12",
      "eg",
      "dubai",
      "dubai",
      "12345");
  PaymentSdkConfigurationDetails generateConfig(
      {ShippingDetails? shippingDetails,
      BillingDetails? billingDetails,
      int? customerId,
      required double amount}) {
    var configuration = PaymentSdkConfigurationDetails(

        ///live
        profileId: "93879",
        serverKey: "S2JND2JG9T-JDHGWHHDZM-6KBDRZDNZR",
        clientKey: "C6KMBB-72H96D-HTVHHD-RNBR7N",

        ///test
        // profileId: "93721",
        // serverKey: "SLJND2JGR2-JDHBDLZRWM-LHKMDWBZLR",
        // clientKey: "C2KMBB-727N6D-H2DB9R-BBBB2H",
        cartId: "cart id",
        cartDescription: "cart desc",
        merchantName: "Le degraissage laundry",
        screentTitle: "Pay with Card",
        locale: PaymentSdkLocale
            .DEFAULT, //PaymentSdkLocale.AR or PaymentSdkLocale.DEFAULT
        amount: amount,
        currencyCode: "AED",
        merchantCountryCode: "AE",
        billingDetails: billingDetails,
        shippingDetails: shippingDetails,
        expiryTime: 120);
    configuration.transactionType = PaymentSdkTransactionType.SALE;
    configuration.tokeniseType = PaymentSdkTokeniseType.MERCHANT_MANDATORY;
    configuration.tokenFormat = PaymentSdkTokenFormat.AlphaNum20Format;
    return configuration;
  }
}
