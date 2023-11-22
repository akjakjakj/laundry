import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        fontSize: 16.0);
  }

  // Future flushToast(BuildContext context, {required String msg}) {
  //   return Flushbar(
  //     message: msg,
  //     duration: const Duration(seconds: 2),
  //     titleColor: HexColor('#282C3F').withOpacity(0.95),
  //     margin: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.h),
  //   ).show(context);
  // }

  // void successToastWithIcon(BuildContext context, String msg) {
  //   FToast fToast = FToast();
  //   fToast.init(context);
  //   Widget toast = Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Flexible(
  //         child: Container(
  //           height: 35.h + context.validateScale() * 10.h,
  //           padding: EdgeInsets.symmetric(horizontal: 15.w),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(4.r),
  //             color: HexColor('#F2F2F2'),
  //           ),
  //           child: Row(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               SvgPicture.asset(
  //                 Assets.iconsCheck,
  //                 height: 20.h,
  //                 width: 20.w,
  //               ),
  //               8.horizontalSpace,
  //               Flexible(child: Text(msg).avoidOverFlow()),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  //   fToast.showToast(child: toast);
  // }

  static double convertToDouble(var valArg, {bool check = false}) {
    double val = 0.0;
    if (valArg == null) return val;
    switch (valArg.runtimeType) {
      case int:
        val = valArg.toDouble();
        break;
      case String:
        val = double.tryParse(valArg) ?? val;
        break;

      default:
        val = valArg;
    }
    return val;
  }
}
