import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/common_widgets/custom_button.dart';
import 'package:laundry/common_widgets/custom_text_from_field.dart';
import 'package:laundry/services/route_generator.dart';

import '../../../utils/font_palette.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
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
        title: Text(
          "Forgot Password",
          style: FontPalette.poppinsBold
              .copyWith(color: Colors.black, fontSize: 17.sp),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 34.w),
        child: Column(
          children: [
            50.verticalSpace,
            const CustomTextField(
              hintText: 'Enter Your Email Address',
              labelText: 'Email',
            ),
            50.verticalSpace,
            CustomButton(
              title: 'Sent OTP',
              // onTap: () =>
              //     Navigator.pushNamed(context, RouteGenerator.routePastOrders),
            )
          ],
        ),
      ).withBackgroundImage(),
    );
  }
}
