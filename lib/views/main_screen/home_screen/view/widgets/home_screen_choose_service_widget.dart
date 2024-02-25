import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common_widgets/common_functions.dart';
import 'package:laundry/common_widgets/custom_alert_dialogue.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/views/cart/model/normal_service_arguments.dart';
import 'package:laundry/views/eco_dry_clean/model/eco_dry_clean_arguments.dart';
import 'package:laundry/views/main_screen/home_screen/model/services_model.dart';

import 'home_screen_service_container.dart';

class ChooseServiceWidget extends StatelessWidget {
  const ChooseServiceWidget({Key? key, required this.servicesList})
      : super(key: key);
  final List<Services> servicesList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => HomeScreenServiceContainer(
              image: servicesList[index].icon ?? '',
              title: servicesList[index].name ?? '',
              onTap: () {
                if (index <= 1) {
                  CommonFunctions.showDialogPopUp(
                      context,
                      CustomAlertDialog(
                        title: '',
                        message: 'Choose your service',
                        actionButtonText: 'Normal Service',
                        cancelButtonText: 'Express Service',
                        isLoading: false,
                        onCancelButtonPressed: () => Navigator.pushNamed(
                            context, RouteGenerator.routeNormalServiceScreen,
                            arguments: NormalServiceArguments(index: 1)),
                        onActionButtonPressed: () async {
                          Navigator.pushNamed(
                              context, RouteGenerator.routeNormalServiceScreen,
                              arguments: NormalServiceArguments(index: 0));
                        },
                      ));
                  // Navigator.pushNamed(
                  //     context, RouteGenerator.routeNormalServiceScreen);
                  // Navigator.pushNamed(
                  //   context,
                  //   RouteGenerator.routeEcoDryClean,
                  //   arguments: EcoDryCleanArguments(
                  //       title: servicesList[index].name ?? '',
                  //       serviceId: servicesList[index].id),
                  // );
                }
              },
            ),
        separatorBuilder: (context, index) => 30.horizontalSpace,
        itemCount: servicesList.length);
  }
}
