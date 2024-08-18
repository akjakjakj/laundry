import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'enums.dart';

class Validator {
  String? validateMobile(BuildContext context, String? value,
      {int? maxLength, String? msg}) {
    String pattern = r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$';
    RegExp regExp = RegExp(pattern);
    if (msg != null) return msg;
    if ((value ?? '').isEmpty) return "This field can't be empty";
    if (!regExp.hasMatch(value!)
        // ||
        // (maxLength != null && value.length != maxLength)
        ) {
      return 'Enter valid mobile number.';
    }
    return null;
  }

  bool validateIsMobileNumber(String value) {
    String pattern = r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  String? validateMobileNoLimit(BuildContext context, String? value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{8,10}$)';
    RegExp regExp = RegExp(pattern);
    if ((value ?? '').isEmpty) return "This field can't be empty";
    if (!regExp.hasMatch(value!) || value.isEmpty) {
      return 'Enter valid mobile number';
    }
    return null;
  }

  String? validateName(BuildContext context, String? value, {int? length}) {
    if (value == null || value.isEmpty) {
      return "This field can't be empty";
    } else if (value.length < (length ?? 3)) {
      return 'Name should contain 3 characters';
    }
    return null;
  }

  String? validateEmptyField(
    BuildContext context,
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return "This field can't be empty";
    }
    return null;
  }

  // String? validateOtp(BuildContext context, String? value, {String? msg}) {
  //   if (msg.notEmpty) return msg;
  //   if (value == null || value.isEmpty) {
  //     return context.loc.emptyStringMsg;
  //   } else if (value.length < 4) {
  //     return context.loc.invalidOtpMsg;
  //   }
  //   return null;
  // }

  String? validateLastName(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return "This field can't be empty";
    } else if (value.contains(RegExp(r'[0-9]')) ||
        value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Enter a valid name.';
    }
    return null;
  }

  String? validateText(BuildContext context, String value) {
    return (value.trim().isEmpty) ? "This field can't be empty" : null;
  }

  // String? validateInvalidateOtp(BuildContext context, String? value) {
  //   if (value == null || value.isEmpty) {
  //     return context.loc.emptyStringMsg;
  //   } else if (value.length != 6) {
  //     return context.loc.invalidOtpMsg;
  //   }
  //   return null;
  // }

  String? validatePassword(BuildContext context, String? value, {String? msg}) {
    String errorMsg =
        'The password must contain at least 8 characters and should include lowercase, uppercase, digits, and special characters.';
    if ((msg ?? '').isNotEmpty) {
      return msg;
    } else if ((value ?? '').isEmpty) {
      return "This field can't be empty";
    } else if (value!.length < 8) {
      return errorMsg;
    } else if (!value.contains(RegExp(r'[0-9]'))) {
      return errorMsg;
    } else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return errorMsg;
    } else if (!value.contains(RegExp(r'[A-Z]'))) {
      return errorMsg;
    }
    return null;
  }

  String? validateConfirmPassword(
      BuildContext context, String? value, String newPassword) {
    if ((value ?? '').isEmpty) {
      return "This field can't be empty";
    } else if (value != newPassword) {
      return 'The password confirmation does not match.';
    }
    return null;
  }

  bool validateIsEmail(String value) {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  String? validateEmail(BuildContext context, String? value, {String? msg}) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (msg != null) return msg;
    if ((value ?? '').isEmpty) return "This field can't be empty";
    if (!regex.hasMatch(value!)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  String? validateCurrentPassword(String value) {
    if (value.trim().length < 8) {
      return 'Enter current password';
    } else {
      return null;
    }
  }

  bool validateIsPassword(String value) {
    if (value.trim().isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  List<TextInputFormatter>? inputFormatter(InputFormatType type) {
    List<TextInputFormatter>? val;
    switch (type) {
      case InputFormatType.phoneNumber:
        val = [
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        ];
        break;

      case InputFormatType.password:
        val = [
          FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z@]")),
        ];
        break;
      case InputFormatType.name:
        val = [FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))];
        break;
      case InputFormatType.email:
        val = [FilteringTextInputFormatter.deny(RegExp(r'[- /+?:;*#$%^&*()]'))];
        break;
    }
    return val;
  }
}
