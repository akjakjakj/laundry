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

// static Future<void> checkException(dynamic resp,
//     {Function? noCustomer,
//       Function? onError,
//       Function? onCartIdExpired,
//       Function(bool val)? onAuthError,
//       bool enableToast = true}) async {
//   ErrorModel errorModel = ErrorModel.fromJson(resp);
//   if (errorModel.extensions != null) {
//     switch (errorModel.extensions!.category) {
//       case 'no-customer':
//         if (noCustomer != null) noCustomer(true);
//         break;
//       case 'graph-input':
//         if (enableToast) helpers.successToast('${errorModel.message}');
//         break;
//       case 'graphql-authorization':
//         if (AppConfig.isAuthorized) {
//           if (onAuthError != null) {
//             await AuthenticationRepo.validateRefreshToken();
//             onAuthError(true);
//           }
//         } else {
//           if (onAuthError != null) onAuthError(true);
//         }
//         break;
//       case 'graphql-no-such-entity':
//         if (!AppConfig.isAuthorized) await AuthenticationRepo.getEmptyCart();
//         if (onCartIdExpired != null) onCartIdExpired(true);
//         break;
//
//       default:
//         if (errorModel.error != null &&
//             errorModel.error == 'error' &&
//             errorModel.message != null) {
//           if (enableToast) helpers.successToast('${errorModel.message}');
//           if (onError != null) onError(true);
//         }
//     }
//   } else {
//     if (errorModel.error != null &&
//         errorModel.error == 'error' &&
//         errorModel.message != null) {
//       if (enableToast) helpers.successToast('${errorModel.message}');
//       onError!(true);
//     }
//   }
// }
}