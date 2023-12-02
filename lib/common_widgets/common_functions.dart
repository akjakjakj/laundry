import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/helpers.dart';

class CommonFunctions {
  Helpers helpers = sl.get<Helpers>();

  static void afterInit(Function function) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      function();
    });
  }

  static showDialogPopUp(BuildContext context, Widget dialogWidget,
      {bool barrierDismissible = true, String? routeName}) {
    showGeneralDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      barrierLabel: "",
      routeSettings: routeName == null ? null : RouteSettings(name: routeName),
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return WillPopScope(
          onWillPop: () async {
            return barrierDismissible;
          },
          child: Transform.scale(
            scale: curve,
            child: dialogWidget,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
