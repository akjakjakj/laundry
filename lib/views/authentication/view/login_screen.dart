import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/common_widgets/custom_button.dart';
import 'package:laundry/common_widgets/custom_text_from_field.dart';
import 'package:laundry/gen/assets.gen.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            80.verticalSpace,
            Padding(
              padding: EdgeInsets.only(left: 28.w),
              child: Assets.images.loginLogo
                  .image(height: 105.h, fit: BoxFit.fill),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 34.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LOGIN',
                    style: FontPalette.poppinsBold.copyWith(
                        fontSize: 30.sp, color: ColorPalette.secondaryColor),
                  ),
                  Text(
                    'Welcome Back',
                    style: FontPalette.poppinsBold.copyWith(
                        fontSize: 38.sp, color: ColorPalette.secondaryColor),
                  ),
                  76.verticalSpace,
                  const CustomTextField(
                    labelText: 'Email',
                    hintText: 'Enter Your Email address',
                  ),
                  35.verticalSpace,
                  const CustomTextField(
                    labelText: 'Password',
                    hintText: 'Enter Your Password',
                    enableObscure: true,
                  ),
                  60.verticalSpace,
                  CustomButton(
                    title: 'LOGIN',
                    onTap: () => Navigator.pushNamed(
                        context, RouteGenerator.routeHomeScreen),
                  ),
                  16.verticalSpace,
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(
                          context, RouteGenerator.routeForgotPassword),
                      child: Text(
                        'Forgot Your Password ?',
                        style: FontPalette.poppinsBold.copyWith(
                            color: ColorPalette.secondaryColor,
                            fontSize: 11.sp),
                      ),
                    ),
                  ),
                  75.verticalSpace,
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                        text: TextSpan(
                            text: "Don't have an Account ?",
                            style: FontPalette.poppinsBold
                                .copyWith(color: ColorPalette.secondaryColor),
                            children: [
                          TextSpan(
                              text: ' SIGN UP',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pushNamed(
                                    context, RouteGenerator.routeRegistration),
                              style: FontPalette.poppinsBold
                                  .copyWith(color: ColorPalette.greenColor))
                        ])),
                  )
                ],
              ),
            )
          ],
        ).withBackgroundImage(),
      ),
    );
  }
}
