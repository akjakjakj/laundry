import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:laundry/common_widgets/common_functions.dart';
import 'package:laundry/utils/color_palette.dart';

class Helpers {
  Future<bool> isInternetAvailable({
    bool enableToast = true,
    BuildContext? context,
  }) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        if (enableToast) {
          if (context != null) {
            CommonFunctions.afterInit(
                () => successToast('Internet Not Available'));
          }
        }
        return false;
      }
    } on SocketException catch (_) {
      if (enableToast) {
        if (context != null) {
          CommonFunctions.afterInit(
              () => successToast('internet Not Available'));
        }
      }
      return false;
    }
  }

  void successToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorPalette.primaryColor,
        textColor: Colors.white,
        fontSize: 16.sp);
  }

  void errorToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorPalette.errorBorderColor,
        textColor: Colors.white,
        fontSize: 16.sp);
  }

  static double convertToDouble(var valArg, {bool check = false}) {
    double val = 0.0;
    if (valArg == null) return val;
    switch (valArg.runtimeType) {
      case int _:
        val = valArg.toDouble();
        break;
      case String _:
        val = double.tryParse(valArg) ?? val;
        break;

      default:
        val = valArg;
    }
    return val;
  }

  DateTime convertTo24HoursFormat(String time) {
    DateFormat inputFormat = DateFormat("HH:mm");
    DateTime parsedTime = inputFormat.parse(time);
    // print('output${outputFormat.parse(time)}');
    DateTime result = DateTime(
        DateTime.now().year, // Use current year
        DateTime.now().month, // Use current month
        DateTime.now().day, // Use current day
        parsedTime.hour, // Hours from parsed time
        parsedTime.minute // Minutes from parsed time
        );
    return result;
    // return outputFormat.parse(time);
  }

  DateTime convertCurrentDateTimeTo24HoursFormat() {
    DateFormat timeFormat = DateFormat("HH:mm");
    String formattedDate = timeFormat.format(DateTime.now());
    DateTime timeIn24HoursFormat = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      int.parse(formattedDate.split(':')[0]), // Hours
      int.parse(formattedDate.split(':')[1]), // Minutes
    );
    // print('current date time ${timeFormat.parse(formattedDate)}');
    return timeIn24HoursFormat;
    return timeFormat.parse(formattedDate);
  }

  bool returnGreaterTimeFlag(DateTime time, DateTime currentDateTime) {
    return time.isAfter(currentDateTime) ? true : false;
  }

  bool checkSelectedDateAndCurrentDateIsSame(String selectedDate) {
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return selectedDate == currentDate ? true : false;
  }

  bool checkTimeSlotIsAvailableOrNot(String time) {
    final now = DateTime.now();
    final formatter = DateFormat('h:mm a');

    /// 'h:mm a' formats time as 10:00 AM
    final formattedTime = formatter.format(now);

    final timeToCompareString = time;

    /// Parse the time strings into DateTime objects
    final currentTime = formatter.parse(formattedTime);
    final timeToCompare = formatter.parse(timeToCompareString);
    final timePlus30Minutes =
        timeToCompare.subtract(const Duration(minutes: 30));
    return currentTime.isBefore(timePlus30Minutes);
  }
}
