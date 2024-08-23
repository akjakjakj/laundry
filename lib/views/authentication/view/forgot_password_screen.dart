import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/common_widgets/custom_button.dart';
import 'package:laundry/common_widgets/custom_text_from_field.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/utils/validator.dart';
import 'package:laundry/views/authentication/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../../../utils/font_palette.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late AuthProvider authProvider;
  Helpers helpers = sl.get<Helpers>();
  Validator validator = sl.get<Validator>();
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    authProvider = context.read<AuthProvider>();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    authProvider.forgotPasswordEmailController.clear();
    super.dispose();
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
          "Forgot Password",
          style: FontPalette.poppinsBold
              .copyWith(color: Colors.black, fontSize: 17.sp),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 34.w),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              50.verticalSpace,
              CustomTextField(
                controller: authProvider.forgotPasswordEmailController,
                hintText: 'Enter Your Email Address',
                labelText: 'Email',
                validator: (value) => validator.validateEmail(context,
                    authProvider.forgotPasswordEmailController.text.trim()),
              ),
              50.verticalSpace,
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 60.h),
                    child: Selector<AuthProvider, bool>(
                      selector: (context, authProvider) =>
                          authProvider.btnLoaderState,
                      builder: (context, value, child) => CustomButton(
                          title: 'Send OTP',
                          isLoading: value,
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                              authProvider.requestForgotPasswordOtp(
                                  onSuccess: () {
                                    authProvider.updateErrorMessage(null);
                                    helpers.successToast(
                                        'OTP sent to the given Email address');
                                    Navigator.pushNamed(
                                        context,
                                        RouteGenerator
                                            .routeForgotPasswordOtpVerificationScreen);
                                  },
                                  onFailure: () => helpers.errorToast(
                                      authProvider.errorMessage ?? ''));
                            }
                          }),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ).withBackgroundImage(),
    );
  }
}
