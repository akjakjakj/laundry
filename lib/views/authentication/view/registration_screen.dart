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
import 'package:laundry/utils/enums.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/utils/validator.dart';
import 'package:laundry/views/authentication/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
          "",
          style: FontPalette.poppinsBold
              .copyWith(color: Colors.black, fontSize: 17.sp),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              15.verticalSpace,
              Padding(
                padding: EdgeInsets.only(left: 28.w),
                child: Assets.images.loginLogo
                    .image(height: 105.h, fit: BoxFit.fill),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 34.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CREATE YOUR ACCOUNT',
                        style: FontPalette.poppinsBold.copyWith(
                            fontSize: 25.sp,
                            color: ColorPalette.secondaryColor),
                      ),
                      40.verticalSpace,
                      CustomTextField(
                        controller: authProvider.registrationNameController,
                        labelText: 'Name',
                        hintText: 'Enter Your name',
                        validator: (value) =>
                            validator.validateName(context, value),
                      ),
                      35.verticalSpace,
                      CustomTextField(
                        controller: authProvider.registrationEmailController,
                        labelText: 'Email',
                        hintText: 'Enter Your Email address',
                        validator: (value) =>
                            validator.validateEmail(context, value),
                      ),
                      35.verticalSpace,
                      CustomTextField(
                          controller:
                              authProvider.registrationMobileNumberController,
                          focusNode: authProvider.registerMobileNumberFocusNode,
                          labelText: 'Mobile Number',
                          hintText: 'Enter mobile number with country code',
                          maxLength: 12,
                          textInputType: TextInputType.number,
                          // prefix: Text('+971',
                          //     style: FontPalette.poppinsRegular.copyWith(
                          //       color: ColorPalette.hintColor,
                          //     )),
                          // prefix: Padding(
                          //   padding: const EdgeInsets.only(right: 8.0),
                          //   child: Text('+971',
                          //       style: FontPalette.poppinsRegular.copyWith(
                          //         color: ColorPalette.hintColor,
                          //       )),
                          // ),
                          validator: (value) => validator.validateMobile(
                              context, value, maxLength: 15),
                          textInputFormatter: validator
                              .inputFormatter(InputFormatType.phoneNumber)),
                      35.verticalSpace,
                      CustomTextField(
                        controller: authProvider.registrationPasswordController,
                        labelText: 'Password',
                        hintText: 'Enter Your Password',
                        validator: (value) =>
                            validator.validatePassword(context, value),
                      ),
                      35.verticalSpace,
                      CustomTextField(
                        controller:
                            authProvider.registrationConfirmPasswordController,
                        labelText: 'Confirm Password',
                        hintText: 'Enter Your Password',
                        validator: (value) => validator.validateConfirmPassword(
                            context,
                            authProvider.registrationPasswordController.text
                                .trim(),
                            value ?? ''),
                      ),
                      60.verticalSpace,
                      CustomButton(
                        title: 'REGISTER',
                        isLoading: authProvider.btnLoaderState,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            authProvider.register(
                              onSuccess: () =>
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      RouteGenerator.routeLogin,
                                      (route) => false),
                              onFailure: () => helpers
                                  .errorToast(authProvider.errorMessage ?? ''),
                            );
                          }
                        },
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
                      30.verticalSpace,
                      Align(
                        alignment: Alignment.center,
                        child: RichText(
                            text: TextSpan(
                                text: "Already an Account ?",
                                style: FontPalette.poppinsBold.copyWith(
                                    color: ColorPalette.secondaryColor),
                                children: [
                              TextSpan(
                                  text: ' LOGIN',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.pop(context),
                                  style: FontPalette.poppinsBold
                                      .copyWith(color: ColorPalette.greenColor))
                            ])),
                      ),
                      30.verticalSpace
                    ],
                  ),
                ),
              )
            ],
          ).withBackgroundImage(),
        ),
      ),
    );
  }
}
