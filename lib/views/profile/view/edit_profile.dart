import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common_widgets/custom_button.dart';
import 'package:laundry/common_widgets/custom_text_from_field.dart';
import 'package:laundry/services/get_it.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/utils/validator.dart';
import 'package:laundry/views/authentication/view_model/auth_view_model.dart';
import 'package:laundry/views/profile/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  final Validator validator = sl.get<Validator>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          'Edit Profile',
          style: FontPalette.poppinsBold
              .copyWith(color: Colors.black, fontSize: 17.sp),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) => Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  40.verticalSpace,
                  CustomTextField(
                    controller: profileProvider.nameTextEditingController,
                    labelText: 'Name',
                    hintText: 'Enter Your name',
                    validator: (value) => validator.validateName(context,
                        profileProvider.nameTextEditingController.text.trim()),
                  ),
                  35.verticalSpace,
                  CustomTextField(
                    controller: profileProvider.emailTextEditingController,
                    labelText: 'Email',
                    hintText: 'Enter Your Email address',
                    validator: (value) => validator.validateEmail(context,
                        profileProvider.emailTextEditingController.text.trim()),
                  ),
                  35.verticalSpace,
                  Row(
                    children: [
                      if (context.read<AuthProvider>().checkAppFunctionStatus ??
                          false)
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  showPhoneCode: true,
                                  countryListTheme: CountryListThemeData(
                                      // Customize the popup height
                                      bottomSheetHeight:
                                          500.h, // Set the desired height here
                                      flagSize: 25,
                                      backgroundColor: Colors.white,
                                      textStyle: const TextStyle(
                                          fontSize: 16, color: Colors.black),
                                      inputDecoration: InputDecoration(
                                        labelText: 'Search Country',
                                        hintText: 'Type to search',
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical:
                                              10.0, // Adjust height by changing vertical padding
                                          horizontal: 15.w,
                                        ),
                                      )),
                                  useSafeArea:
                                      true, // Display the phone code next to the country name
                                  onSelect: (Country country) => profileProvider
                                      .updateCountryData(country),
                                );
                              },
                              child: Container(
                                height: 40.r,
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      profileProvider.selectedCountry
                                          .flagEmoji, // Emoji flag
                                      style: TextStyle(fontSize: 20.sp),
                                    ),
                                    5.horizontalSpace,
                                    Text(
                                      '+${profileProvider.selectedCountry.phoneCode} ', // Emoji flag
                                      style: TextStyle(fontSize: 13.sp),
                                    ),
                                    const Icon(Icons.arrow_drop_down),
                                    5.horizontalSpace
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      Expanded(
                        child: CustomTextField(
                            controller:
                                profileProvider.phoneTextEditingController,
                            labelText: 'Mobile Number',
                            hintText: 'Enter mobile number',
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
                      ),
                    ],
                  ),
                  // CustomTextField(
                  //     controller: profileProvider.phoneTextEditingController,
                  //     labelText: 'Mobile Number',
                  //     hintText: 'Enter mobile number',
                  //     maxLength: 12,
                  //     textInputType: TextInputType.number,
                  //     validator: (value) => validator.validateMobile(
                  //         context,
                  //         profileProvider.phoneTextEditingController.text
                  //             .trim(),
                  //         maxLength: 15),
                  //     textInputFormatter: validator
                  //         .inputFormatter(InputFormatType.phoneNumber)),
                  60.verticalSpace,
                  CustomButton(
                    title: 'Update',
                    isLoading: profileProvider.btnLoaderState,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        profileProvider.updateProfile(
                          onSuccess: () => Navigator.pop(context),
                          onFailure: () => profileProvider.helpers
                              .errorToast('Oops...! An error occurred'),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
