import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/common_widgets/common_fade_in_image.dart';
import 'package:laundry/common_widgets/custom_button.dart';
import 'package:laundry/common_widgets/custom_linear_progress_indicator.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/eco_dry_clean/model/eco_dry_clean_arguments.dart';
import 'package:laundry/views/eco_dry_clean/view/widgets/eco_dry_category_shimmer.dart';
import 'package:laundry/views/eco_dry_clean/view_model/eco_dry_view_model.dart';
import 'package:laundry/views/main_screen/home_screen/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class EcoDryCleanScreen extends StatefulWidget {
  const EcoDryCleanScreen({Key? key, this.title, this.serviceId})
      : super(key: key);
  final String? title;
  final int? serviceId;

  @override
  _EcoDryCleanScreenState createState() => _EcoDryCleanScreenState();
}

class _EcoDryCleanScreenState extends State<EcoDryCleanScreen> {
  late HomeProvider homeProvider;
  late EcoDryProvider ecoDryProvider;

  int? id;

  @override
  void initState() {
    homeProvider = context.read<HomeProvider>();
    ecoDryProvider = EcoDryProvider();
    ecoDryProvider
      ..updateServiceId(widget.serviceId ?? 0)
      ..getPriceList(widget.serviceId ?? 1);
    // ..getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.only(left: 15.r),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Center(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 4,
                          blurStyle: BlurStyle.outer,
                          color: Color.fromARGB(255, 224, 224, 224),
                          spreadRadius: 0.5)
                    ],
                  ),
                  child: CircleAvatar(
                      radius: 18.r,
                      backgroundColor: Colors.white,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 6.w),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                            size: 18.r,
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ),
          title: Text(
            'Get Price List',
            style: FontPalette.poppinsBold
                .copyWith(color: Colors.black, fontSize: 17.sp),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: ChangeNotifierProvider.value(
            value: ecoDryProvider,
            child: Consumer<EcoDryProvider>(
              builder: (context, provider, child) {
                switch (provider.loaderState) {
                  case LoaderState.loading:
                    return const CustomLinearProgress();
                  case LoaderState.loaded:
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          40.verticalSpace,
                          CustomButton(
                            title: 'Normal Service',
                            onTap: () => Navigator.pushNamed(
                                context, RouteGenerator.routePricePdfView,
                                arguments: PriceListScreenArguments(
                                    serviceId: 0,
                                    ecoDryProvider: ecoDryProvider)),
                          ),
                          20.verticalSpace,
                          CustomButton(
                            title: 'Express Service',
                            onTap: () => Navigator.pushNamed(
                                context, RouteGenerator.routePricePdfView,
                                arguments: PriceListScreenArguments(
                                    serviceId: 1,
                                    ecoDryProvider: ecoDryProvider)),
                          ),
                        ],
                      ),
                    );
                  case LoaderState.noProducts:
                    return Center(
                      child: Text(
                        'No categories found',
                        style: FontPalette.poppinsBold,
                      ),
                    );
                  case LoaderState.networkErr:
                    return Center(
                      child: Text(
                        'Network Error',
                        style: FontPalette.poppinsBold,
                      ),
                    );
                  case LoaderState.error:
                    return Expanded(
                      child: Center(
                        child: Text('Oops...! Error',
                            style: FontPalette.poppinsBold),
                      ),
                    );
                  case LoaderState.noData:
                    return Center(
                      child: Text(
                        'No Data Found',
                        style: FontPalette.poppinsBold,
                      ),
                    );
                }
              },
            )).withBackgroundImage());
  }
}
