import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/common_widgets/custom_button.dart';
import 'package:laundry/common_widgets/custom_linear_progress_indicator.dart';
import 'package:laundry/gen/assets.gen.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/eco_dry_clean/model/eco_dry_clean_arguments.dart';
import 'package:laundry/views/eco_dry_clean/view_model/eco_dry_view_model.dart';
import 'package:laundry/views/main_screen/home_screen/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class EcoDryCleanScreen extends StatefulWidget {
  const EcoDryCleanScreen({super.key, this.title, this.serviceId});
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
                    return LayoutBuilder(
                      builder: (context, constraints) => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.white,
                            height: constraints.maxHeight / 2.2,
                            child: Column(children: [
                              Assets.images.ecoFriendly.image(),
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, RouteGenerator.routePricePdfView,
                                    arguments: PriceListScreenArguments(
                                        serviceId: 0,
                                        ecoDryProvider: ecoDryProvider)),
                                child: Container(
                                  height: 50.r,
                                  width: 180.r,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40.r),
                                      border: Border.all(color: Colors.black)),
                                  child: Text(
                                    'Price List',
                                    style: FontPalette.poppinsRegular
                                        .copyWith(fontSize: 20.0),
                                  ),
                                ),
                              )
                            ]),
                          ),
                          Container(
                            height: 50,
                            color: Colors.grey[200],
                            child: CustomPaint(
                              painter: CurvedDividerPainter(),
                              child: Container(),
                            ),
                          ),
                          Container(
                            color: Colors.grey[200],
                            height: constraints.maxHeight / 2.2,
                            width: double.maxFinite,
                            alignment: Alignment.center,
                            child: Column(children: [
                              Assets.images.designerLogo.image(
                                height: constraints.maxWidth * .5,
                                width: constraints.maxWidth * .7,
                              ),
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, RouteGenerator.routePricePdfView,
                                    arguments: PriceListScreenArguments(
                                        serviceId: 1,
                                        ecoDryProvider: ecoDryProvider)),
                                child: Container(
                                  height: 50.r,
                                  width: 180.r,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40.r),
                                      border: Border.all(color: Colors.black)),
                                  child: Text(
                                    'Price List',
                                    style: FontPalette.poppinsRegular
                                        .copyWith(fontSize: 20.0),
                                  ),
                                ),
                              )
                            ]),
                          )
                          // 100.verticalSpace,
                          // Container(
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(20.r),
                          //       color: Colors.green.withOpacity(.5)),
                          //   padding: EdgeInsets.symmetric(
                          //       vertical: 20.h, horizontal: 12.w),
                          //   child: Column(
                          //     children: [
                          //       Assets.images.designerLogo.image(
                          //         height: 80.h,
                          //       ),
                          //       10.verticalSpace,
                          //       CustomButton(
                          //         title: 'Designer',
                          //         color: Colors.black,
                          //         onTap: () => Navigator.pushNamed(
                          //             context, RouteGenerator.routePricePdfView,
                          //             arguments: PriceListScreenArguments(
                          //                 serviceId: 1,
                          //                 ecoDryProvider: ecoDryProvider)),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // 100.verticalSpace,
                          // Container(
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(20.r),
                          //       color: Colors.green.withOpacity(.5)),
                          //   padding: EdgeInsets.symmetric(
                          //       vertical: 20.h, horizontal: 12.w),
                          //   child: Column(
                          //     children: [
                          //       Assets.images.logo.image(
                          //         height: 80.h,
                          //       ),
                          //       10.verticalSpace,
                          //       CustomButton(
                          //         title: 'Eco-Friendly',
                          //         onTap: () => Navigator.pushNamed(
                          //             context, RouteGenerator.routePricePdfView,
                          //             arguments: PriceListScreenArguments(
                          //                 serviceId: 0,
                          //                 ecoDryProvider: ecoDryProvider)),
                          //       ),
                          //     ],
                          //   ),
                          // ),
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

class CurvedDividerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white // Adjust the color of the divider
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, size.height * 0.3); // Starting point of the curve
    path.quadraticBezierTo(
      size.width * 0.5, size.height * -.3, // Control point for the curve
      size.width, size.height * 0.3, // End point of the curve
    );
    path.lineTo(size.width, 0); // Draw to the top-right
    path.lineTo(0, 0); // Draw to the top-left
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
