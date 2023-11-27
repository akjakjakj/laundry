import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/gen/assets.gen.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/main_screen/home_screen/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class EcoDryCleanScreen extends StatefulWidget {
  const EcoDryCleanScreen({Key? key}) : super(key: key);

  @override
  _EcoDryCleanScreenState createState() => _EcoDryCleanScreenState();
}

class _EcoDryCleanScreenState extends State<EcoDryCleanScreen> {
  late HomeProvider homeProvider;

  @override
  void initState() {
    homeProvider = context.read<HomeProvider>();
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
          "Eco - Dry Clean",
          style: FontPalette.poppinsBold
              .copyWith(color: Colors.black, fontSize: 17.sp),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: homeProvider.categoriesList.isNotEmpty
          ? GridView.builder(
              itemCount: homeProvider.categoriesList.length,
              padding: EdgeInsets.symmetric(horizontal: 37.w, vertical: 15.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: context.sw(size: .300.w),
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 15.h),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, RouteGenerator.routeEcoDryCleanSelectionScreen),
                  child: Container(
                    width: context.sw(size: .400.w),
                    // height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color(0XFFA7B7C4),
                        // color: ColorPalette.hintColor,
                        borderRadius: BorderRadius.circular(15.r)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.images.shoe.image(height: 55.h, width: 55.w),
                        Text(
                          homeProvider.categoriesList[index].name ?? '',
                          style: FontPalette.poppinsBold.copyWith(
                              fontSize: 17.sp, color: ColorPalette.greenColor),
                        )
                      ],
                    ),
                  ),
                ).removeSplash();
              },
            )
          : Center(
              child: Text(
                'No categories found',
                style: FontPalette.poppinsBold,
              ),
            ),
    );
  }
}
