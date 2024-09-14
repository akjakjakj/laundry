import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common_widgets/common_functions.dart';
import 'package:laundry/common_widgets/custom_linear_progress_indicator.dart';
import 'package:laundry/utils/enums.dart';
import 'package:laundry/utils/font_palette.dart';
import 'package:laundry/views/eco_dry_clean/view_model/eco_dry_view_model.dart';
import 'package:provider/provider.dart';

class PricePdfView extends StatefulWidget {
  const PricePdfView({super.key, this.ecoDryProvider, this.index});
  final EcoDryProvider? ecoDryProvider;
  final int? index;
  @override
  State<PricePdfView> createState() => _PricePdfViewState();
}

class _PricePdfViewState extends State<PricePdfView> {
  ValueNotifier<bool> isLoading = ValueNotifier(true);
  @override
  void initState() {
    CommonFunctions.afterInit(() {
      if (widget.index == 0) {
        widget.ecoDryProvider?.downloadAndSavePDF(
            widget.ecoDryProvider?.priceListResponse?.priceList?[0].normal ??
                '');
      } else {
        widget.ecoDryProvider?.downloadAndSavePDF(
            widget.ecoDryProvider?.priceListResponse?.priceList?[0].express ??
                '');
      }
      // if (widget.index == 0) {
      //   widget.ecoDryProvider?.createFileOfPdfUrl(
      //       widget.ecoDryProvider?.priceListResponse?.priceList?[0].normal ??
      //           '');
      // } else {
      //   widget.ecoDryProvider?.createFileOfPdfUrl(
      //       widget.ecoDryProvider?.priceListResponse?.priceList?[0].express ??
      //           '');
      // }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider.value(
        value: widget.ecoDryProvider,
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
              'Price List',
              style: FontPalette.poppinsBold
                  .copyWith(color: Colors.black, fontSize: 17.sp),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Consumer<EcoDryProvider>(
            builder: (context, provider, child) {
              switch (provider.loaderState) {
                case LoaderState.loading:
                  return const CustomLinearProgress();
                case LoaderState.loaded:
                  return PDFView(
                    filePath: widget.ecoDryProvider?.file?.path,
                    onRender: (pages) => isLoading.value = false,
                  );
                case LoaderState.noProducts:
                  return Center(
                    child: Text(
                      'No categories found',
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
                  return Expanded(
                    child: Center(
                      child: Text('Oops...! Error',
                          style: FontPalette.poppinsBold),
                    ),
                  );
                case LoaderState.noData:
                  return Center(
                    child: Text(
                      'No Data Found',
                      style: FontPalette.poppinsBold,
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
