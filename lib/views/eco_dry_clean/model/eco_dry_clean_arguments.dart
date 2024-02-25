import 'package:laundry/views/eco_dry_clean/view_model/eco_dry_view_model.dart';

class EcoDryCleanArguments {
  int? categoryId;
  String? title;
  int? serviceId;
  EcoDryProvider? ecoDryProvider;

  EcoDryCleanArguments(
      {this.categoryId, this.title, this.serviceId, this.ecoDryProvider});
}

class PriceListScreenArguments {
  int? serviceId;
  EcoDryProvider? ecoDryProvider;

  PriceListScreenArguments({this.serviceId, this.ecoDryProvider});
}
