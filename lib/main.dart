import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/multi_provider_list.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:provider/provider.dart';

void main() {  
  setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: MultiProviderList.providerList,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          title: 'Laundry',
          debugShowCheckedModeBanner: false,
          theme: ColorPalette.themeData,
          onGenerateRoute: RouteGenerator.instance.generateRoute,
        ),
      ),
    );
  }
}
