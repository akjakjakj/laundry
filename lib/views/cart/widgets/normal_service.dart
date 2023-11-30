import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:laundry/utils/font_palette.dart';

import '../../../utils/color_palette.dart';

class NormalService extends StatefulWidget {
  const NormalService({super.key});

  @override
  State<NormalService> createState() => _NormalServiceState();
}

class _NormalServiceState extends State<NormalService> {
  TextEditingController pickDateInput = TextEditingController();
  TextEditingController deliveryDateInput = TextEditingController();

  @override
  void initState() {
    pickDateInput.text = "";
    deliveryDateInput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.825,
          // height: MediaQuery.of(context).size.height * 0.83,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SingleChildScrollView(
                child: Container(
                  // height: 500,
                  height: MediaQuery.of(context).size.height,
                  width: double.maxFinite,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        35.verticalSpace,
                        Container(
                            decoration: BoxDecoration(
                                color: const Color(0xfff3f3f4),
                                borderRadius: BorderRadius.circular(10.r)),
                            height: 50.h,
                            child: Center(
                                child: TextField(
                              controller: pickDateInput,
                              style: FontPalette.poppinsRegular.copyWith(
                                  color: const Color(0xff404041), fontSize: 13.sp),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                suffixIcon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 15,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 15.h),
                                hintText: "Select Pickup Date and Time",
                                hintStyle: FontPalette.poppinsRegular.copyWith(
                                    color: const Color(0xff404041),
                                    fontSize: 11.sp),
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2100));
      
                                if (pickedDate != null) {
                                  print(pickedDate);
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd').format(pickedDate);
                                  print(formattedDate);
                                  setState(() {
                                    pickDateInput.text = formattedDate;
                                  });
                                } else {}
                              },
                            ))),
                        12.verticalSpace,
                        Container(
                            decoration: BoxDecoration(
                                color: const Color(0xfff3f3f4),
                                borderRadius: BorderRadius.circular(10.r)),
                            height: 50.h,
                            child: Center(
                                child: TextField(
                              controller: deliveryDateInput,
                              style: FontPalette.poppinsRegular.copyWith(
                                  color: const Color(0xff404041), fontSize: 13.sp),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                suffixIcon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 15,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 15.h),
                                hintText: "Select Delivery Date and Time",
                                hintStyle: FontPalette.poppinsRegular.copyWith(
                                    color: const Color(0xff404041),
                                    fontSize: 11.sp),
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2100));
      
                                if (pickedDate != null) {
                                  print(pickedDate);
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd').format(pickedDate);
                                  print(formattedDate);
                                  setState(() {
                                    deliveryDateInput.text = formattedDate;
                                  });
                                } else {}
                              },
                            ))),
                        20.verticalSpace,
                        Text(
                          "Add Your Comments",
                          style: FontPalette.poppinsBold
                              .copyWith(color: Colors.black, fontSize: 11.sp),
                        ),
                        15.verticalSpace,
                        Container(
                          height: 100,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: const Color(0xfff3f3f4),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 10.h),
                                    border: InputBorder.none,
                                  ),
                                  maxLines: null,
                                  expands: true,
                                  keyboardType: TextInputType.multiline,
                                ),
                              ),
                            ],
                          ),
                        ),
                        15.verticalSpace,
                        Text(
                          "Your Items",
                          style: FontPalette.poppinsBold
                              .copyWith(color: Colors.black, fontSize: 10.sp),
                        ),
                        15.verticalSpace,
                        productCard(),
                        15.verticalSpace,
                        // 15.verticalSpace,
                        productCard(),
                        15.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                child: const Text('Continue shopping')),
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                child: const Text('Cancel Order'))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              //
              // total section
              Container(
                color: const Color(0xfff3f3f4),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                width: double.maxFinite,
                height: 100.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            "Total (incl. VAT): ",
                            style: FontPalette.poppinsRegular.copyWith(
                                color: const Color(0xff404041), fontSize: 12.sp),
                          ),
                          Flexible(
                            child: Text(
                              "AED 45.00",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: FontPalette.poppinsRegular.copyWith(
                                  color: ColorPalette.greenColor, fontSize: 15.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Text('Make Payment')),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget productCard() {
    return Container(
      height: 97.h,
      width: double.maxFinite,
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.network(
                    "https://i.ebayimg.com/images/g/BYIAAOSwR01jHCuS/s-l500.jpg",
                    height: 97.w,
                    width: 90.w,
                    fit: BoxFit.cover,
                  ),
                ),
                20.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        "Casual Shirt",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: FontPalette.poppinsRegular
                            .copyWith(color: Colors.black, fontSize: 15.sp),
                      ),
                    ),
                    Text(
                      "Steam ironing x (1)",
                      style: FontPalette.poppinsRegular.copyWith(
                          color: const Color(0xff404041), fontSize: 11.sp),
                    ),
                    20.verticalSpace,
                    Text(
                      "AED 45.00",
                      style: FontPalette.poppinsRegular.copyWith(
                          color: const Color(0xff076633), fontSize: 11.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),

          //quanity
          Row(
            children: [
              CircleAvatar(
                  radius: 10.r,
                  backgroundColor: ColorPalette.greenColor,
                  child: Text(
                    "-",
                    style: FontPalette.poppinsRegular
                        .copyWith(color: Colors.white, fontSize: 15.sp),
                  )),
              10.horizontalSpace,
              Text(
                "1",
                style: FontPalette.poppinsRegular
                    .copyWith(color: Colors.black, fontSize: 15.sp),
              ),
              10.horizontalSpace,
              CircleAvatar(
                  radius: 10.r,
                  backgroundColor: ColorPalette.greenColor,
                  child: Text(
                    "+",
                    style: FontPalette.poppinsRegular
                        .copyWith(color: Colors.white, fontSize: 15.sp),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
