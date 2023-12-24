import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/gen/assets.gen.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

import '../../../services/route_generator.dart';
import '../../../utils/font_palette.dart';

class Whatsapp extends StatefulWidget {
  const Whatsapp({super.key});

  @override
  State<Whatsapp> createState() => _WhatsappState();
}

class _WhatsappState extends State<Whatsapp> {
  bool? isWhatsapp;
  Helpers helpers = sl.get<Helpers>();
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteGenerator.routeCart);
                      },
                      child: Padding(
                          padding: EdgeInsets.only(right: 15.w),
                          child:
                              Assets.icons.cart.image(height: 30, width: 30)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 130.h,
                        width: 130.h,
                        child: Image.network(
                            "https://i.pinimg.com/originals/cf/96/e5/cf96e5b917fa2c520da5a9a73afced44.gif"),
                      ),
                      10.verticalSpace,
                      Text(
                        "Whatsapp Support",
                        style: FontPalette.poppinsBold
                            .copyWith(color: Colors.black, fontSize: 11.sp),
                      ),
                      2.verticalSpace,
                      Text(
                        "To better assist you, contact us from your phone ",
                        style: FontPalette.poppinsRegular
                            .copyWith(color: Colors.black, fontSize: 11.sp),
                      ),
                      10.verticalSpace,
                      ElevatedButton(
                          onPressed: isInstalled,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorPalette.greenColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: const Text('    Contact    ')),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> isInstalled() async {
    isWhatsapp =
        await WhatsappShare.isInstalled(package: Package.businessWhatsapp);
    isWhatsapp =
        await WhatsappShare.isInstalled(package: Package.businessWhatsapp);
    debugPrint('Whatsapp  is installed: $isWhatsapp');
    if (isWhatsapp == true) share();
    if (isWhatsapp == null || isWhatsapp == false) {
      helpers.errorToast("No Whatsapp is installed");
    }
  }

  Future<void> share() async {
    await WhatsappShare.share(
      text: 'Whatsapp share text',
      // linkUrl: 'https://flutter.dev/',
      phone: '911234567890',
    );
  }
}
