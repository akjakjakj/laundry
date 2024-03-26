import 'package:laundry/views/main_screen/active_orders/view_model/active_orders_view_model.dart';
import 'package:laundry/views/main_screen/past_orders/view_model/past_orders_view_model.dart';

class OrderDetailsArguments {
  PastOrdersProvider? pastOrdersProvider;
  int? orderId;

  OrderDetailsArguments({this.pastOrdersProvider, this.orderId});
}

class ActiveOrderDetailsArguments {
  ActiveOrdersProvider? activeOrdersProvider;
  int? orderId;
  ActiveOrderDetailsArguments({this.activeOrdersProvider, this.orderId});
}
