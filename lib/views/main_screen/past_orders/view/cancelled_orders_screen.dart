import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/gen/assets.gen.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/main_screen/active_orders/view/widgets/active_orders_tile.dart';
import 'package:laundry/views/main_screen/active_orders/view_model/active_orders_view_model.dart';
import 'package:laundry/views/main_screen/past_orders/view/widgets/past_orders_shimmer.dart';
import 'package:provider/provider.dart';

class CancelledOrdersScreen extends StatefulWidget {
  const CancelledOrdersScreen({super.key});

  @override
  State<CancelledOrdersScreen> createState() => _CancelledOrdersScreenState();
}

class _CancelledOrdersScreenState extends State<CancelledOrdersScreen> {
  ActiveOrdersProvider activeOrdersProvider = ActiveOrdersProvider();
  @override
  void initState() {
    activeOrdersProvider.getCancelledOrders();
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
          'Cancelled Orders',
          style: FontPalette.poppinsBold
              .copyWith(color: Colors.black, fontSize: 17.sp),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: Assets.images.logo.image(
                  height: 50.h,
                ),
              ),
              Expanded(
                child: Container(
                  height: context.sh(),
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: ChangeNotifierProvider.value(
                    value: activeOrdersProvider,
                    child: Consumer<ActiveOrdersProvider>(
                      builder: (context, provider, child) {
                        switch (provider.loaderState) {
                          case LoaderState.loading:
                            return const PastOrdersShimmer();
                          case LoaderState.loaded:
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                20.verticalSpace,
                                Text(
                                  'Cancelled Orders',
                                  style: FontPalette.poppinsBold.copyWith(
                                      fontSize: 11.sp,
                                      color: HexColor('#000000')),
                                ),
                                10.verticalSpace,
                                Expanded(
                                    child: SingleChildScrollView(
                                  child: ActiveOrdersTile(
                                    ordersList: activeOrdersProvider
                                        .cancelledOrdersList,
                                    activeOrdersProvider: activeOrdersProvider,
                                  ),
                                )),
                                30.verticalSpace
                              ],
                            );
                          case LoaderState.noProducts:
                            return Center(
                              child: Text(
                                'No Cancelled orders found',
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
                            return Center(
                              child: Text('Oops...! Error',
                                  style: FontPalette.poppinsBold),
                            );
                          case LoaderState.noData:
                            return Center(
                              child: Text(
                                'No active orders Found',
                                style: FontPalette.poppinsBold,
                              ),
                            );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ).withBackgroundImage(),
        ),
      ),
    );
  }
}
