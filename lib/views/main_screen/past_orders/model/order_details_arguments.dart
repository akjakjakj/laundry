import 'package:laundry/views/main_screen/active_orders/view_model/active_orders_view_model.dart';
import 'package:laundry/views/main_screen/past_orders/model/past_orders_response_model.dart';
import 'package:laundry/views/main_screen/past_orders/view_model/past_orders_view_model.dart';

class OrderDetailsArguments {
  PastOrdersProvider? pastOrdersProvider;
  int? orderId;
  Orders? orders;
  OrderDetailsArguments(
      {this.pastOrdersProvider, this.orderId, required this.orders});
}

class ActiveOrderDetailsArguments {
  ActiveOrdersProvider? activeOrdersProvider;
  int? orderId;
  Orders? orders;
  ActiveOrderDetailsArguments(
      {this.activeOrdersProvider, this.orderId, required this.orders});
}

class InvoiceArguments {
  String? url;
  InvoiceArguments({this.url});
}
