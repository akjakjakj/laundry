import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/services/route_generator.dart';
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
              onTap: () => Navigator.pushNamed(
                context,
                RouteGenerator.routeEcoDryClean,
                arguments: EcoDryCleanArguments(
                    title: servicesList[index].name ?? '',
                    serviceId: servicesList[index].id),
              ),
            ),
        separatorBuilder: (context, index) => 30.horizontalSpace,
        itemCount: servicesList.length);
  }
}
