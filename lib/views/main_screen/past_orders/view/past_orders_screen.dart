import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/main_screen/past_orders/view/widgets/past_orders_shimmer.dart';
import 'package:laundry/views/main_screen/past_orders/view/widgets/past_orders_tile.dart';
import 'package:laundry/views/main_screen/past_orders/view_model/past_orders_view_model.dart';
import 'package:provider/provider.dart';

class PastOrdersScreen extends StatefulWidget {
  const PastOrdersScreen({Key? key}) : super(key: key);

  @override
  _PastOrdersScreenState createState() => _PastOrdersScreenState();
}

class _PastOrdersScreenState extends State<PastOrdersScreen> {
  PastOrdersProvider pastOrdersProvider = PastOrdersProvider();

  @override
  void initState() {
    pastOrdersProvider.getPastOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: ChangeNotifierProvider.value(
          value: pastOrdersProvider,
          child: Consumer<PastOrdersProvider>(
            builder: (context, provider, child) {
              switch (provider.loaderState) {
                case LoaderState.loading:
                  return const PastOrdersShimmer();
                case LoaderState.loaded:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      60.verticalSpace,
                      Text(
                        'Past Orders',
                        style: FontPalette.poppinsBold.copyWith(
                            fontSize: 11.sp, color: HexColor('#000000')),
                      ),
                      Expanded(child: PastOrdersTile(ordersList: pastOrdersProvider.ordersList)),
                      50.verticalSpace
                    ],
                  );
                case LoaderState.noProducts:
                  return Center(
                    child: Text(
                      'No orders found',
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
                    child:
                        Text('Oops...! Error', style: FontPalette.poppinsBold),
                  );
                case LoaderState.noData:
                  return Center(
                    child: Text(
                      'No orders Found',
                      style: FontPalette.poppinsBold,
                    ),
                  );
              }
            },
          ),
        ),
      ).withBackgroundImage(),
    );
  }
}
