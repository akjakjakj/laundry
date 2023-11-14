import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/common_widgets/custom_button.dart';
import 'package:laundry/common_widgets/custom_text_from_field.dart';
import 'package:laundry/services/route_generator.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 34.w),
        child: Column(
          children: [
            120.verticalSpace,
            const CustomTextField(
              hintText: 'Enter Your Email Address',
              labelText: 'Email',
            ),
            80.verticalSpace,
            CustomButton(
              title: 'Continue',
              onTap: () =>
                  Navigator.pushNamed(context, RouteGenerator.routePastOrders),
            )
          ],
        ),
      ).withBackgroundImage(),
    );
  }
}
