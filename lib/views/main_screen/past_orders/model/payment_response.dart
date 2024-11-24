class PaymentRequestModel {
  int? orderId;
  String? paymentStatus;
  String? amount;
  String? transactionId;
  String? paymentType;
  String? customerName;
  String? phoneNumber;
  String? email;
  PaymentRequestModel(
      {this.email,
      this.amount,
      this.phoneNumber,
      this.orderId,
      this.customerName,
      this.paymentStatus,
      this.paymentType,
      this.transactionId});

  Map<String, dynamic> toJson() => {
        'order_id': orderId,
        'payment_status': paymentStatus,
        'transaction_id': transactionId,
        'total_amount': amount,
        'customer_name': customerName,
        'customer_phone': phoneNumber,
        'customer_email': email,
        'payment_type': paymentType
      };
}

class PaymentRequestModelPos {
  String? pickUpReferenceNumber;
  String? orderId;
  String? paymentStatus;
  String? paymentType;
  String? amount;
  String? contactNumber;

  PaymentRequestModelPos(
      {this.orderId,
      this.paymentType,
      this.paymentStatus,
      this.amount,
      this.contactNumber,
      this.pickUpReferenceNumber});

  Map<String, dynamic> toJson() => {
        'order_id': orderId,
        'pickup_reference_no': pickUpReferenceNumber,
        'payment_status': paymentStatus,
        'payment_type': paymentType,
        'amount': amount,
        'customer_contact_no': contactNumber,
      };
}
