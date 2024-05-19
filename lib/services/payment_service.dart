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
  PaymentSdkConfigurationDetails generateConfig() {
    var configuration = PaymentSdkConfigurationDetails(
        profileId: "93721",
        serverKey: "SLJND2JGR2-JDHBDLZRWM-LHKMDWBZLR",
        clientKey: "C2KMBB-727N6D-H2DB9R-BBBB2H",
        cartId: "cart id",
        cartDescription: "cart desc",
        merchantName: "merchant name",
        screentTitle: "Pay with Card",
        locale: PaymentSdkLocale
            .DEFAULT, //PaymentSdkLocale.AR or PaymentSdkLocale.DEFAULT
        amount: 1000,
        currencyCode: "AED",
        merchantCountryCode: "AE",
        billingDetails: BillingDetails("John Smith", "email@domain.com",
            "+97311111111", "st. 12", "eg", "dubai", "dubai", "12345"),
        shippingDetails: ShippingDetails("John Smith", "email@domain.com",
            "+97311111111", "st. 12", "eg", "dubai", "dubai", "12345"),
        expiryTime: 120);
    configuration.transactionType = PaymentSdkTransactionType.SALE;
    configuration.tokeniseType = PaymentSdkTokeniseType.MERCHANT_MANDATORY;
    configuration.tokenFormat = PaymentSdkTokenFormat.AlphaNum20Format;
    return configuration;
  }
}
