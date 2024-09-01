class AddAddressRequestModel {
  String? houseNumber;
  String? address;
  String? city;
  String? state;
  String? country;
  double? postalCode;
  double? latitude;
  double? longitude;

  AddAddressRequestModel(
      {this.longitude,
      this.city,
      this.address,
      this.state,
      this.latitude,
      this.country,
      this.postalCode,
      this.houseNumber});
}
