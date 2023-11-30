import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/gen/assets.gen.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/profile/widget/profile_tile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              100.verticalSpace,
              // CircleAvatar(
              //     radius: 80,
              //     backgroundImage: NetworkImage(
              //         'https://eu.ui-avatars.com/api/?name=John+Doe')),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: const Color.fromARGB(255, 221, 221, 221),
                    child: Text(
                      "A",
                      style: FontPalette.poppinsRegular.copyWith(
                          color: ColorPalette.primaryColor, fontSize: 50.sp),
                    ),
                  ),
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
                "Sreejith MG",
                style: FontPalette.poppinsBold
                    .copyWith(color: Colors.black, fontSize: 14.sp),
              ),
              Text(
                "laundry@gmail.com",
                style: FontPalette.poppinsRegular
                    .copyWith(color: const Color(0XFF707071), fontSize: 14.sp),
              ),
              40.verticalSpace,
              ProfileTile(
                childIcon: Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Assets.icons.location.image(),
                ),
                title: "Manage Address",
                onTap: () {},
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
    ));
  }
}
