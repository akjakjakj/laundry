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
  List<String>? images;
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
  String? paymentType;
  String? transactionId;
  Invoice? invoice;
  FullAddress? fullAddress;
  AdminReportedData? adminReportedData;
  String? pickUpRiderId;
  String? returnRiderId;
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
      this.paymentStatus,
      this.images,
      this.adminReportedData,
      this.paymentType,
      this.fullAddress,
      this.transactionId,
      this.pickUpRiderId,
      this.returnRiderId});

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
    paymentType = json['payment_type'];
    transactionId = json['transaction_id'];
    pickUpRiderId = json['pick_up_rider_id'];
    returnRiderId = json['return_rider_id'];
    fullAddress = json['full_address'] != null
        ? FullAddress.fromJson(json['full_address'])
        : null;

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
    adminReportedData = json['admin_reported_data'] != null
        ? AdminReportedData.fromJson(json['admin_reported_data'])
        : null;
    images = json['images'].cast<String>();
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

class AdminReportedData {
  List<String>? images;
  String? description;
  String? status;
  AdminReportedData({this.images, this.description, this.status});

  AdminReportedData.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
    description = json['description'];
    status = json['status'];
  }
}

class FullAddress {
  int? id;
  int? customerId;
  String? address;
  String? city;
  String? houseNo;
  String? state;
  String? country;
  String? postalCode;
  String? latitude;
  String? longitude;
  int? isDefault;
  String? createdAt;
  String? updatedAt;

  FullAddress(
      {this.id,
      this.customerId,
      this.address,
      this.city,
      this.houseNo,
      this.state,
      this.country,
      this.postalCode,
      this.latitude,
      this.longitude,
      this.isDefault,
      this.createdAt,
      this.updatedAt});

  FullAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    address = json['address'];
    city = json['city'];
    houseNo = json['house_no'];
    state = json['state'];
    country = json['country'];
    postalCode = json['postal_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class DriverLocationUpdatedEvent {
  final int driverId;
  final double latitude;
  final double longitude;

  DriverLocationUpdatedEvent({
    required this.driverId,
    required this.latitude,
    required this.longitude,
  });

  // Factory method to create an instance from JSON
  factory DriverLocationUpdatedEvent.fromJson(Map<String, dynamic> json) {
    return DriverLocationUpdatedEvent(
      driverId: json['driverId'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
