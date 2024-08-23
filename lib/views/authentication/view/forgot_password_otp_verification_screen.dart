import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/common_widgets/custom_button.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/utils/validator.dart';
import 'package:laundry/views/authentication/view_model/auth_view_model.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class ForgotPasswordOtpVerificationScreen extends StatefulWidget {
  const ForgotPasswordOtpVerificationScreen({super.key});

  @override
  _ForgotPasswordOtpVerificationScreenState createState() =>
      _ForgotPasswordOtpVerificationScreenState();
}

class _ForgotPasswordOtpVerificationScreenState
    extends State<ForgotPasswordOtpVerificationScreen> {
  Validator validator = sl.get<Validator>();
  late AuthProvider authProvider;

  PinTheme defaultTheme(double width) => PinTheme(
      width: width,
      height: width,
      textStyle: FontPalette.poppinsBold.copyWith(color: Colors.black),
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ColorPalette.primaryColor, // Choose your border color
            width: 2.h, // Choose your border width
          ),
        ),
      ));

  @override
  void initState() {
    authProvider = context.read<AuthProvider>();
    super.initState();
  }

  @override
  void dispose() {
    authProvider.forgotPasswordOtpController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width =
        190.w < (context.sw() - 40.w) ? 190.w / 4 : (context.sw() - 40.w) / 4;
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
          "Verification",
          style: FontPalette.poppinsBold
              .copyWith(color: Colors.black, fontSize: 17.sp),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ENTER VERIFICATION CODE',
              style: FontPalette.poppinsBold.copyWith(
                  color: ColorPalette.secondaryColor, fontSize: 15.sp),
            ),
            15.verticalSpace,
            Selector<AuthProvider, String?>(
              selector: (context, provider) => provider.errorMessage,
              builder: (context, value, child) => Pinput(
                separatorBuilder: (index) => 45.horizontalSpace,
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsUserConsentApi,
                controller: authProvider.forgotPasswordOtpController,
                autofocus: true,
                defaultPinTheme: defaultTheme(width),
                focusedPinTheme: defaultTheme(width),
                errorPinTheme: defaultTheme(width).copyDecorationWith(
                    border: Border.all(color: HexColor('#E50019'))),
                submittedPinTheme: defaultTheme(width),
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                //showCursor: true,
                forceErrorState: (value ?? '').isNotEmpty,
                // onChanged: (val) =>
                //     context
                //         .read<AuthProvider>()
                //         .updateOtpErrorMsg(''),
                // inputFormatters: validator.inputFormatter(
                //     InputFormatType.phoneNumber) ??
                //     [],
                // onCompleted: onComplete,
              ),
            ),
            20.verticalSpace,
            Center(
              child: RichText(
                  text: TextSpan(
                      text: "Didn't receive code?",
                      style: FontPalette.poppinsBold.copyWith(
                          color: ColorPalette.secondaryColor, fontSize: 11.sp),
                      children: [
                    TextSpan(
                        text: ' Resend',
                        style: FontPalette.poppinsBold.copyWith(
                            color: ColorPalette.primaryColor, fontSize: 11.sp))
                  ])),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Selector<AuthProvider, bool>(
                  selector: (context, provider) => provider.btnLoaderState,
                  builder: (context, value, child) => CustomButton(
                    isLoading: value,
                    title: 'Continue',
                    onTap: () => authProvider.verifyForgotPasswordOtp(
                        onSuccess: () {
                          authProvider.updateErrorMessage(null);
                          authProvider.helpers
                              .successToast('OTP verified successfully');
                          Navigator.pushNamed(
                              context,
                              RouteGenerator
                                  .routeForgotPasswordResetPasswordScreen);
                        },
                        onFailure: () => authProvider.helpers
                            .errorToast(authProvider.errorMessage ?? '')),
                  ),
                ),
              ),
            )
          ],
        ),
      ).withBackgroundImage(),
    );
  }
}
