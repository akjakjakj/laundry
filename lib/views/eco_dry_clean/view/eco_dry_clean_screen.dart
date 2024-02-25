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
            widget.title ?? '',
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Get Price List',
                            style: FontPalette.poppinsBold
                                .copyWith(fontSize: 16.sp),
                          ),
                          20.verticalSpace,
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
                    return GridView.builder(
                      itemCount: ecoDryProvider.categoriesList.length,
                      padding: EdgeInsets.symmetric(
                          horizontal: 37.w, vertical: 15.h),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: context.sw(size: .300.w),
                          crossAxisSpacing: 16.w,
                          mainAxisSpacing: 15.h),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Navigator.pushNamed(
                                  context,
                                  RouteGenerator
                                      .routeEcoDryCleanSelectionScreen,
                                  arguments: EcoDryCleanArguments(
                                      categoryId: ecoDryProvider
                                          .categoriesList[index].id,
                                      title: widget.title,
                                      ecoDryProvider: ecoDryProvider))
                              .then((value) => ecoDryProvider.getCategories()),
                          child: Container(
                            width: context.sw(size: .400.w),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color(0XFFA7B7C4),
                                borderRadius: BorderRadius.circular(15.r)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CommonFadeInImage(
                                    image: ecoDryProvider
                                            .categoriesList[index].icon ??
                                        '',
                                    height: 55.h,
                                    width: 55.w),
                                Text(
                                  ecoDryProvider.categoriesList[index].name ??
                                      '',
                                  style: FontPalette.poppinsBold.copyWith(
                                      fontSize: 17.sp,
                                      color: ColorPalette.greenColor),
                                )
                              ],
                            ),
                          ),
                        ).removeSplash();
                      },
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
