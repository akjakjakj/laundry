import 'package:laundry/views/main_screen/past_orders/view_model/past_orders_view_model.dart';

class OrderDetailsArguments {
  PastOrdersProvider? pastOrdersProvider;
  int? orderId;

  OrderDetailsArguments({this.pastOrdersProvider, this.orderId});
}
