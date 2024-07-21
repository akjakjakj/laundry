import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/common_widgets/custom_button.dart';
import 'package:laundry/common_widgets/custom_text_from_field.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/utils/validator.dart';
import 'package:laundry/views/authentication/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class ForgotPasswordResetPasswordScreen extends StatefulWidget {
  const ForgotPasswordResetPasswordScreen({super.key});

  @override
  _ForgotPasswordResetPasswordScreenState createState() =>
      _ForgotPasswordResetPasswordScreenState();
}

class _ForgotPasswordResetPasswordScreenState
    extends State<ForgotPasswordResetPasswordScreen> {
  Validator validator = sl.get<Validator>();
  late AuthProvider authProvider;

  @override
  void initState() {
    authProvider = context.read<AuthProvider>();
    super.initState();
  }

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
          "Reset Password",
          style: FontPalette.poppinsBold
              .copyWith(color: Colors.black, fontSize: 17.sp),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 24.w),
        child: Column(
          children: [
            CustomTextField(
              controller: authProvider.resetPasswordController,
              labelText: 'Enter New Password',
              hintText: 'Enter Your New Password',
              enableObscure: true,
              validator: (value) => validator.validatePassword(context, value),
            ),
            35.verticalSpace,
            CustomTextField(
              controller: authProvider.registrationConfirmPasswordController,
              labelText: 'Confirm Password',
              hintText: 'Re-Enter Your New Password',
              enableObscure: true,
              validator: (value) => validator.validatePassword(context, value),
            ),
            const Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  title: 'Reset Password',
                  // onTap: () => Navigator.pushNamed(context,
                  //     RouteGenerator.routeForgotPasswordResetPasswordScreen),
                ),
              ),
            )
          ],
        ),
      ).withBackgroundImage(),
    );
  }
}
