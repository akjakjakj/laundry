import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/gen/assets.gen.dart';
import 'package:laundry/services/route_generator.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/profile/model/profile_model.dart';
import 'package:laundry/views/profile/view_model/profile_view_model.dart';
import 'package:laundry/views/profile/widget/profile_tile.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/common_fade_in_image.dart';
import 'widget/profile_shimmer.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileProvider profileDetailProvider = ProfileProvider();

  @override
  void initState() {
    profileDetailProvider.getProfileDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15.w),
                        child: Assets.images.logo.image(
                          height: 50.h,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteGenerator.routeCart);
                        },
                        child: Padding(
                            padding: EdgeInsets.only(right: 15.w),
                            child:
                                Assets.icons.cart.image(height: 30, width: 30)),
                      ),
                    ],
                  ),
                ),
                45.verticalSpace,
                // CircleAvatar(
                //     radius: 80,
                //     backgroundImage: NetworkImage(
                //         'https://eu.ui-avatars.com/api/?name=John+Doe')),
                //=========================================================================
                ChangeNotifierProvider.value(
                  value: profileDetailProvider,
                  child: Consumer<ProfileProvider>(
                    builder: (context, provider, child) {
                      User? user = provider.profileResponse?.user;

                      switch (provider.loaderState) {
                        case LoaderState.loading:
                          return const ProfileShimmer();
                        case LoaderState.loaded:
                          return Column(
                            children: [
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  user?.profilePicture == null
                                      ? CircleAvatar(
                                          radius: 80,
                                          backgroundColor: const Color.fromARGB(
                                              255, 221, 221, 221),
                                          child: Text(
                                            user?.name?[0] ?? "",
                                            style: FontPalette.poppinsRegular
                                                .copyWith(
                                                    color: ColorPalette
                                                        .primaryColor,
                                                    fontSize: 50.sp),
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 80,
                                          backgroundColor: const Color.fromARGB(
                                              255, 221, 221, 221),
                                          child: CommonFadeInImage(
                                            image: user?.profilePicture,
                                            fit: BoxFit.cover,
                                          )),
                                  Container(
                                    height: 30.r,
                                    width: 30.r,
                                    margin: EdgeInsets.all(10.r),
                                    decoration: BoxDecoration(
                                      color: ColorPalette.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      size: 18.r,
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              5.verticalSpace,
                              Text(
                                user?.name ?? "",
                                style: FontPalette.poppinsBold.copyWith(
                                    color: Colors.black, fontSize: 14.sp),
                              ),
                              Text(
                                user?.email ?? "",
                                style: FontPalette.poppinsRegular.copyWith(
                                    color: const Color(0XFF707071),
                                    fontSize: 14.sp),
                              ),
                            ],
                          );
                        case LoaderState.noProducts:
                          return Center(
                            child: Text(
                              'No Profile found',
                              style: FontPalette.poppinsBold,
                            ),
                          );
                        case LoaderState.networkErr:
                          return Center(
                            child: Text(
                              'Network Error',
                              style: FontPalette.poppinsBold,
                            ),
                          );
                        case LoaderState.error:
                          return Center(
                            child: Text('Oops...! Error',
                                style: FontPalette.poppinsBold),
                          );
                        case LoaderState.noData:
                          return Center(
                            child: Text(
                              'No Profile Found',
                              style: FontPalette.poppinsBold,
                            ),
                          );

                        //
                      }
                    },
                  ),
                ),
                //===============================================
                40.verticalSpace,
                ProfileTile(
                  childIcon: Padding(
                    padding: EdgeInsets.all(8.r),
                    child: Assets.icons.location.image(),
                  ),
                  title: "Manage Address",
                  onTap: () {
                    Navigator.pushNamed(
                        context, RouteGenerator.routeAddressScreen);
                  },
                ),

                5.verticalSpace,
                ProfileTile(
                  childIcon: Padding(
                    padding: EdgeInsets.all(10.r),
                    child: Assets.icons.terms.image(),
                  ),
                  title: "Terms Of Use",
                  onTap: () {},
                ),

                5.verticalSpace,
                ProfileTile(
                  childIcon: Padding(
                    padding: EdgeInsets.all(10.r),
                    child: Assets.icons.policy.image(),
                  ),
                  title: "Privacy Policy",
                  onTap: () {},
                ),

                5.verticalSpace,
                ProfileTile(
                  childIcon: Padding(
                    padding: EdgeInsets.all(11.r),
                    child: Assets.icons.logout.image(),
                  ),
                  title: "Logout",
                  onTap: () {},
                ),
              ],
            ),
          ),
        ).withBackgroundImage(),
      ),
    ));
  }
}
