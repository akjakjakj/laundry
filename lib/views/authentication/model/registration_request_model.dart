import 'package:country_picker/country_picker.dart';

class RegistrationRequestModel {
  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  String? deviceToken;
  String? mobileNumber;
  Country? country;

  RegistrationRequestModel(
      {this.name,
      this.deviceToken,
      this.password,
      this.email,
      this.confirmPassword,
      this.mobileNumber,
      this.country});
}
