import 'order_details_model.dart';

class PastOrdersResponse {
  bool? status;
  List<Orders>? orders;
  String? message;

  PastOrdersResponse({this.status, this.orders, this.message});

  PastOrdersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class Orders {
  int? id;
  String? orderNumber;
  String? category;
  String? product;
  int? quantity;
  String? date;
  List<Details>? details;
  List<String>? productsName;
  String? branch;
  dynamic address;
  String? orderDate;
  String? createdDate;
  String? pickupDate;
  String? pickUpTimeSlot;
  String? customer;
  String? phoneNumber;
  String? email;
  String? orderStatus;
  String? paymentStatus;
  Invoice? invoice;
  Orders(
      {this.id,
      this.orderNumber,
      this.category,
      this.product,
      this.quantity,
      this.date,
      this.details,
      this.productsName,
      this.pickUpTimeSlot,
      this.orderDate,
      this.pickupDate,
      this.createdDate,
      this.address,
      this.branch,
      this.customer,
      this.orderStatus,
      this.phoneNumber,
      this.invoice,
      this.email,
      this.paymentStatus});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    category = json['category'];
    product = json['product'];
    quantity = json['quantity'];
    date = json['date'];
    customer = json['customer'];
    phoneNumber = json['contact_number'];
    email = json['email'];
    branch = json['branch'];
    address = json['address'];
    orderDate = json['order_date'];
    createdDate = json['created_date'];
    pickupDate = json['pickup_date'];
    pickUpTimeSlot = json['pickup_time_slot'];
    orderStatus = json['order_status'];
    paymentStatus = json['payment_status'];
    if (json['details'] != null) {
      details = <Details>[];
      productsName = [];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
        productsName!.add(v['product']);
      });
    }
    if (json['invoice'] != null) {
      invoice = Invoice.fromJson(json['invoice']);
    }
  }
}

class Invoice {
  int? id;
  String? orderId;
  String? totalBillNumber;
  String? subTotal;
  String? discountAmount;
  String? totalAmount;
  String? taxAmount;
  String? netAmount;
  String? invoiceNumber;

  Invoice(
      {this.id,
      this.orderId,
      this.discountAmount,
      this.netAmount,
      this.subTotal,
      this.taxAmount,
      this.totalAmount,
      this.totalBillNumber,
      this.invoiceNumber});

  Invoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    totalBillNumber = json['total_bill_no'];
    discountAmount = json['discount_amount'];
    netAmount = json['net_amount'];
    subTotal = json['sub_total'];
    taxAmount = json['tax_amount'];
    totalAmount = json['total_amount'];
    invoiceNumber = json['pos_order_id'];
  }
}
