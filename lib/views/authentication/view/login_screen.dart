import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/common_widgets/custom_button.dart';
import 'package:laundry/common_widgets/custom_text_from_field.dart';
import 'package:laundry/gen/assets.gen.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/services/helpers.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/utils/validator.dart';
import 'package:laundry/views/authentication/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final GlobalKey<FormState> _formKey;
  Validator validator = sl.get<Validator>();
  Helpers helpers = sl.get<Helpers>();

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) => SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                60.verticalSpace,
                Padding(
                  padding: EdgeInsets.only(left: 28.w, top: 40.0),
                  child: Assets.images.loginLogo
                      .image(height: 105.h, fit: BoxFit.fill),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 34.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   'LOGIN',
                      //   style: FontPalette.poppinsBold.copyWith(
                      //       fontSize: 30.sp,
                      //       color: ColorPalette.secondaryColor),
                      // ),
                      // Text(
                      //   'Welcome Back',
                      //   style: FontPalette.poppinsBold.copyWith(
                      //       fontSize: 38.sp,
                      //       color: ColorPalette.secondaryColor),
                      // ),
                      30.verticalSpace,
                      CustomTextField(
                        controller: authProvider.loginEmailController,
                        labelText: 'Email',
                        hintText: 'Enter Your Email address',
                        validator: (value) =>
                            validator.validateEmail(context, value),
                      ),
                      35.verticalSpace,
                      CustomTextField(
                        controller: authProvider.loginPasswordController,
                        labelText: 'Password',
                        hintText: 'Enter Your Password',
                        enableObscure: true,
                        validator: (value) =>
                            validator.validateName(context, value),
                      ),
                      60.verticalSpace,
                      CustomButton(
                        title: 'LOGIN',
                        isLoading: authProvider.btnLoaderState,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            authProvider.login(
                              onSuccess: () {
                                authProvider.updateErrorMessage(null);
                                authProvider.clearRegistrationControllers();
                                authProvider.clearLoginControllers();
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  RouteGenerator.routeMainScreen,
                                  (route) => false,
                                );
                              },
                              onFailure: () => helpers
                                  .errorToast(authProvider.errorMessage ?? ''),
                            );
                          }
                        },
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
                      // if ((authProvider.errorMessage ?? '').isNotEmpty)
                      //   Align(
                      //     alignment: Alignment.center,
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       children: [
                      //         12.verticalSpace,
                      //         Text(
                      //           authProvider.errorMessage ?? '',
                      //           style: FontPalette.poppinsRegular.copyWith(
                      //               color: ColorPalette.errorBorderColor,
                      //               fontSize: 12.sp),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      75.verticalSpace,
                      Align(
                        alignment: Alignment.center,
                        child: RichText(
                            text: TextSpan(
                                text: "Don't have an Account ?",
                                style: FontPalette.poppinsBold.copyWith(
                                    color: ColorPalette.secondaryColor),
                                children: [
                              TextSpan(
                                  text: ' SIGN UP',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      authProvider
                                          .clearRegistrationControllers();
                                      Navigator.pushNamed(context,
                                          RouteGenerator.routeRegistration);
                                    },
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
        ),
      ),
    );
  }
}
