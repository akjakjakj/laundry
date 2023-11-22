class RegistrationRequestModel {
  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  String? deviceToken;

  RegistrationRequestModel(
      {this.name,
      this.deviceToken,
      this.password,
      this.email,
      this.confirmPassword});
}
