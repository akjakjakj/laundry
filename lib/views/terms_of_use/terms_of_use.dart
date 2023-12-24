import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/font_palette.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

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
          "Terms of use",
          style: FontPalette.poppinsBold
              .copyWith(color: Colors.black, fontSize: 17.sp),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Last Updated: November 15, 2021",
                style: FontPalette.poppinsBold
                    .copyWith(color: Colors.black, fontSize: 11.sp),
              ),
              2.verticalSpace,
              Text(
                "Welcome to Demo, the mobile application and online service of Demo Music, LLC (“DEMO,” “we,” or “us”). This page explains the terms by which you may use our online and/or mobile services and software provided on or in connection with the service (collectively “Service”). By accessing or using the Service, you agree to be bound by this Terms of Use Agreement (“Agreement”) and to the collection and use of your information as set forth in the DEMO Privacy Policy, whether or not you are a registered user of our Service. This Agreement applies to all visitors, users, members, contributors and others who access the Service (“Users”). This Agreement hereby incorporates the terms of the following additional documents, including all future amendments or modifications thereto",
                style: FontPalette.poppinsRegular
                    .copyWith(color: Colors.black, fontSize: 11.sp),
              ),
                 2.verticalSpace,
              Text(
                "Use of Our Service",
                style: FontPalette.poppinsBold
                    .copyWith(color: Colors.black, fontSize: 11.sp),
              ),
              2.verticalSpace,
              Text(
                "Welcome to Demo, the mobile application and online service of Demo Music, LLC (“DEMO,” “we,” or “us”). This page explains the terms by which you may use our online and/or mobile services and software provided on or in connection with the service (collectively “Service”). By accessing or using the Service, you agree to be bound by this Terms of Use Agreement (“Agreement”) and to the collection and use of your information as set forth in the DEMO Privacy Policy, whether or not you are a registered user of our Service. This Agreement applies to all visitors, users, members, contributors and others who access the Service (“Users”). This Agreement hereby incorporates the terms of the following additional documents, including all future amendments or modifications thereto",
                style: FontPalette.poppinsRegular
                    .copyWith(color: Colors.black, fontSize: 11.sp),
              ),
                 2.verticalSpace,
              Text(
                "General",
                style: FontPalette.poppinsBold
                    .copyWith(color: Colors.black, fontSize: 11.sp),
              ),
              2.verticalSpace,
              Text(
                "Welcome to Demo, the mobile application and online service of Demo Music, LLC (“DEMO,” “we,” or “us”). This page explains the terms by which you may use our online and/or mobile services and software provided on or in connection with the service (collectively “Service”). By accessing or using the Service, you agree to be bound by this Terms of Use Agreement (“Agreement”) and to the collection and use of your information as set forth in the DEMO Privacy Policy, whether or not you are a registered user of our Service. This Agreement applies to all visitors, users, members, contributors and others who access the Service (“Users”). This Agreement hereby incorporates the terms of the following additional documents, including all future amendments or modifications thereto",
                style: FontPalette.poppinsRegular
                    .copyWith(color: Colors.black, fontSize: 11.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
