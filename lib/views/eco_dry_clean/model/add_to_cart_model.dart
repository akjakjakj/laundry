class AddToCartModel {
  int? serviceId;
  int? categoryId;
  int? productId;
  int? quantity;
  double? rate;

  AddToCartModel(
      {this.quantity,
      this.rate,
      this.categoryId,
      this.productId,
      this.serviceId});
}
