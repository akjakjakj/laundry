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

class ActiveOrdersScreen extends StatefulWidget {
  const ActiveOrdersScreen({super.key});

  @override
  State<ActiveOrdersScreen> createState() => _ActiveOrdersScreenState();
}

class _ActiveOrdersScreenState extends State<ActiveOrdersScreen> {
  ActiveOrdersProvider activeOrdersProvider = ActiveOrdersProvider();
  @override
  void initState() {
    activeOrdersProvider.getActiveOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Assets.images.logo.image(
                        height: 50.h,
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.pushNamed(context, RouteGenerator.routeCart);
                    //   },
                    //   child: Padding(
                    //       padding: EdgeInsets.only(right: 15.w),
                    //       child:
                    //           Assets.icons.cart.image(height: 30, width: 30)),
                    // ),
                  ],
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
                                  'Active Orders',
                                  style: FontPalette.poppinsBold.copyWith(
                                      fontSize: 11.sp,
                                      color: HexColor('#000000')),
                                ),
                                10.verticalSpace,
                                Expanded(
                                    child: SingleChildScrollView(
                                  child: ActiveOrdersTile(
                                    ordersList: activeOrdersProvider.ordersList,
                                    activeOrdersProvider: activeOrdersProvider,
                                  ),
                                )),
                                30.verticalSpace
                              ],
                            );
                          case LoaderState.noProducts:
                            return Center(
                              child: Text(
                                'No past orders found',
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
