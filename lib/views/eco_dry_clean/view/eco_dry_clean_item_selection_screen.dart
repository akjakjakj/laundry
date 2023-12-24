import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/common_widgets/common_functions.dart';
import 'package:laundry/common_widgets/custom_button.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/eco_dry_clean/view/widgets/eco_dry_clean_products_shimmer.dart';
import 'package:laundry/views/eco_dry_clean/view/widgets/item_selection_widget.dart';
import 'package:laundry/views/eco_dry_clean/view/widgets/search_bar.dart';
import 'package:laundry/views/eco_dry_clean/view_model/eco_dry_view_model.dart';
import 'package:provider/provider.dart';

class EcoDryScreenItemSelectionScreen extends StatefulWidget {
  EcoDryScreenItemSelectionScreen(
      {Key? key,
      required this.categoryId,
      this.title,
      required this.ecoDryProvider})
      : super(key: key);
  final int categoryId;
  final String? title;
  final EcoDryProvider ecoDryProvider;

  @override
  _EcoDryScreenItemSelectionScreenState createState() =>
      _EcoDryScreenItemSelectionScreenState();
}

class _EcoDryScreenItemSelectionScreenState
    extends State<EcoDryScreenItemSelectionScreen> {
  @override
  void initState() {
    CommonFunctions.afterInit(() => widget.ecoDryProvider
      ..updateCategoryId(widget.categoryId)
      ..getProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            widget.title ?? '',
            style: FontPalette.poppinsBold
                .copyWith(color: Colors.black, fontSize: 17.sp),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: ChangeNotifierProvider.value(
          value: widget.ecoDryProvider,
          child: Consumer<EcoDryProvider>(builder: (context, provider, child) {
            switch (provider.loaderState) {
              case LoaderState.loading:
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        15.verticalSpace,
                        //const EcoDrySearchBar()
                        EcoDrySearchBar(
                          textEditingController:
                              provider.searchTexEditingController,
                          onEditComplete: () {
                            FocusScope.of(context).unfocus();
                            provider.getProductsWithSearch();
                          },
                        ),
                        const EcoDryCLeanProductsShimmer(),
                      ],
                    ),
                  ),
                );
              case LoaderState.loaded:
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      height: double.maxFinite,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            15.verticalSpace,
                            //const EcoDrySearchBar()
                            EcoDrySearchBar(
                              textEditingController:
                                  provider.searchTexEditingController,
                              onEditComplete: () {
                                FocusScope.of(context).unfocus();
                                provider.getProductsWithSearch();
                              },
                            ),

                            Column(
                              children: [
                                10.verticalSpace,
                                GridView.builder(
                                  itemCount: provider.productsList.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 23.h,
                                          mainAxisExtent: 280.h,
                                          crossAxisSpacing: 12.w),
                                  itemBuilder: (context, index) =>
                                      ItemSelectionWidget(
                                    ecoDryProvider: widget.ecoDryProvider,
                                    productItem: provider.productsList[index],
                                  ),
                                ),
                                70.verticalSpace
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    CustomButton(
                      title: 'Go To Cart',
                      decoration: BoxDecoration(
                          color: ColorPalette.greenColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              topRight: Radius.circular(10.r))),
                    )
                  ],
                );
              case LoaderState.error:
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    children: [
                      EcoDrySearchBar(
                        textEditingController:
                            provider.searchTexEditingController,
                        onEditComplete: () {
                          FocusScope.of(context).unfocus();
                          provider.getProductsWithSearch();
                        },
                      ),
                      Center(
                        child: Text('Oops...! Error',
                            style: FontPalette.poppinsBold),
                      ),
                    ],
                  ),
                );
              case LoaderState.noData:
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    children: [
                      EcoDrySearchBar(
                        textEditingController:
                            provider.searchTexEditingController,
                        onEditComplete: () {
                          FocusScope.of(context).unfocus();
                          provider.getProductsWithSearch();
                        },
                      ),
                      Center(
                        child: Text('Oops...! Error',
                            style: FontPalette.poppinsBold),
                      ),
                    ],
                  ),
                );
              case LoaderState.noProducts:
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    children: [
                      EcoDrySearchBar(
                        textEditingController:
                            provider.searchTexEditingController,
                        onEditComplete: () {
                          FocusScope.of(context).unfocus();
                          provider.getProductsWithSearch();
                        },
                      ),
                      Center(
                        child: Text('Oops...! Error',
                            style: FontPalette.poppinsBold),
                      ),
                    ],
                  ),
                );
              case LoaderState.networkErr:
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    children: [
                      EcoDrySearchBar(
                        textEditingController:
                            provider.searchTexEditingController,
                        onEditComplete: () {
                          FocusScope.of(context).unfocus();
                          provider.getProductsWithSearch();
                        },
                      ),
                      Center(
                        child: Text('Oops...! Error',
                            style: FontPalette.poppinsBold),
                      ),
                    ],
                  ),
                );
            }
          }),
        ).withBackgroundImage(),
      ),
    );
  }
}
