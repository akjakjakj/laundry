import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/main_screen/past_orders/view/widgets/past_orders_tile.dart';

class PastOrdersScreen extends StatefulWidget {
  const PastOrdersScreen({Key? key}) : super(key: key);

  @override
  _PastOrdersScreenState createState() => _PastOrdersScreenState();
}

class _PastOrdersScreenState extends State<PastOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              60.verticalSpace,
              Text(
                'Past Orders',
                style: FontPalette.poppinsBold
                    .copyWith(fontSize: 11.sp, color: HexColor('#000000')),
              ),
              const PastOrdersTile(),
              50.verticalSpace
            ],
          ),
        ),
      ).withBackgroundImage(),
    );
  }
}
