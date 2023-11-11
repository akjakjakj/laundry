import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/common_widgets/custom_button.dart';
import 'package:laundry/common_widgets/custom_text_from_field.dart';
import 'package:laundry/gen/assets.gen.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                    'CREATE YOUR ACCOUNT',
                    style: FontPalette.poppinsBold.copyWith(
                        fontSize: 25.sp, color: ColorPalette.secondaryColor),
                  ),
                  40.verticalSpace,
                  const CustomTextField(
                    labelText: 'Name',
                    hintText: 'Enter Your name',
                  ),
                  35.verticalSpace,
                  const CustomTextField(
                    labelText: 'Email',
                    hintText: 'Enter Your Email address',
                  ),
                  35.verticalSpace,
                  const CustomTextField(
                    labelText: 'Password',
                    hintText: 'Enter Your Password',
                  ),
                  35.verticalSpace,
                  const CustomTextField(
                    labelText: 'Confirm Password',
                    hintText: 'Enter Your Password',
                  ),
                  60.verticalSpace,
                  const CustomButton(
                    title: 'REGISTER',
                  ),
                  30.verticalSpace,
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                        text: TextSpan(
                            text: "Already an Account ?",
                            style: FontPalette.poppinsBold
                                .copyWith(color: ColorPalette.secondaryColor),
                            children: [
                          TextSpan(
                              text: ' LOGIN',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pop(context),
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
